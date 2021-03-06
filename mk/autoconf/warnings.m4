# warnings.m4                                                  -*- Autoconf -*-
#==============================================================================
# Copyright (C)2005 by Eric Sunshine <sunshine@sunshineco.com>
#
#    This library is free software; you can redistribute it and/or modify it
#    under the terms of the GNU Library General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or (at your
#    option) any later version.
#
#    This library is distributed in the hope that it will be useful, but
#    WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
#    or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Library General Public
#    License for more details.
#
#    You should have received a copy of the GNU Library General Public License
#    along with this library; if not, write to the Free Software Foundation,
#    Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#==============================================================================
AC_PREREQ([2.56])

#------------------------------------------------------------------------------
# CS_COMPILER_WARNINGS([LANGUAGE], [CACHE-VAR], [ACTION-IF-FOUND],
#                      [ACTION-IF-NOT-FOUND])
#	Check how to enable compilation warnings. If LANGUAGE is not provided,
#	then `C' is assumed (other options include `C++').  If CACHE-VAR is not
#	provided, then it defaults to the name
#	"cs_cv_prog_compiler_enable_warnings".  If an option for enabling
#	warnings (such as `-Wall') is discovered, then it is assigned to
#	CACHE-VAR and ACTION-IF-FOUND is invoked; otherwise the empty string is
#	assigned to CACHE-VAR and ACTION-IF-NOT-FOUND is invoked.
#
# IMPLEMENTATION NOTES
#
#	On some platforms, it is more appropriate to use -Wmost rather than
#	-Wall even if the compiler understands both, thus we attempt -Wmost
#	before -Wall.
#------------------------------------------------------------------------------
AC_DEFUN([CS_COMPILER_WARNINGS],
    [CS_CHECK_BUILD_FLAGS(
	[how to enable m4_default([$1],[C]) compilation warnings],
	[m4_default([$2],[cs_cv_prog_compiler_enable_warnings])],
	[CS_CREATE_TUPLE([-Wmost]) CS_CREATE_TUPLE([-Wall])],
	[$1], [$3], [$4])])



#------------------------------------------------------------------------------
# CS_COMPILER_ERRORS([LANGUAGE], [CACHE-VAR], [ACTION-IF-FOUND],
#                    [ACTION-IF-NOT-FOUND])
#	Check how to promote compilation diganostics from warning to error
#	status. If LANGUAGE is not provided, then `C' is assumed (other options
#	include `C++').  If CACHE-VAR is not provided, then it defaults to the
#	name "cs_cv_prog_compiler_enable_errors".  If an option for performing
#	this promotion (such as `-Werror') is discovered, then it is assigned
#	to CACHE-VAR and ACTION-IF-FOUND is invoked; otherwise the empty string
#	is assigned to CACHE-VAR and ACTION-IF-NOT-FOUND is invoked.
#------------------------------------------------------------------------------
AC_DEFUN([CS_COMPILER_ERRORS],
    [CS_CHECK_BUILD_FLAGS(
	[how to treat m4_default([$1],[C]) warnings as errors],
	[m4_default([$2],[cs_cv_prog_compiler_enable_errors])],
	[CS_CREATE_TUPLE([-Werror])], [$1], [$3], [$4])])



#------------------------------------------------------------------------------
# CS_COMPILER_IGNORE_UNUSED([LANGUAGE], [CACHE-VAR], [ACTION-IF-FOUND],
#                           [ACTION-IF-NOT-FOUND])
#	Check how to instruct compiler to ignore unused variables and
#	arguments.  This option may be useful for code generated by tools, such
#	as Swig, Bison, and Flex, over which the client has no control, yet
#	wishes to compile without excessive diagnostic spew.  If LANGUAGE is
#	not provided, then `C' is assumed (other options include `C++').  If
#	CACHE-VAR is not provided, then it defaults to the name
#	"cs_cv_prog_compiler_ignore_unused".  If an option (such as
#	`-Wno-unused') is discovered, then it is assigned to CACHE-VAR and
#	ACTION-IF-FOUND is invoked; otherwise the empty string is assigned to
#	CACHE-VAR and ACTION-IF-NOT-FOUND is invoked.
#------------------------------------------------------------------------------
AC_DEFUN([CS_COMPILER_IGNORE_UNUSED],
    [CS_CHECK_BUILD_FLAGS(
	[how to suppress m4_default([$1],[C]) unused variable warnings],
	[m4_default([$2],[cs_cv_prog_compiler_ignore_unused])],
	[CS_CREATE_TUPLE([-Wno-unused])], [$1], [$3], [$4])])



#------------------------------------------------------------------------------
# CS_COMPILER_IGNORE_UNINITIALIZED([LANGUAGE], [CACHE-VAR], [ACTION-IF-FOUND],
#                                  [ACTION-IF-NOT-FOUND])
#	Check how to instruct compiler to ignore uninitialized variables.  This
#	option may be useful for code generated by tools, such as Swig, Bison,
#	and Flex, over which the client has no control, yet wishes to compile
#	without excessive diagnostic spew.  If LANGUAGE is not provided, then
#	`C' is assumed (other options include `C++').  If CACHE-VAR is not
#	provided, then it defaults to the name
#	"cs_cv_prog_compiler_ignore_uninitialized".  If an option (such as
#	`-Wno-uninitialized') is discovered, then it is assigned to CACHE-VAR
#	and ACTION-IF-FOUND is invoked; otherwise the empty string is assigned
#	to CACHE-VAR and ACTION-IF-NOT-FOUND is invoked.
#------------------------------------------------------------------------------
AC_DEFUN([CS_COMPILER_IGNORE_UNINITIALIZED],
    [CS_CHECK_BUILD_FLAGS(
	[how to suppress m4_default([$1],[C]) uninitialized warnings],
	[m4_default([$2],
	    [cs_cv_prog_compiler_ignore_uninitialized_variables])],
	[CS_CREATE_TUPLE([-Wno-uninitialized])], [$1], [$3], [$4])])



#------------------------------------------------------------------------------
# CS_COMPILER_IGNORE_PRAGMAS([LANGUAGE], [CACHE-VAR], [ACTION-IF-FOUND],
#                            [ACTION-IF-NOT-FOUND])
#	Check how to instruct compiler to ignore unrecognized #pragma
#	directives.  This option may be useful for code which contains
#	unprotected #pragmas which are not understood by all compilers.  If
#	LANGUAGE is not provided, then `C' is assumed (other options include
#	`C++').  If CACHE-VAR is not provided, then it defaults to the name
#	"cs_cv_prog_compiler_ignore_unknown_pragmas".  If an option (such as
#	`-Wno-unknown-pragmas') is discovered, then it is assigned to CACHE-VAR
#	and ACTION-IF-FOUND is invoked; otherwise the empty string is assigned
#	to CACHE-VAR and ACTION-IF-NOT-FOUND is invoked.
#------------------------------------------------------------------------------
AC_DEFUN([CS_COMPILER_IGNORE_PRAGMAS],
    [CS_CHECK_BUILD_FLAGS(
	[how to suppress m4_default([$1],[C]) unknown [#pragma] warnings],
	[m4_default([$2],[cs_cv_prog_compiler_ignore_unknown_pragmas])],
	[CS_CREATE_TUPLE([-Wno-unknown-pragmas])], [$1], [$3], [$4])])



#------------------------------------------------------------------------------
# CS_COMPILER_IGNORE_LONG_DOUBLE([LANGUAGE], [CACHE-VAR], [ACTION-IF-FOUND],
#                                [ACTION-IF-NOT-FOUND])
#	Check how to instruct compiler to suppress warnings about `long double'
#	usage.  This option may be useful for code generated by tools, such as
#	Swig, Bison, and Flex, over which the client has no control, yet wishes
#	to compile without excessive diagnostic spew.  If LANGUAGE is not
#	provided, then `C' is assumed (other options include `C++').  If
#	CACHE-VAR is not provided, then it defaults to the name
#	"cs_cv_prog_compiler_ignore_long_double".  If an option (such as
#	`-Wno-long-double') is discovered, then it is assigned to CACHE-VAR and
#	ACTION-IF-FOUND is invoked; otherwise the empty string is assigned to
#	CACHE-VAR and ACTION-IF-NOT-FOUND is invoked.
#------------------------------------------------------------------------------
AC_DEFUN([CS_COMPILER_IGNORE_LONG_DOUBLE],
    [CS_CHECK_BUILD_FLAGS(
	[how to suppress m4_default([$1],[C]) `long double' warnings],
	[m4_default([$2],[cs_cv_prog_compiler_ignore_long_double])],
	[CS_CREATE_TUPLE([-Wno-long-double])], [$1], [$3], [$4])])



#------------------------------------------------------------------------------
# CS_COMPILER_IGNORE_NON_VIRTUAL_DTOR([LANGUAGE], [CACHE-VAR],
#                                     [ACTION-IF-FOUND], [ACTION-IF-NOT-FOUND])
#	Check how to instruct compiler to ignore non-virtual destructors in
#	classes containing virtual methods.  This option may be useful to
#	suppress warnings about code over which we have no control, such as
#	3rd-party headers or code generated by tools.  If LANGUAGE is not
#	provided, then `C' is assumed (other options include `C++').  If
#	CACHE-VAR is not provided, then it defaults to the name
#	"cs_cv_prog_compiler_ignore_non_virtual_dtor".  If an option (such as
#	`-Wno-non-virtual-dtor') is discovered, then it is assigned to
#	CACHE-VAR and ACTION-IF-FOUND is invoked; otherwise the empty string is
#	assigned to CACHE-VAR and ACTION-IF-NOT-FOUND is invoked.
#------------------------------------------------------------------------------
AC_DEFUN([CS_COMPILER_IGNORE_NON_VIRTUAL_DTOR],
    [CS_CHECK_BUILD_FLAGS(
	[how to suppress m4_default([$1],[C]) non-virtual destructor warnings],
	[m4_default([$2],[cs_cv_prog_compiler_ignore_non_virtual_dtor])],
	[CS_CREATE_TUPLE([-Wno-non-virtual-dtor])], [$1], [$3], [$4])])
