#include <stdio.h>
#include <exception>
#include <vector>
#include <windows.h>

struct SimpleBuffer
{
  char* p;

  SimpleBuffer (size_t size) : p (new char[size]) {}
  ~SimpleBuffer() { delete[] p; }
};

/*class PEImageException : public std::exception
{
};*/

namespace PE
{
  struct ImportModule
  {
    virtual const char* GetModuleName() = 0;
    virtual void SetModuleName (DWORD nameVA) = 0;
  };
  struct Section;
  struct ImportTable
  {
    virtual ~ImportTable() {}

    virtual ImportModule** begin() = 0;
    virtual ImportModule** end() = 0;

    virtual Section* GetImportsSection() = 0;
  };
  struct Section
  {
    virtual ~Section() {}

    virtual void MakeDataPrivate () = 0;
    virtual DWORD AppendData (const char* data, size_t dataSize) = 0;
    virtual const char* GetPointerForVA (DWORD va) = 0;
  };

  class Image
  {
    static char errorDescr[256];

    struct ImageTypes32
    {
      typedef IMAGE_NT_HEADERS32 NTHeader;
      typedef DWORD VAType;
    };
    struct ImageTypes64
    {
      typedef IMAGE_NT_HEADERS64 NTHeader;
      typedef ULONGLONG VAType;
    };

    struct WorkerBase
    {
      virtual ~WorkerBase() {}

      virtual ImportTable* GetImportTable() = 0;
      virtual void WriteOut (FILE* file) = 0;
    };
    template<typename ImageTypes>
    class WorkerImpl : public WorkerBase
    {
      const char* imageData;
      const typename ImageTypes::NTHeader* ntHeader;

      class SectionImpl : public Section,
			  public IMAGE_SECTION_HEADER
      {
	WorkerImpl* worker;
	char* newData;
      public:
	SectionImpl (WorkerImpl* worker, const IMAGE_SECTION_HEADER& header)
	  : IMAGE_SECTION_HEADER (header), worker (worker), newData (0)
	{
	}
	SectionImpl (const SectionImpl& other) : IMAGE_SECTION_HEADER (other), worker (other.worker)
	{
	  if (other.newData != 0)
	  {
	    newData = (char*)malloc (SizeOfRawData);
	    memcpy (newData, other.newData, SizeOfRawData);
	  }
	  else
	    newData = 0;
	}
	~SectionImpl()
	{
	  if (newData != 0) free (newData);
	}

	void MakeDataPrivate ()
	{
	  if (newData == 0)
	  {
	    newData = (char*)malloc (SizeOfRawData);
	    memcpy (newData, worker->imageData+PointerToRawData, SizeOfRawData);
	  }
	}
	DWORD AppendData (const char* data, size_t dataSize)
	{
	  DWORD newVA = Misc.VirtualSize;
	  if (Misc.VirtualSize+dataSize > SizeOfRawData)
	  {
	    throw std::exception ("not enough slack after section end to append data");
	  }
	  MakeDataPrivate ();
	  memcpy (newData+newVA, data, dataSize);
	  Misc.VirtualSize += dataSize;
	  return VirtualAddress+newVA;
	}
	const char* GetData() const { return newData ? newData : worker->imageData+PointerToRawData; }

	const char* GetPointerForVA (DWORD va)
	{
	  if (va < VirtualAddress) return 0;
	  DWORD vaOffs = va-VirtualAddress;
	  if (vaOffs >= SizeOfRawData) return 0;
	  return GetData()+vaOffs;
	}
      };
      std::vector<SectionImpl> sections;

      class ImportTableImpl : public ImportTable
      {
	class ImportModuleImpl : public ImportModule
	{
	  WorkerImpl* worker;
	  DWORD importVA;
	public:
	  ImportModuleImpl (WorkerImpl* worker, DWORD importVA)
	    : worker (worker), importVA (importVA) {}

	  const IMAGE_IMPORT_DESCRIPTOR* GetImport()
	  {
	    return reinterpret_cast<const IMAGE_IMPORT_DESCRIPTOR*> (worker->GetImagePointerForVA (importVA));
	  }
	  
	  const char* GetModuleName() { return worker->GetImagePointerForVA (GetImport()->Name); }
	  void SetModuleName (DWORD nameVA)
	  {
  	    Section* importsSection = worker->GetSectionForVA (importVA);
	    importsSection->MakeDataPrivate ();
	    IMAGE_IMPORT_DESCRIPTOR* import = const_cast<IMAGE_IMPORT_DESCRIPTOR*> (GetImport());
	    import->Name = nameVA;
	  }
	};
	ImportModule** importModules;
	size_t numModules;
	Section* importsSection;
      public:
	ImportTableImpl (WorkerImpl* worker, DWORD tableVA) : importModules (0)
	{
	  importsSection = worker->GetSectionForVA (tableVA);
	  const IMAGE_IMPORT_DESCRIPTOR* import =
	    reinterpret_cast<const IMAGE_IMPORT_DESCRIPTOR*> (worker->GetImagePointerForVA (tableVA));
	  static const IMAGE_IMPORT_DESCRIPTOR nullImport = {0};

	  std::vector<DWORD> imports;
	  while (memcmp (import, &nullImport, sizeof (IMAGE_IMPORT_DESCRIPTOR)) != 0)
	  {
	    imports.push_back (tableVA);
	    import++;
	    tableVA += sizeof (IMAGE_IMPORT_DESCRIPTOR);
	  }
	  numModules = imports.size();
	  importModules = new ImportModule*[numModules];
	  for (size_t i = 0; i < numModules; i++)
	  {
	    importModules[i] = new ImportModuleImpl (worker, imports[i]);
	  }
	}
	~ImportTableImpl()
	{
	  if (importModules != 0)
	  {
	    for (size_t i = 0; i < numModules; i++)
	      delete importModules[i];
	    delete[] importModules;
	  }
	}

	ImportModule** begin() { return importModules; }
	ImportModule** end() { return importModules+numModules; }

	Section* GetImportsSection() { return importsSection; }
      };

      void fwrite_checked (const void* data, size_t size, FILE* file)
      {
	if (fwrite (data, 1, size, file) != size)
	{
	  sprintf_s (errorDescr, "error writing %lu bytes", (unsigned long)size);
	  throw std::exception (errorDescr);
	}
      }
      void AlignFilePos (FILE* file)
      {
        size_t currentPos = ftell (file);
        size_t align = ntHeader->OptionalHeader.FileAlignment;
        size_t alignedPos = ((currentPos + align-1)/align)*align;
        fseek (file, alignedPos, SEEK_SET);
      }
    public:
      WorkerImpl (const char* imageData, const typename ImageTypes::NTHeader* ntHeader) :
	imageData (imageData), ntHeader (ntHeader)
      {
	size_t numSections = ntHeader->FileHeader.NumberOfSections;
	const IMAGE_SECTION_HEADER* ntSections = IMAGE_FIRST_SECTION (ntHeader);
	for (size_t i = 0; i < numSections; i++)
	{
	  sections.push_back (SectionImpl (this, ntSections[i]));
	}
      }

      Section* GetSectionForVA (DWORD va)
      {
	for (size_t i = 0; i < sections.size(); i++)
	{
	  if ((va >= sections[i].VirtualAddress) && (va < sections[i].VirtualAddress+sections[i].Misc.VirtualSize))
	  {
	    return &(sections[i]);
	  }
	}
	return 0;
      }

      const char* GetImagePointerForVA (DWORD va)
      {
	Section* section = GetSectionForVA (va);
	if (section != 0)
	{
	  return section->GetPointerForVA (va);
	}
	return 0;
      }

      ImportTable* GetImportTable()
      {
	DWORD importVA = ntHeader->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress;
	if (importVA == 0)
	  return 0;

	return new ImportTableImpl (this, importVA);
      }

      void WriteOut (FILE* file)
      {
	const char* headerEnd = (const char*)(IMAGE_FIRST_SECTION (ntHeader));
	fwrite_checked (imageData, headerEnd-imageData, file);
	size_t sectionsPos = ftell (file);
	fseek (file, sectionsPos + (sections.size() * sizeof (IMAGE_SECTION_HEADER)), SEEK_SET);
	for (size_t i = 0; i < sections.size(); i++)
	{
	  AlignFilePos (file);
	  sections[i].PointerToRawData = ftell (file);
	  fwrite_checked (sections[i].GetData(), sections[i].SizeOfRawData, file);
	}
	AlignFilePos (file);
	fseek (file, sectionsPos, SEEK_SET);
	for (size_t i = 0; i < sections.size(); i++)
	{
	  IMAGE_SECTION_HEADER* sectionHeader = &(sections[i]);
	  fwrite_checked (sectionHeader, sizeof (IMAGE_SECTION_HEADER), file);
	}
      }
    };

    WorkerBase* worker;
    ImportTable* imports;
  public:
    Image (const char* data, size_t imageDataSize) : worker (0), imports (0)
    {
      const IMAGE_DOS_HEADER* dosHeader = reinterpret_cast<const IMAGE_DOS_HEADER*> (data);
      if (dosHeader->e_magic != IMAGE_DOS_SIGNATURE)
	throw std::exception ("invalid image");

      const IMAGE_NT_HEADERS* ntHeader = reinterpret_cast<const IMAGE_NT_HEADERS*> (data+dosHeader->e_lfanew);
      if (ntHeader->Signature != IMAGE_NT_SIGNATURE)
	throw std::exception ("invalid image");

      switch (ntHeader->OptionalHeader.Magic)
      {
      case IMAGE_NT_OPTIONAL_HDR32_MAGIC:
	worker = new WorkerImpl<ImageTypes32> (data, reinterpret_cast<const IMAGE_NT_HEADERS32*> (ntHeader));
	break;
      case IMAGE_NT_OPTIONAL_HDR64_MAGIC:
	worker = new WorkerImpl<ImageTypes64> (data, reinterpret_cast<const IMAGE_NT_HEADERS64*> (ntHeader));
	break;
      default:
	sprintf_s (errorDescr, "unsupport optional header magic: %x", ntHeader->OptionalHeader.Magic);
      }
    }
    ~Image ()
    {
      delete worker;
    }

    ImportTable* GetImportTable()
    {
      if (imports == 0) imports = worker->GetImportTable();
      return imports;
    }

    void WriteOut (FILE* file)
    {
      worker->WriteOut (file);
    }
  };

  char Image::errorDescr[];
} // namespace PE

int main (int argc, char const* const argv[])
{
  if (argc != 4)
  {
    printf ("Tool to change the name of an imported dll\n\n");
    printf ("Syntax:\n");
    printf ("  %s <dll to change> <old import> <new import>\n", argv[0]);
    return 1;
  }

  const char* dll = argv[1];
  const char* oldImport = argv[2];
  const char* newImport = argv[3];

  FILE* imageFile = fopen (dll, "rb");
  if (imageFile != 0)
  {
    fseek (imageFile, 0, SEEK_END);
    long imageSize = ftell (imageFile);
    fseek (imageFile, 0, SEEK_SET);
    SimpleBuffer imageData (imageSize);
    fread (imageData.p, 1, imageSize, imageFile);
    fclose (imageFile);

    try
    {
      bool changed = false;
      PE::Image image (imageData.p, imageSize);
      PE::ImportTable* imports = image.GetImportTable();
      for (PE::ImportModule** mod = imports->begin(); mod != imports->end(); mod++)
      {
	const char* modName = (*mod)->GetModuleName();
	if (strcmp (modName, oldImport) == 0)
	{
	  PE::Section* section = imports->GetImportsSection();
	  DWORD newNameVA = section->AppendData (newImport, strlen (newImport)+1);
	  (*mod)->SetModuleName (newNameVA);
	  changed = true;
	}
      }

      if (!changed)
	printf ("%s has not been changed\n", dll);
      else
      {
	FILE* imageFile = fopen (dll, "wb");
	if (imageFile == 0) throw std::exception ("error opening dll for writing");
	image.WriteOut (imageFile);
	fclose (imageFile);
      }
    }
    catch(const std::exception& e)
    {
      printf ("exception: %s\n", e.what());
    }
  }
  else
    return 1;

  return 0;
}
