

/*
 *
 * Copyright (c) 2002, NVIDIA Corporation.
 * 
 *  
 * 
 * NVIDIA Corporation("NVIDIA") supplies this software to you in consideration 
 * of your agreement to the following terms, and your use, installation, 
 * modification or redistribution of this NVIDIA software constitutes 
 * acceptance of these terms.  If you do not agree with these terms, please do 
 * not use, install, modify or redistribute this NVIDIA software.
 * 
 *  
 * 
 * In consideration of your agreement to abide by the following terms, and 
 * subject to these terms, NVIDIA grants you a personal, non-exclusive license,
 * under NVIDIA�s copyrights in this original NVIDIA software (the "NVIDIA 
 * Software"), to use, reproduce, modify and redistribute the NVIDIA 
 * Software, with or without modifications, in source and/or binary forms; 
 * provided that if you redistribute the NVIDIA Software, you must retain the 
 * copyright notice of NVIDIA, this notice and the following text and 
 * disclaimers in all such redistributions of the NVIDIA Software. Neither the 
 * name, trademarks, service marks nor logos of NVIDIA Corporation may be used 
 * to endorse or promote products derived from the NVIDIA Software without 
 * specific prior written permission from NVIDIA.  Except as expressly stated 
 * in this notice, no other rights or licenses express or implied, are granted 
 * by NVIDIA herein, including but not limited to any patent rights that may be 
 * infringed by your derivative works or by other works in which the NVIDIA 
 * Software may be incorporated. No hardware is licensed hereunder. 
 * 
 *  
 * 
 * THE NVIDIA SOFTWARE IS BEING PROVIDED ON AN "AS IS" BASIS, WITHOUT 
 * WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING 
 * WITHOUT LIMITATION, WARRANTIES OR CONDITIONS OF TITLE, NON-INFRINGEMENT, 
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR ITS USE AND OPERATION 
 * EITHER ALONE OR IN COMBINATION WITH OTHER PRODUCTS.
 * 
 *  
 * 
 * IN NO EVENT SHALL NVIDIA BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL, 
 * EXEMPLARY, CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, LOST 
 * PROFITS; PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR 
 * PROFITS; OR BUSINESS INTERRUPTION) OR ARISING IN ANY WAY OUT OF THE USE, 
 * REPRODUCTION, MODIFICATION AND/OR DISTRIBUTION OF THE NVIDIA SOFTWARE, 
 * HOWEVER CAUSED AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING 
 * NEGLIGENCE), STRICT LIABILITY OR OTHERWISE, EVEN IF NVIDIA HAS BEEN ADVISED 
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 * 
 */ 


/* 
 * The following macro invocations define the supported CG basic hardware 
 * bind locations.
 *
 * The macros have the form :
 *
 *   CG_BINDLOCATION_MACRO(name, compiler_name, enum_int)
 *
 *     name          : The name of the location.
 *     enum_name     : The C enumerant.
 *     compiler_name : The name of the location within the compiler syntax.
 *     int_id        : Integer enumerant associated with this bind location.
 *     addressable   : The bind location must have an integer address 
 *                     associated with it.
 *     ParamType     : the cgParamType of this register. 
 *   
 */


CG_BINDLOCATION_MACRO(TexUnit0,CG_TEXUNIT0,"texunit 0",2048,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit1,CG_TEXUNIT1,"texunit 1",2049,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit2,CG_TEXUNIT2,"texunit 2",2050,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit3,CG_TEXUNIT3,"texunit 3",2051,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit4,CG_TEXUNIT4,"texunit 4",2052,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit5,CG_TEXUNIT5,"texunit 5",2053,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit6,CG_TEXUNIT6,"texunit 6",2054,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit7,CG_TEXUNIT7,"texunit 7",2055,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit8,CG_TEXUNIT8,"texunit 8",2056,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit9,CG_TEXUNIT9,"texunit 9",2057,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit10,CG_TEXUNIT10,"texunit 10",2058,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit11,CG_TEXUNIT11,"texunit 11",2059,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit12,CG_TEXUNIT12,"texunit 12",2060,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit13,CG_TEXUNIT13,"texunit 13",2061,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit14,CG_TEXUNIT14,"texunit 14",2062,0,CG_TEXOBJ_PARAM)
CG_BINDLOCATION_MACRO(TexUnit15,CG_TEXUNIT15,"texunit 15",2063,0,CG_TEXOBJ_PARAM)

CG_BINDLOCATION_MACRO(Attr0,CG_ATTR0,"ATTR0",2113,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr1,CG_ATTR1,"ATTR1",2114,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr2,CG_ATTR2,"ATTR2",2115,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr3,CG_ATTR3,"ATTR3",2116,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr4,CG_ATTR4,"ATTR4",2117,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr5,CG_ATTR5,"ATTR5",2118,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr6,CG_ATTR6,"ATTR6",2119,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr7,CG_ATTR7,"ATTR7",2120,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr8,CG_ATTR8,"ATTR8",2121,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr9,CG_ATTR9,"ATTR9",2122,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr10,CG_ATTR10,"ATTR10",2123,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr11,CG_ATTR11,"ATTR11",2124,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr12,CG_ATTR12,"ATTR12",2125,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr13,CG_ATTR13,"ATTR13",2126,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr14,CG_ATTR14,"ATTR14",2127,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Attr15,CG_ATTR15,"ATTR15",2128,0,CG_VARYING_PARAM)

CG_BINDLOCATION_MACRO(VertUniform,CG_C,"c",2178,1,CGI_UNIFORM_PARAM)

CG_BINDLOCATION_MACRO(Tex0,CG_TEX0,"TEX0",2179,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tex1,CG_TEX1,"TEX1",2180,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tex2,CG_TEX2,"TEX2",2181,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tex3,CG_TEX3,"TEX3",2192,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tex4,CG_TEX4,"TEX4",2193,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tex5,CG_TEX5,"TEX5",2194,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tex6,CG_TEX6,"TEX6",2195,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tex7,CG_TEX7,"TEX7",2196,0,CG_VARYING_PARAM)

CG_BINDLOCATION_MACRO(HPos,CG_HPOS,"HPOS",2243,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Col0,CG_COL0,"COL0",2245,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Col1,CG_COL1,"COL1",2246,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Col2,CG_COL2,"COL2",2247,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Col3,CG_COL3,"COL3",2248,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSiz,CG_PSIZ,"PSIZ",2309,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(WPos,CG_WPOS,"WPOS",2373,0,CG_VARYING_PARAM)

CG_BINDLOCATION_MACRO(Position0,CG_POSITION0,"POSITION0",2437,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position1,CG_POSITION1,"POSITION1",2438,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position2,CG_POSITION2,"POSITION2",2439,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position3,CG_POSITION3,"POSITION3",2440,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position4,CG_POSITION4,"POSITION4",2441,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position5,CG_POSITION5,"POSITION5",2442,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position6,CG_POSITION6,"POSITION6",2443,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position7,CG_POSITION7,"POSITION7",2444,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position8,CG_POSITION8,"POSITION8",2445,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position9,CG_POSITION9,"POSITION9",2446,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position10,CG_POSITION10,"POSITION10",2447,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position11,CG_POSITION11,"POSITION11",2448,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position12,CG_POSITION12,"POSITION12",2449,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position13,CG_POSITION13,"POSITION13",2450,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position14,CG_POSITION14,"POSITION14",2451,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Position15,CG_POSITION15,"POSITION15",2452,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Diffuse0,CG_DIFFUSE0,"DIFFUSE0",2501,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent0,CG_TANGENT0,"TANGENT0",2565,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent1,CG_TANGENT1,"TANGENT1",2566,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent2,CG_TANGENT2,"TANGENT2",2567,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent3,CG_TANGENT3,"TANGENT3",2568,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent4,CG_TANGENT4,"TANGENT4",2569,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent5,CG_TANGENT5,"TANGENT5",2570,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent6,CG_TANGENT6,"TANGENT6",2571,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent7,CG_TANGENT7,"TANGENT7",2572,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent8,CG_TANGENT8,"TANGENT8",2573,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent9,CG_TANGENT9,"TANGENT9",2574,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent10,CG_TANGENT10,"TANGENT10",2575,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent11,CG_TANGENT11,"TANGENT11",2576,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent12,CG_TANGENT12,"TANGENT12",2577,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent13,CG_TANGENT13,"TANGENT13",2578,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent14,CG_TANGENT14,"TANGENT14",2579,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Tangent15,CG_TANGENT15,"TANGENT15",2580,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Specular0,CG_SPECULAR0,"SPECULAR0",2629,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices0,CG_BLENDINDICES0,"BLENDINDICES0",2693,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices1,CG_BLENDINDICES1,"BLENDINDICES1",2694,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices2,CG_BLENDINDICES2,"BLENDINDICES2",2695,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices3,CG_BLENDINDICES3,"BLENDINDICES3",2696,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices4,CG_BLENDINDICES4,"BLENDINDICES4",2697,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices5,CG_BLENDINDICES5,"BLENDINDICES5",2698,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices6,CG_BLENDINDICES6,"BLENDINDICES6",2699,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices7,CG_BLENDINDICES7,"BLENDINDICES7",2700,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices8,CG_BLENDINDICES8,"BLENDINDICES8",2701,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices9,CG_BLENDINDICES9,"BLENDINDICES9",2702,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices10,CG_BLENDINDICES10,"BLENDINDICES10",2703,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices11,CG_BLENDINDICES11,"BLENDINDICES11",2704,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices12,CG_BLENDINDICES12,"BLENDINDICES12",2705,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices13,CG_BLENDINDICES13,"BLENDINDICES13",2706,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices14,CG_BLENDINDICES14,"BLENDINDICES14",2707,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendIndices15,CG_BLENDINDICES15,"BLENDINDICES15",2708,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color0,CG_COLOR0,"COLOR0",2757,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color1,CG_COLOR1,"COLOR1",2758,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color2,CG_COLOR2,"COLOR2",2759,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color3,CG_COLOR3,"COLOR3",2760,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color4,CG_COLOR4,"COLOR4",2761,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color5,CG_COLOR5,"COLOR5",2762,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color6,CG_COLOR6,"COLOR6",2763,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color7,CG_COLOR7,"COLOR7",2764,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color8,CG_COLOR8,"COLOR8",2765,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color9,CG_COLOR9,"COLOR9",2766,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color10,CG_COLOR10,"COLOR10",2767,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color11,CG_COLOR11,"COLOR11",2768,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color12,CG_COLOR12,"COLOR12",2769,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color13,CG_COLOR13,"COLOR13",2770,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color14,CG_COLOR14,"COLOR14",2771,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Color15,CG_COLOR15,"COLOR15",2772,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize0,CG_PSIZE0,"PSIZE0",2821,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize1,CG_PSIZE1,"PSIZE1",2822,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize2,CG_PSIZE2,"PSIZE2",2823,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize3,CG_PSIZE3,"PSIZE3",2824,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize4,CG_PSIZE4,"PSIZE4",2825,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize5,CG_PSIZE5,"PSIZE5",2826,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize6,CG_PSIZE6,"PSIZE6",2827,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize7,CG_PSIZE7,"PSIZE7",2828,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize8,CG_PSIZE8,"PSIZE8",2829,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize9,CG_PSIZE9,"PSIZE9",2830,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize10,CG_PSIZE10,"PSIZE10",2831,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize11,CG_PSIZE11,"PSIZE11",2832,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize12,CG_PSIZE12,"PSIZE12",2833,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize13,CG_PSIZE13,"PSIZE13",2834,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize14,CG_PSIZE14,"PSIZE14",2835,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(PSize15,CG_PSIZE15,"PSIZE15",2836,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal0,CG_BINORMAL0,"BINORMAL0",2885,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal1,CG_BINORMAL1,"BINORMAL1",2886,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal2,CG_BINORMAL2,"BINORMAL2",2887,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal3,CG_BINORMAL3,"BINORMAL3",2888,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal4,CG_BINORMAL4,"BINORMAL4",2889,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal5,CG_BINORMAL5,"BINORMAL5",2890,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal6,CG_BINORMAL6,"BINORMAL6",2891,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal7,CG_BINORMAL7,"BINORMAL7",2892,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal8,CG_BINORMAL8,"BINORMAL8",2893,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal9,CG_BINORMAL9,"BINORMAL9",2894,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal10,CG_BINORMAL10,"BINORMAL10",2895,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal11,CG_BINORMAL11,"BINORMAL11",2896,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal12,CG_BINORMAL12,"BINORMAL12",2897,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal13,CG_BINORMAL13,"BINORMAL13",2898,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal14,CG_BINORMAL14,"BINORMAL14",2899,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BiNormal15,CG_BINORMAL15,"BINORMAL15",2900,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG0,CG_FOG0,"FOG0",2917,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG1,CG_FOG1,"FOG1",2918,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG2,CG_FOG2,"FOG2",2919,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG3,CG_FOG3,"FOG3",2920,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG4,CG_FOG4,"FOG4",2921,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG5,CG_FOG5,"FOG5",2922,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG6,CG_FOG6,"FOG6",2923,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG7,CG_FOG7,"FOG7",2924,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG8,CG_FOG8,"FOG8",2925,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG9,CG_FOG9,"FOG9",2926,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG10,CG_FOG10,"FOG10",2927,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG11,CG_FOG11,"FOG11",2928,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG12,CG_FOG12,"FOG12",2929,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG13,CG_FOG13,"FOG13",2930,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG14,CG_FOG14,"FOG14",2931,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FOG15,CG_FOG15,"FOG15",2932,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH0,CG_DEPTH0,"DEPTH0",2933,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH1,CG_DEPTH1,"DEPTH1",2934,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH2,CG_DEPTH2,"DEPTH2",2935,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH3,CG_DEPTH3,"DEPTH3",2936,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH4,CG_DEPTH4,"DEPTH4",2937,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH5,CG_DEPTH5,"DEPTH5",2938,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH6,CG_DEPTH6,"DEPTH6",2939,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH7,CG_DEPTH7,"DEPTH7",2940,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH8,CG_DEPTH8,"DEPTH8",2941,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH9,CG_DEPTH9,"DEPTH9",29542,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH10,CG_DEPTH10,"DEPTH10",2943,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH11,CG_DEPTH11,"DEPTH11",2944,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH12,CG_DEPTH12,"DEPTH12",2945,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH13,CG_DEPTH13,"DEPTH13",2946,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH14,CG_DEPTH14,"DEPTH14",2947,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(DEPTH15,CG_DEPTH15,"DEPTH15",2948,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE0,CG_SAMPLE0,"SAMPLE0",2949,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE1,CG_SAMPLE1,"SAMPLE1",2950,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE2,CG_SAMPLE2,"SAMPLE2",2951,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE3,CG_SAMPLE3,"SAMPLE3",2952,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE4,CG_SAMPLE4,"SAMPLE4",2953,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE5,CG_SAMPLE5,"SAMPLE5",2954,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE6,CG_SAMPLE6,"SAMPLE6",2955,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE7,CG_SAMPLE7,"SAMPLE7",2956,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE8,CG_SAMPLE8,"SAMPLE8",2957,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE9,CG_SAMPLE9,"SAMPLE9",2958,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE10,CG_SAMPLE10,"SAMPLE10",2959,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE11,CG_SAMPLE11,"SAMPLE11",2960,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE12,CG_SAMPLE12,"SAMPLE12",2961,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE13,CG_SAMPLE13,"SAMPLE13",2962,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE14,CG_SAMPLE14,"SAMPLE14",2963,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(SAMPLE15,CG_SAMPLE15,"SAMPLE15",2964,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight0,CG_BLENDWEIGHT0,"BLENDWEIGHT0",3028,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight1,CG_BLENDWEIGHT1,"BLENDWEIGHT1",3029,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight2,CG_BLENDWEIGHT2,"BLENDWEIGHT2",3030,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight3,CG_BLENDWEIGHT3,"BLENDWEIGHT3",3031,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight4,CG_BLENDWEIGHT4,"BLENDWEIGHT4",3032,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight5,CG_BLENDWEIGHT5,"BLENDWEIGHT5",3033,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight6,CG_BLENDWEIGHT6,"BLENDWEIGHT6",3034,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight7,CG_BLENDWEIGHT7,"BLENDWEIGHT7",3035,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight8,CG_BLENDWEIGHT8,"BLENDWEIGHT8",3036,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight9,CG_BLENDWEIGHT9,"BLENDWEIGHT9",3037,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight10,CG_BLENDWEIGHT10,"BLENDWEIGHT10",3038,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight11,CG_BLENDWEIGHT11,"BLENDWEIGHT11",3039,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight12,CG_BLENDWEIGHT12,"BLENDWEIGHT12",3040,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight13,CG_BLENDWEIGHT13,"BLENDWEIGHT13",3041,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight14,CG_BLENDWEIGHT14,"BLENDWEIGHT14",3042,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(BlendWeight15,CG_BLENDWEIGHT15,"BLENDWEIGHT15",3043,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal0,CG_NORMAL0,"NORMAL0",3092,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal1,CG_NORMAL1,"NORMAL1",3093,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal2,CG_NORMAL2,"NORMAL2",3094,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal3,CG_NORMAL3,"NORMAL3",3095,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal4,CG_NORMAL4,"NORMAL4",3096,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal5,CG_NORMAL5,"NORMAL5",3097,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal6,CG_NORMAL6,"NORMAL6",3098,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal7,CG_NORMAL7,"NORMAL7",3099,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal8,CG_NORMAL8,"NORMAL8",3100,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal9,CG_NORMAL9,"NORMAL9",3101,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal10,CG_NORMAL10,"NORMAL10",3102,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal11,CG_NORMAL11,"NORMAL11",3103,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal12,CG_NORMAL12,"NORMAL12",3104,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal13,CG_NORMAL13,"NORMAL13",3105,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal14,CG_NORMAL14,"NORMAL14",3106,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(Normal15,CG_NORMAL15,"NORMAL15",3107,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(FogCoord,CG_FOGCOORD,"FOGCOORD",3156,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord0,CG_TEXCOORD0,"TEXCOORD0",3220,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord1,CG_TEXCOORD1,"TEXCOORD1",3221,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord2,CG_TEXCOORD2,"TEXCOORD2",3222,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord3,CG_TEXCOORD3,"TEXCOORD3",3223,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord4,CG_TEXCOORD4,"TEXCOORD4",3224,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord5,CG_TEXCOORD5,"TEXCOORD5",3225,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord6,CG_TEXCOORD6,"TEXCOORD6",3226,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord7,CG_TEXCOORD7,"TEXCOORD7",3227,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord8,CG_TEXCOORD8,"TEXCOORD8",3228,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord9,CG_TEXCOORD9,"TEXCOORD9",3229,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord10,CG_TEXCOORD10,"TEXCOORD10",3230,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord11,CG_TEXCOORD11,"TEXCOORD11",3231,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord12,CG_TEXCOORD12,"TEXCOORD12",3232,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord13,CG_TEXCOORD13,"TEXCOORD13",3233,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord14,CG_TEXCOORD14,"TEXCOORD14",3234,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(TexCoord15,CG_TEXCOORD15,"TEXCOORD15",3235,0,CG_VARYING_PARAM)
CG_BINDLOCATION_MACRO(CombinerConst0,CG_COMBINER_CONST0,"COMBINER_CONST0",3284,0,CGI_UNIFORM_PARAM)
CG_BINDLOCATION_MACRO(CombinerConst1,CG_COMBINER_CONST1,"COMBINER_CONST1",3285,0,CGI_UNIFORM_PARAM)
CG_BINDLOCATION_MACRO(CombinerStageConst0,CG_COMBINER_STAGE_CONST0,"COMBINER_STAGE_CONST0",3286,1,CGI_UNIFORM_PARAM)
CG_BINDLOCATION_MACRO(CombinerStageConst1,CG_COMBINER_STAGE_CONST1,"COMBINER_STAGE_CONST1",3287,1,CGI_UNIFORM_PARAM)
CG_BINDLOCATION_MACRO(OffsetTextureMatrix,CG_OFFSET_TEXTURE_MATRIX,"OFFSET_TEXTURE_MATRIX",3288,0,CGI_UNIFORM_PARAM)
CG_BINDLOCATION_MACRO(OffsetTextureScale,CG_OFFSET_TEXTURE_SCALE,"OFFSET_TEXTURE_SCALE",3289,0,CGI_UNIFORM_PARAM)
CG_BINDLOCATION_MACRO(OffsetTextureBias,CG_OFFSET_TEXTURE_BIAS,"OFFSET_TEXTURE_BIAS",3290,0,CGI_UNIFORM_PARAM)
CG_BINDLOCATION_MACRO(ConstEye,CG_CONST_EYE,"CONST_EYE",3291,0,CGI_UNIFORM_PARAM)
CG_BINDLOCATION_MACRO(TessFactor,CG_TESSFACTOR,"TESSFACTOR",3255,0,CG_VARYING_PARAM)

#undef CG_BINDLOCATION_MACRO
