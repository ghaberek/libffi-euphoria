/** \file
 * \brief User API
 * IUP - A Portable User Interface Toolkit
 * Tecgraf: Computer Graphics Technology Group, PUC-Rio, Brazil
 * http://www.tecgraf.puc-rio.br/iup  mailto:iup@tecgraf.puc-rio.br
 *
 * See Copyright Notice at the end of this file
 */

--#ifndef __IUP_H
--#define __IUP_H

public include "iupkey.e"
public include "iupdef.e"
public include "iup_export.e"

--#ifdef __cplusplus
--extern "C" {
--#endif

public constant IUP_NAME = "IUP - Portable User Interface"
public constant IUP_DESCRIPTION = "Multi-platform Toolkit for Building Graphical User Interfaces"
public constant IUP_COPYRIGHT = "Copyright (C) 1994-2020 Tecgraf/PUC-Rio"
public constant IUP_VERSION = "3.30" /* bug fixes are reported only by IupVersion functions */
public constant IUP_VERSION_NUMBER = 330000
public constant IUP_VERSION_DATE = "2020/07/30" /* does not include bug fix releases */

--typedef struct Ihandle_ Ihandle;
--typedef int (*Icallback)(Ihandle*);

/************************************************************************/
/*                        Main API                                      */
/************************************************************************/


public function IupOpen( atom argc=0, object argv=NULL )

	if atom( argv ) then
		argv = command_line()
		argc = length( argv )
	end if

	atom pargc = allocate_data( sizeof(C_INT) )
	atom pargv = allocate_string_pointer_array( argv )
	poke4( pargc, argc )

	return c_func( xIupOpen, {pargc,pargv} )
end function


public procedure IupClose()
	c_proc(xIupClose,{})
end procedure

public function IupIsOpened()
	return c_func(xIupIsOpened,{})
end function



public procedure IupImageLibOpen()
	c_proc(xIupImageLibOpen,{})
end procedure


public function IupMainLoop()
	return c_func(xIupMainLoop,{})
end function

public function IupLoopStep()
	return c_func(xIupLoopStep,{})
end function

public function IupLoopStepWait()
	return c_func(xIupLoopStepWait,{})
end function

public function IupMainLoopLevel()
	return c_func(xIupMainLoopLevel,{})
end function


public procedure IupFlush()
	c_proc(xIupFlush,{})
end procedure


public procedure IupExitLoop()
	c_proc(xIupExitLoop,{})
end procedure


public procedure IupPostMessage( atom ih, object s, integer i, atom d, atom p )
	c_proc(xIupPostMessage,{ih,_s(s),i,d,p})
end procedure


public function IupRecordInput( object filename, integer mode )
	return c_func(xIupRecordInput,{_s(filename),mode})
end function

public function IupPlayInput( object filename )
	return c_func(xIupPlayInput,{_s(filename)})
end function



public procedure IupUpdate( atom ih )
	c_proc(xIupUpdate,{ih})
end procedure


public procedure IupUpdateChildren( atom ih )
	c_proc(xIupUpdateChildren,{ih})
end procedure


public procedure IupRedraw( atom ih, integer children )
	c_proc(xIupRedraw,{ih,children})
end procedure


public procedure IupRefresh( atom ih )
	c_proc(xIupRefresh,{ih})
end procedure


public procedure IupRefreshChildren( atom ih )
	c_proc(xIupRefreshChildren,{ih})
end procedure


public function IupExecute( object filename, object parameters )
	return c_func(xIupExecute,{_s(filename),_s(parameters)})
end function

public function IupExecuteWait( object filename, object parameters )
	return c_func(xIupExecuteWait,{_s(filename),_s(parameters)})
end function

public function IupHelp( object url )
	return c_func(xIupHelp,{_s(url)})
end function
--IUP_API void      IupLog(const char* type, const char* format, ...);


public function IupLoad( object filename )
	return peek_string(c_func(xIupLoad,{_s(filename)}))
end function

public function IupLoadBuffer( object buffer )
	return peek_string(c_func(xIupLoadBuffer,{_s(buffer)}))
end function


public function IupVersion()
	return peek_string(c_func(xIupVersion,{}))
end function

public function IupVersionDate()
	return peek_string(c_func(xIupVersionDate,{}))
end function

public function IupVersionNumber()
	return c_func(xIupVersionNumber,{})
end function


public procedure IupVersionShow()
	c_proc(xIupVersionShow,{})
end procedure



public procedure IupSetLanguage( object lng )
	c_proc(xIupSetLanguage,{_s(lng)})
end procedure

public function IupGetLanguage()
	return peek_string(c_func(xIupGetLanguage,{}))
end function


public procedure IupSetLanguageString( object name, object str )
	c_proc(xIupSetLanguageString,{_s(name),_s(str)})
end procedure


public procedure IupStoreLanguageString( object name, object str )
	c_proc(xIupStoreLanguageString,{_s(name),_s(str)})
end procedure

public function IupGetLanguageString( object name )
	return peek_string(c_func(xIupGetLanguageString,{_s(name)}))
end function


public procedure IupSetLanguagePack( atom ih )
	c_proc(xIupSetLanguagePack,{ih})
end procedure



public procedure IupDestroy( atom ih )
	c_proc(xIupDestroy,{ih})
end procedure


public procedure IupDetach( atom child )
	c_proc(xIupDetach,{child})
end procedure

public function IupAppend( atom ih, atom child )
	return c_func(xIupAppend,{ih,child})
end function

public function IupInsert( atom ih, atom ref_child, atom child )
	return c_func(xIupInsert,{ih,ref_child,child})
end function

public function IupGetChild( atom ih, integer pos )
	return c_func(xIupGetChild,{ih,pos})
end function

public function IupGetChildPos( atom ih, atom child )
	return c_func(xIupGetChildPos,{ih,child})
end function

public function IupGetChildCount( atom ih )
	return c_func(xIupGetChildCount,{ih})
end function

public function IupGetNextChild( atom ih, atom child )
	return c_func(xIupGetNextChild,{ih,child})
end function

public function IupGetBrother( atom ih )
	return c_func(xIupGetBrother,{ih})
end function

public function IupGetParent( atom ih )
	return c_func(xIupGetParent,{ih})
end function

public function IupGetDialog( atom ih )
	return c_func(xIupGetDialog,{ih})
end function

public function IupGetDialogChild( atom ih, object name )
	return c_func(xIupGetDialogChild,{ih,_s(name)})
end function

public function IupReparent( atom ih, atom new_parent, atom ref_child )
	return c_func(xIupReparent,{ih,new_parent,ref_child})
end function


public function IupPopup( atom ih, integer x, integer y )
	return c_func(xIupPopup,{ih,x,y})
end function

public function IupShow( atom ih )
	return c_func(xIupShow,{ih})
end function

public function IupShowXY( atom ih, integer x, integer y )
	return c_func(xIupShowXY,{ih,x,y})
end function

public function IupHide( atom ih )
	return c_func(xIupHide,{ih})
end function

public function IupMap( atom ih )
	return c_func(xIupMap,{ih})
end function


public procedure IupUnmap( atom ih )
	c_proc(xIupUnmap,{ih})
end procedure



public procedure IupResetAttribute( atom ih, object name )
	c_proc(xIupResetAttribute,{ih,_s(name)})
end procedure

public function IupGetAllAttributes( atom ih )

	integer max_n = c_func( xIupGetAllAttributes, {ih,NULL,0} )

	atom base = allocate_data( sizeof(C_POINTER) * max_n )
	integer n = c_func( xIupGetAllAttributes, {ih,base,max_n} )

	atom ptr = base
	sequence names = repeat( 0, n )

	for i = 1 to n do
		atom str = peek_pointer( ptr )
		names[i] = peek_string( str )
		ptr += sizeof( C_POINTER )
	end for

	free( base )

	return sort( names )
end function


public procedure IupCopyAttributes( atom src_ih, atom dst_ih )
	c_proc(xIupCopyAttributes,{src_ih,dst_ih})
end procedure
--IUP_API Ihandle*  IupSetAtt(const char* handle_name, Ihandle* ih, const char* name, ...);

public function IupSetAttributes( atom ih, object str )
	return c_func(xIupSetAttributes,{ih,_s(str)})
end function

public function IupGetAttributes( atom ih )
	return peek_string(c_func(xIupGetAttributes,{ih}))
end function


public procedure IupSetAttribute( atom ih, object name, object value )
	c_proc( xIupSetStrAttribute, {ih,_s(name),_s(value)} )
end procedure


public procedure IupSetStrAttribute( atom ih, object name, object value )
	c_proc(xIupSetStrAttribute,{ih,_s(name),_s(value)})
end procedure
--IUP_API void      IupSetStrf        (Ihandle* ih, const char* name, const char* format, ...);


public procedure IupSetInt( atom ih, object name, integer value )
	c_proc(xIupSetInt,{ih,_s(name),value})
end procedure


public procedure IupSetFloat( atom ih, object name, atom value )
	c_proc(xIupSetFloat,{ih,_s(name),value})
end procedure


public procedure IupSetDouble( atom ih, object name, atom value )
	c_proc(xIupSetDouble,{ih,_s(name),value})
end procedure


public procedure IupSetRGB( atom ih, object name, integer r, integer g, integer b )
	c_proc(xIupSetRGB,{ih,_s(name),r,g,b})
end procedure


public procedure IupSetRGBA( atom ih, object name, integer r, integer g, integer b, integer a )
	c_proc(xIupSetRGBA,{ih,_s(name),r,g,b,a})
end procedure


public function IupGetAttribute( atom ih, object name, object default="" )

	atom ptr = c_func( xIupGetAttribute, {ih,_s(name)} )

	if ptr = NULL then
		return default
	end if

	if sequence( default ) then
		return peek_string( ptr )
	end if

	return ptr
end function

public function IupGetInt( atom ih, object name, atom default=-1 )

	atom ptr = c_func( xIupGetAttribute, {ih,_s(name)} )

	if ptr = NULL then
		return default
	end if

	return c_func(xIupGetInt,{ih,_s(name)})
end function

public function IupGetInt2( atom ih, object name )
	return c_func(xIupGetInt2,{ih,_s(name)})
end function

public function IupGetIntInt( atom ih, object name )

	atom base = allocate_data( sizeof(C_INT)*2 )

	atom i1 = base + sizeof(C_INT) * 0
	atom i2 = base + sizeof(C_INT) * 1

	object value = c_func( xIupGetIntInt, {ih,_s(name),i1,i2} )

	if value then
		value = peek4s({ base, value })
	end if

	free( base )

	return value
end function

public function IupGetFloat( atom ih, object name )
	return c_func(xIupGetFloat,{ih,_s(name)})
end function

public function IupGetDouble( atom ih, object name )
	return c_func(xIupGetDouble,{ih,_s(name)})
end function

public function IupGetRGB( atom ih, object name )

	atom base = allocate_data( sizeof(C_UCHAR)*3 )

	atom r = base + sizeof(C_UCHAR) * 0
	atom g = base + sizeof(C_UCHAR) * 1
	atom b = base + sizeof(C_UCHAR) * 2

	c_proc( xIupGetRGB, {ih,_s(name),r,g,b} )

	r = peek( r )
	g = peek( g )
	b = peek( b )

	free( base )

	return {r,g,b}
end function

public function IupGetRGBA( atom ih, object name )

	atom base = allocate_data( sizeof(C_UCHAR)*4 )

	atom r = base + sizeof(C_UCHAR) * 0
	atom g = base + sizeof(C_UCHAR) * 1
	atom b = base + sizeof(C_UCHAR) * 2
	atom a = base + sizeof(C_UCHAR) * 3

	c_proc( xIupGetRGB, {ih,_s(name),r,g,b,a} )

	r = peek( r )
	g = peek( g )
	b = peek( b )
	a = peek( a )

	free( base )

	return {r,g,b,a}
end function



public procedure IupSetAttributeId( atom ih, object name, integer id, object value )
	c_proc(xIupSetAttributeId,{ih,_s(name),id,_s(value)})
end procedure


public procedure IupSetStrAttributeId( atom ih, object name, integer id, object value )
	c_proc(xIupSetStrAttributeId,{ih,_s(name),id,_s(value)})
end procedure
--IUP_API void  IupSetStrfId(Ihandle* ih, const char* name, int id, const char* format, ...);


public procedure IupSetIntId( atom ih, object name, integer id, integer value )
	c_proc(xIupSetIntId,{ih,_s(name),id,value})
end procedure


public procedure IupSetFloatId( atom ih, object name, integer id, atom value )
	c_proc(xIupSetFloatId,{ih,_s(name),id,value})
end procedure


public procedure IupSetDoubleId( atom ih, object name, integer id, atom value )
	c_proc(xIupSetDoubleId,{ih,_s(name),id,value})
end procedure


public procedure IupSetRGBId( atom ih, object name, integer id, integer r, integer g, integer b )
	c_proc(xIupSetRGBId,{ih,_s(name),id,r,g,b})
end procedure


public function IupGetAttributeId( atom ih, object name, atom id, object default="" )

	atom ptr = c_func( xIupGetAttributeId, {ih,_s(name),id} )

	if ptr = NULL then
		return default
	end if

	if sequence( default ) then
		return peek_string( ptr )
	end if

	return ptr
end function

public function IupGetIntId( atom ih, object name, atom id, atom default=-1 )

	atom ptr = c_func( xIupGetAttributeId, {ih,_s(name),id} )

	if ptr = NULL then
		return default
	end if

	return c_func(xIupGetIntId,{ih,_s(name),id})
end function

public function IupGetFloatId( atom ih, object name, integer id )
	return c_func(xIupGetFloatId,{ih,_s(name),id})
end function

public function IupGetDoubleId( atom ih, object name, integer id )
	return c_func(xIupGetDoubleId,{ih,_s(name),id})
end function

public function IupGetRGBId( atom ih, object name, integer id )

	atom base = allocate_data( sizeof(C_UCHAR)*3 )

	atom r = base + sizeof(C_UCHAR) * 0
	atom g = base + sizeof(C_UCHAR) * 1
	atom b = base + sizeof(C_UCHAR) * 2

	c_proc( xIupGetRGB, {ih,_s(name),id,r,g,b} )

	r = peek( r )
	g = peek( g )
	b = peek( b )

	free( base )

	return {r,g,b}
end function



public procedure IupSetAttributeId2( atom ih, object name, integer lin, integer col, object value )
	c_proc(xIupSetAttributeId2,{ih,_s(name),lin,col,_s(value)})
end procedure


public procedure IupSetStrAttributeId2( atom ih, object name, integer lin, integer col, object value )
	c_proc(xIupSetStrAttributeId2,{ih,_s(name),lin,col,_s(value)})
end procedure
--IUP_API void  IupSetStrfId2(Ihandle* ih, const char* name, int lin, int col, const char* format, ...);


public procedure IupSetIntId2( atom ih, object name, integer lin, integer col, integer value )
	c_proc(xIupSetIntId2,{ih,_s(name),lin,col,value})
end procedure


public procedure IupSetFloatId2( atom ih, object name, integer lin, integer col, atom value )
	c_proc(xIupSetFloatId2,{ih,_s(name),lin,col,value})
end procedure


public procedure IupSetDoubleId2( atom ih, object name, integer lin, integer col, atom value )
	c_proc(xIupSetDoubleId2,{ih,_s(name),lin,col,value})
end procedure


public procedure IupSetRGBId2( atom ih, object name, integer lin, integer col, integer r, integer g, integer b )
	c_proc(xIupSetRGBId2,{ih,_s(name),lin,col,r,g,b})
end procedure


public function IupGetAttributeId2( atom ih, object name, integer lin, integer col )
	return peek_string(c_func(xIupGetAttributeId2,{ih,_s(name),lin,col}))
end function

public function IupGetIntId2( atom ih, object name, integer lin, integer col )
	return c_func(xIupGetIntId2,{ih,_s(name),lin,col})
end function

public function IupGetFloatId2( atom ih, object name, integer lin, integer col )
	return c_func(xIupGetFloatId2,{ih,_s(name),lin,col})
end function

public function IupGetDoubleId2( atom ih, object name, integer lin, integer col )
	return c_func(xIupGetDoubleId2,{ih,_s(name),lin,col})
end function

public function IupGetRGBId2( atom ih, object name, integer lin, integer col )

	atom base = allocate_data( sizeof(C_UCHAR)*3 )

	atom r = base + sizeof(C_UCHAR) * 0
	atom g = base + sizeof(C_UCHAR) * 1
	atom b = base + sizeof(C_UCHAR) * 2

	c_proc( xIupGetRGB, {ih,_s(name),lin,col,r,g,b} )

	r = peek( r )
	g = peek( g )
	b = peek( b )

	free( base )

	return {r,g,b}
end function



public procedure IupSetGlobal( object name, object value )
	c_proc(xIupSetGlobal,{_s(name),_s(value)})
end procedure


public procedure IupSetStrGlobal( object name, object value )
	c_proc(xIupSetStrGlobal,{_s(name),_s(value)})
end procedure

public function IupGetGlobal( object name )
	return peek_string(c_func(xIupGetGlobal,{_s(name)}))
end function


public function IupSetFocus( atom ih )
	return c_func(xIupSetFocus,{ih})
end function

public function IupGetFocus()
	return c_func(xIupGetFocus,{})
end function

public function IupPreviousField( atom ih )
	return c_func(xIupPreviousField,{ih})
end function

public function IupNextField( atom ih )
	return c_func(xIupNextField,{ih})
end function


public function IupGetCallback( atom ih, object name )
	return c_func(xIupGetCallback,{ih,_s(name)})
end function

public function IupSetCallback( atom ih, object name, atom func )
	return c_func(xIupSetCallback,{ih,_s(name),func})
end function
public function IupSetCallbacks( atom ih, object name, object funcs )

	if atom( funcs ) then
		funcs = {funcs}
	end if

	sequence ptypes = repeat( C_POINTER, length(funcs)+3 )
	sequence pvalue = ih & _s(name) & funcs & NULL

	integer func_id = iup_func( iup, "IupSetCallbacks", ptypes, C_POINTER )

	return c_func( func_id, pvalue )
end function


public function IupGetFunction( object name )
	return c_func(xIupGetFunction,{_s(name)})
end function

public function IupSetFunction( object name, atom func )
	return c_func(xIupSetFunction,{_s(name),func})
end function


public function IupGetHandle( object name )
	return c_func(xIupGetHandle,{_s(name)})
end function

public function IupSetHandle( object name, atom ih )
	return c_func(xIupSetHandle,{_s(name),ih})
end function

public function IupGetAllNames()

	integer max_n = c_func( xIupGetAllNames, {NULL,0} )

	atom base = allocate_data( sizeof(C_POINTER) * max_n )
	integer n = c_func( xIupGetAllNames, {base,max_n} )

	atom ptr = base
	sequence names = repeat( 0, n )

	for i = 1 to n do
		atom str = peek_pointer( ptr )
		names[i] = peek_string( str )
		ptr += sizeof( C_POINTER )
	end for

	free( base )

	return sort( names )
end function

public function IupGetAllDialogs()

	integer max_n = c_func( xIupGetAllDialogs, {NULL,0} )

	atom base = allocate_data( sizeof(C_POINTER) * max_n )
	integer n = c_func( xIupGetAllDialogs, {base,max_n} )

	atom ptr = base
	sequence names = repeat( 0, n )

	for i = 1 to n do
		atom str = peek_pointer( ptr )
		names[i] = peek_string( str )
		ptr += sizeof( C_POINTER )
	end for

	free( base )

	return sort( names )
end function

public function IupGetName( atom ih )
	return peek_string(c_func(xIupGetName,{ih}))
end function



public procedure IupSetAttributeHandle( atom ih, object name, atom ih_named )
	c_proc(xIupSetAttributeHandle,{ih,_s(name),ih_named})
end procedure

public function IupGetAttributeHandle( atom ih, object name )
	return c_func(xIupGetAttributeHandle,{ih,_s(name)})
end function


public procedure IupSetAttributeHandleId( atom ih, object name, integer id, atom ih_named )
	c_proc(xIupSetAttributeHandleId,{ih,_s(name),id,ih_named})
end procedure

public function IupGetAttributeHandleId( atom ih, object name, integer id )
	return c_func(xIupGetAttributeHandleId,{ih,_s(name),id})
end function


public procedure IupSetAttributeHandleId2( atom ih, object name, integer lin, integer col, atom ih_named )
	c_proc(xIupSetAttributeHandleId2,{ih,_s(name),lin,col,ih_named})
end procedure

public function IupGetAttributeHandleId2( atom ih, object name, integer lin, integer col )
	return c_func(xIupGetAttributeHandleId2,{ih,_s(name),lin,col})
end function


public function IupGetClassName( atom ih )
	return peek_string(c_func(xIupGetClassName,{ih}))
end function

public function IupGetClassType( atom ih )
	return peek_string(c_func(xIupGetClassType,{ih}))
end function

public function IupGetAllClasses()

	integer max_n = c_func( xIupGetAllClasses, {NULL,0} )

	atom base = allocate_data( sizeof(C_POINTER) * max_n )
	mem_set( base, NULL, sizeof(C_POINTER)*max_n )

	max_n = c_func( xIupGetAllClasses, {base,max_n} )

	atom ptr = base
	sequence names = repeat( 0, max_n )

	for i = 1 to max_n do

		atom str = peek_pointer( ptr )
		if str = NULL then
			exit
		end if

		names[i] = peek_string( str )
		ptr += sizeof( C_POINTER )

	end for

	max_n = find( 0, names )

	if max_n then
		names = names[1..max_n]
	end if

	free( base )

	return sort( names )
end function

public function IupGetClassAttributes( object classname )

	classname = _s( classname )

	integer max_n = c_func( xIupGetClassAttributes, {classname,NULL,0} )

	atom base = allocate_data( sizeof(C_POINTER) * max_n )
	mem_set( base, NULL, sizeof(C_POINTER)*max_n )

	max_n = c_func( xIupGetClassAttributes, {classname,base,max_n} )

	atom ptr = base
	sequence names = repeat( 0, max_n )

	for i = 1 to max_n do

		atom str = peek_pointer( ptr )
		if str = NULL then
			exit
		end if

		names[i] = peek_string( str )
		ptr += sizeof( C_POINTER )

	end for

	if max_n then
		names = names[1..max_n]
	end if

	free( base )

	return sort( names )
end function

public function IupGetClassCallbacks( object classname )

	classname = _s( classname )

	integer max_n = c_func( xIupGetClassCallbacks, {classname,NULL,0} )

	atom base = allocate_data( sizeof(C_POINTER) * max_n )
	integer n = c_func( xIupGetClassCallbacks, {classname,base,max_n} )

	atom ptr = base
	sequence names = repeat( 0, n )

	for i = 1 to n do
		atom str = peek_pointer( ptr )
		names[i] = peek_string( str )
		ptr += sizeof( C_POINTER )
	end for

	free( base )

	return sort( names )
end function


public procedure IupSaveClassAttributes( atom ih )
	c_proc(xIupSaveClassAttributes,{ih})
end procedure


public procedure IupCopyClassAttributes( atom src_ih, atom dst_ih )
	c_proc(xIupCopyClassAttributes,{src_ih,dst_ih})
end procedure


public procedure IupSetClassDefaultAttribute( object classname, object name, object value )
	c_proc(xIupSetClassDefaultAttribute,{_s(classname),_s(name),_s(value)})
end procedure

public function IupClassMatch( atom ih, object classname )
	return c_func(xIupClassMatch,{ih,_s(classname)})
end function

--IUP_API Ihandle*  IupCreate (const char *classname);

public function IupCreate( object classname, object params=NULL )
	return c_func( xIupCreatev, {_s(classname),_p(params)} )
end function
--IUP_API Ihandle*  IupCreatep(const char *classname, void* first, ...);

/************************************************************************/
/*                        Elements                                      */
/************************************************************************/


public function IupFill()
	return c_func(xIupFill,{})
end function

public function IupSpace()
	return c_func(xIupSpace,{})
end function


public function IupRadio( atom child )
	return c_func(xIupRadio,{child})
end function
--IUP_API Ihandle*  IupVbox       (Ihandle* child, ...);

public function IupVbox( sequence children )
	return c_func(xIupVboxv,{_p(children)})
end function
--IUP_API Ihandle*  IupZbox       (Ihandle* child, ...);

public function IupZbox( sequence children )
	return c_func(xIupZboxv,{_p(children)})
end function
--IUP_API Ihandle*  IupHbox       (Ihandle* child, ...);

public function IupHbox( sequence children )
	return c_func(xIupHboxv,{_p(children)})
end function

--IUP_API Ihandle*  IupNormalizer (Ihandle* ih_first, ...);

public function IupNormalizer( sequence ih_list )
	return c_func(xIupNormalizerv,{_p(ih_list)})
end function

--IUP_API Ihandle*  IupCbox       (Ihandle* child, ...);

public function IupCbox( sequence children )
	return c_func(xIupCboxv,{_p(children)})
end function

public function IupSbox( atom child )
	return c_func(xIupSbox,{child})
end function

public function IupSplit( atom child1, atom child2 )
	return c_func(xIupSplit,{child1,child2})
end function

public function IupScrollBox( atom child )
	return c_func(xIupScrollBox,{child})
end function

public function IupFlatScrollBox( atom child )
	return c_func(xIupFlatScrollBox,{child})
end function
--IUP_API Ihandle*  IupGridBox    (Ihandle* child, ...);

public function IupGridBox( sequence children )
	return c_func(xIupGridBoxv,{_p(children)})
end function
--IUP_API Ihandle*  IupMultiBox   (Ihandle* child, ...);

public function IupMultiBox( sequence children )
	return c_func(xIupMultiBoxv,{_p(children)})
end function

public function IupExpander( atom child )
	return c_func(xIupExpander,{child})
end function

public function IupDetachBox( atom child )
	return c_func(xIupDetachBox,{child})
end function

public function IupBackgroundBox( atom child )
	return c_func(xIupBackgroundBox,{child})
end function


public function IupFrame( atom child )
	return c_func(xIupFrame,{child})
end function

public function IupFlatFrame( atom child )
	return c_func(xIupFlatFrame,{child})
end function


public function IupImage( integer width, integer height, sequence pixels )
	return c_func(xIupImage,{width,height,_b(pixels)})
end function

public function IupImageRGB( integer width, integer height, sequence pixels )
	return c_func(xIupImageRGB,{width,height,_b(pixels)})
end function

public function IupImageRGBA( integer width, integer height, sequence pixels )
	return c_func(xIupImageRGBA,{width,height,_b(pixels)})
end function


public function IupItem( object title, object action )
	return c_func(xIupItem,{_s(title),_s(action)})
end function

public function IupSubmenu( object title, atom child )
	return c_func(xIupSubmenu,{_s(title),child})
end function

public function IupSeparator()
	return c_func(xIupSeparator,{})
end function
--IUP_API Ihandle*  IupMenu       (Ihandle* child, ...);

public function IupMenu( sequence children )
	return c_func(xIupMenuv,{_p(children)})
end function


public function IupButton( object title, object action )
	return c_func(xIupButton,{_s(title),_s(action)})
end function

public function IupFlatButton( object title )
	return c_func(xIupFlatButton,{_s(title)})
end function

public function IupFlatToggle( object title )
	return c_func(xIupFlatToggle,{_s(title)})
end function

public function IupDropButton( atom dropchild )
	return c_func(xIupDropButton,{dropchild})
end function

public function IupFlatLabel( object title )
	return c_func(xIupFlatLabel,{_s(title)})
end function

public function IupFlatSeparator()
	return c_func(xIupFlatSeparator,{})
end function

public function IupCanvas( object action )
	return c_func(xIupCanvas,{_s(action)})
end function

public function IupDialog( atom child )
	return c_func(xIupDialog,{child})
end function

public function IupUser()
	return c_func(xIupUser,{})
end function

public function IupThread()
	return c_func(xIupThread,{})
end function

public function IupLabel( object title )
	return c_func(xIupLabel,{_s(title)})
end function

public function IupList( object action )
	return c_func(xIupList,{_s(action)})
end function

public function IupFlatList()
	return c_func(xIupFlatList,{})
end function

public function IupText( object action )
	return c_func(xIupText,{_s(action)})
end function

public function IupMultiLine( object action )
	return c_func(xIupMultiLine,{_s(action)})
end function

public function IupToggle( object title, object action )
	return c_func(xIupToggle,{_s(title),_s(action)})
end function

public function IupTimer()
	return c_func(xIupTimer,{})
end function

public function IupClipboard()
	return c_func(xIupClipboard,{})
end function

public function IupProgressBar()
	return c_func(xIupProgressBar,{})
end function

public function IupVal( object _type )
	return c_func(xIupVal,{_s(_type)})
end function

public function IupFlatVal( object _type )
	return c_func(xIupFlatVal,{_s(_type)})
end function

public function IupFlatTree()
	return c_func(xIupFlatTree,{})
end function
--IUP_API Ihandle*  IupTabs       (Ihandle* child, ...);

public function IupTabs( sequence children )
	return c_func(xIupTabsv,{_p(children)})
end function
--IUP_API Ihandle*  IupFlatTabs   (Ihandle* first, ...);

public function IupFlatTabs( sequence children )
	return c_func(xIupFlatTabsv,{_p(children)})
end function

public function IupTree()
	return c_func(xIupTree,{})
end function

public function IupLink( object url, object title )
	return c_func(xIupLink,{_s(url),_s(title)})
end function

public function IupAnimatedLabel( atom animation )
	return c_func(xIupAnimatedLabel,{animation})
end function

public function IupDatePick()
	return c_func(xIupDatePick,{})
end function

public function IupCalendar()
	return c_func(xIupCalendar,{})
end function

public function IupColorbar()
	return c_func(xIupColorbar,{})
end function

public function IupGauge()
	return c_func(xIupGauge,{})
end function

public function IupDial( object _type )
	return c_func(xIupDial,{_s(_type)})
end function

public function IupColorBrowser()
	return c_func(xIupColorBrowser,{})
end function

/* Old controls, use SPIN attribute of IupText */

public function IupSpin()
	return c_func(xIupSpin,{})
end function

public function IupSpinbox( atom child )
	return c_func(xIupSpinbox,{child})
end function

/************************************************************************/
/*                      Utilities                                       */
/************************************************************************/

/* String compare utility */

public function IupStringCompare( object str1, object str2, integer casesensitive, integer lexicographic )
	return c_func(xIupStringCompare,{_s(str1),_s(str2),casesensitive,lexicographic})
end function

/* IupImage utilities */

public function IupSaveImageAsText( atom ih, object filename, object format, object name )
	return c_func(xIupSaveImageAsText,{ih,_s(filename),_s(format),_s(name)})
end function

public function IupImageGetHandle( object name )
	return c_func(xIupImageGetHandle,{_s(name)})
end function

/* IupText and IupScintilla utilities */


public procedure IupTextConvertLinColToPos( atom ih, integer lin, integer col, atom pos )
	c_proc(xIupTextConvertLinColToPos,{ih,lin,col,pos})
end procedure


public procedure IupTextConvertPosToLinCol( atom ih, integer pos, atom lin, atom col )
	c_proc(xIupTextConvertPosToLinCol,{ih,pos,lin,col})
end procedure

/* IupText, IupList, IupTree, IupMatrix and IupScintilla utility */

public function IupConvertXYToPos( atom ih, integer x, integer y )
	return c_func(xIupConvertXYToPos,{ih,x,y})
end function

/* OLD names, kept for backward compatibility, will never be removed. */


public procedure IupStoreGlobal( object name, object value )
	c_proc(xIupStoreGlobal,{_s(name),_s(value)})
end procedure


public procedure IupStoreAttribute( atom ih, object name, object value )
	c_proc(xIupStoreAttribute,{ih,_s(name),_s(value)})
end procedure
public procedure IupSetfAttribute( atom ih, object name, object format, object args={} )

	if sequence( format ) and not equal( args, {} ) then
		format = sprintf( format, args )
	end if

	c_proc( xIupSetAttribute, {ih,_s(name),_s(format)} )

end procedure


public procedure IupStoreAttributeId( atom ih, object name, integer id, object value )
	c_proc(xIupStoreAttributeId,{ih,_s(name),id,_s(value)})
end procedure
--IUP_API void IupSetfAttributeId(Ihandle* ih, const char* name, int id, const char* f, ...);


public procedure IupStoreAttributeId2( atom ih, object name, integer lin, integer col, object value )
	c_proc(xIupStoreAttributeId2,{ih,_s(name),lin,col,_s(value)})
end procedure
--IUP_API void IupSetfAttributeId2(Ihandle* ih, const char* name, int lin, int col, const char* format, ...);

/* IupTree and IupFlatTree utilities (work for both) */

public function IupTreeSetUserId( atom ih, integer id, atom userid )
	return c_func(xIupTreeSetUserId,{ih,id,userid})
end function

public function IupTreeGetUserId( atom ih, integer id )
	return c_func(xIupTreeGetUserId,{ih,id})
end function

public function IupTreeGetId( atom ih, atom userid )
	return c_func(xIupTreeGetId,{ih,userid})
end function


public procedure IupTreeSetAttributeHandle( atom ih, object name, integer id, atom ih_named ) /* deprecated, use IupSetAttributeHandleId */
	c_proc(xIupTreeSetAttributeHandle,{ih,_s(name),id,ih_named})
end procedure

/************************************************************************/
/*                      Pre-defined dialogs                           */
/************************************************************************/


public function IupFileDlg()
	return c_func(xIupFileDlg,{})
end function

public function IupMessageDlg()
	return c_func(xIupMessageDlg,{})
end function

public function IupColorDlg()
	return c_func(xIupColorDlg,{})
end function

public function IupFontDlg()
	return c_func(xIupFontDlg,{})
end function

public function IupProgressDlg()
	return c_func(xIupProgressDlg,{})
end function


public function IupGetFile( sequence filename )

	atom ptr = allocate_data( 4096 )
	mem_set( ptr, NULL, length(ptr) )

	poke( ptr, filename )
	filename = ""

	integer result = c_func( xIupGetFile, {ptr} )

	if result != -1 then
		filename = peek_string( ptr )
	end if

	free( ptr )

	return filename
end function


public procedure IupMessage( object title, object msg )
	c_proc(xIupMessage,{_s(title),_s(msg)})
end procedure
--IUP_API void IupMessagef(const char *title, const char *format, ...);


public procedure IupMessageError( atom parent, object message )
	c_proc(xIupMessageError,{parent,_s(message)})
end procedure

public function IupMessageAlarm( atom parent, object title, object message, object buttons )
	return c_func(xIupMessageAlarm,{parent,_s(title),_s(message),_s(buttons)})
end function

public function IupAlarm( object title, object msg, object b1, object b2, object b3 )
	return c_func(xIupAlarm,{_s(title),_s(msg),_s(b1),_s(b2),_s(b3)})
end function
--IUP_API int  IupScanf(const char *format, ...);

public function IupListDialog( integer _type, object title, integer size, atom list, integer op, integer max_col, integer max_lin, atom marks )
	return c_func(xIupListDialog,{_type,_s(title),size,list,op,max_col,max_lin,marks})
end function

public function IupGetText( object title, atom text, integer maxsize )
	return c_func(xIupGetText,{_s(title),text,maxsize})
end function

public function IupGetColor( integer x, integer y )

	atom base = allocate_data( sizeof(C_UCHAR)*3 )

	atom r = base + sizeof(C_UCHAR) * 0
	atom g = base + sizeof(C_UCHAR) * 1
	atom b = base + sizeof(C_UCHAR) * 2

	if c_func( xIupGetColor, {x,y,r,g,b} ) then
		return peek({ base, 3 })
	end if

	r = peek( r )
	g = peek( g )
	b = peek( b )

	free( base )

	return {r,g,b}
end function

--typedef int (*Iparamcb)(Ihandle* dialog, int param_index, void* user_data);
--IUP_API int IupGetParam(const char* title, Iparamcb action, void* user_data, const char* format,...);

public function IupGetParam( object title, atom action, object format, atom user_data=NULL )

	sequence param_type = {}
	sequence param_string = {}
	integer param_extra = 0

	if sequence_array( format ) then
		format = stdseq:join( format, "\n" )
	end if

	integer n = 1

	while n <= length( format ) do
		if format[n] = '%' then
			n += 1
			integer is_string = FALSE
			switch format[n] do
				case 't','u','x' then
					param_extra += 1
				case 'a','r' then
					param_type &= C_FLOAT
				case 'A','R' then
					param_type &= C_DOUBLE
				case 'b','i','l','o' then
					param_type &= C_INT
				case 'c','d','f','h','m','n','s' then
					param_type &= C_POINTER
					is_string = (format[n] != 'h')
			end switch
			param_string &= is_string
		end if
		n += 1
	end while

	integer param_count = length( param_type )

	atom param_base = allocate_data( sizeof(C_POINTER)*param_count )
	mem_set( param_base, NULL, sizeof(C_POINTER)*param_count )

	atom param_data = param_base

	for i = 1 to param_count do

		integer size = sizeof( param_type[i] )

		if param_string[i] then
			size = 256
		end if

		atom ptr = allocate_data( size )
		mem_set( ptr, NULL, size )

		poke_pointer( param_data, ptr )
		param_data += sizeof( C_POINTER )

	end for

	param_data = param_base

	object result = c_func( xIupGetParamv, {
		_s(title),action,user_data,_s(format),param_count,param_extra,param_data
	} )

	if result then

		result = repeat( 0, param_count )

		for i = 1 to param_count do

			atom ptr = peek_pointer( param_data )

			switch param_type[i] do
				case C_INT then
					result[i] = peek4u( ptr )
				case C_FLOAT then
					result[i] = peek_float32( result[i] )
				case C_DOUBLE then
					result[i] = peek_float64( result[i] )
				case C_POINTER then
					if param_string[i] then
						result[i] = peek_string( ptr )
					else
						result[i] = peek_pointer( ptr )
					end if
			end switch

			param_data += sizeof( C_POINTER )
			free( ptr )

		end for

	end if

	free( param_base )

	return result
end function

public function IupParam( object format )
	return c_func(xIupParam,{_s(format)})
end function
--IUP_API Ihandle*  IupParamBox(Ihandle* param, ...);

public function IupParamBox( sequence param_array )
	return c_func(xIupParamBoxv,{_p(param_array)})
end function


public function IupLayoutDialog( atom dialog )
	return c_func(xIupLayoutDialog,{dialog})
end function

public function IupElementPropertiesDialog( atom parent, atom elem )
	return c_func(xIupElementPropertiesDialog,{parent,elem})
end function

public function IupGlobalsDialog()
	return c_func(xIupGlobalsDialog,{})
end function

public function IupClassInfoDialog( atom parent )
	return c_func(xIupClassInfoDialog,{parent})
end function

--#ifdef __cplusplus
--}
--#endif

/************************************************************************/
/*                   Common Flags and Return Values                     */
/************************************************************************/
public constant IUP_ERROR = 1
public constant IUP_NOERROR = 0
public constant IUP_OPENED = -1
public constant IUP_INVALID = -1
public constant IUP_INVALID_ID = -10

/************************************************************************/
/*                   Callback Return Values                             */
/************************************************************************/
public constant IUP_IGNORE = -1
public constant IUP_DEFAULT = -2
public constant IUP_CLOSE = -3
public constant IUP_CONTINUE = -4

/************************************************************************/
/*           IupPopup and IupShowXY Parameter Values                    */
/************************************************************************/
public constant IUP_CENTER = 0xFFFF /* 65535 */
public constant IUP_LEFT = 0xFFFE /* 65534 */
public constant IUP_RIGHT = 0xFFFD /* 65533 */
public constant IUP_MOUSEPOS = 0xFFFC /* 65532 */
public constant IUP_CURRENT = 0xFFFB /* 65531 */
public constant IUP_CENTERPARENT = 0xFFFA /* 65530 */
public constant IUP_LEFTPARENT = 0xFFF9 /* 65529 */
public constant IUP_RIGHTPARENT = 0xFFF8 /* 65528 */
public constant IUP_TOP = IUP_LEFT
public constant IUP_BOTTOM = IUP_RIGHT
public constant IUP_TOPPARENT = IUP_LEFTPARENT
public constant IUP_BOTTOMPARENT = IUP_RIGHTPARENT

/************************************************************************/
/*               SHOW_CB Callback Values                                */
/************************************************************************/
public enum
	IUP_SHOW = 0,
	IUP_RESTORE,
	IUP_MINIMIZE,
	IUP_MAXIMIZE,
	IUP_HIDE

/************************************************************************/
/*               SCROLL_CB Callback Values                              */
/************************************************************************/
public enum
	IUP_SBUP = 0,
	IUP_SBDN,
	IUP_SBPGUP,
	IUP_SBPGDN,
	IUP_SBPOSV,
	IUP_SBDRAGV,
	IUP_SBLEFT,
	IUP_SBRIGHT,
	IUP_SBPGLEFT,
	IUP_SBPGRIGHT,
	IUP_SBPOSH,
	IUP_SBDRAGH

/************************************************************************/
/*               Mouse Button Values and Macros                         */
/************************************************************************/
public constant IUP_BUTTON1 = '1'
public constant IUP_BUTTON2 = '2'
public constant IUP_BUTTON3 = '3'
public constant IUP_BUTTON4 = '4'
public constant IUP_BUTTON5 = '5'

public function iup_isshift( sequence _s )   return (_s[ 1] = 'S') end function
public function iup_iscontrol( sequence _s ) return (_s[ 2] = 'C') end function
public function iup_isbutton1( sequence _s ) return (_s[ 3] = '1') end function
public function iup_isbutton2( sequence _s ) return (_s[ 4] = '2') end function
public function iup_isbutton3( sequence _s ) return (_s[ 5] = '3') end function
public function iup_isdouble( sequence _s )  return (_s[ 6] = 'D') end function
public function iup_isalt( sequence _s )     return (_s[ 7] = 'A') end function
public function iup_issys( sequence _s )     return (_s[ 8] = 'Y') end function
public function iup_isbutton4( sequence _s ) return (_s[ 9] = '4') end function
public function iup_isbutton5( sequence _s ) return (_s[10] = '5') end function

/* Old definitions for backward compatibility */
--#define isshift     iup_isshift
--#define iscontrol   iup_iscontrol
--#define isbutton1   iup_isbutton1
--#define isbutton2   iup_isbutton2
--#define isbutton3   iup_isbutton3
--#define isdouble    iup_isdouble
--#define isalt       iup_isalt
--#define issys       iup_issys
--#define isbutton4   iup_isbutton4
--#define isbutton5   iup_isbutton5

/************************************************************************/
/*                      Pre-Defined Masks                               */
/************************************************************************/
public constant IUP_MASK_FLOAT = "[+/-]?(/d+/.?/d*|/./d+)"
public constant IUP_MASK_UFLOAT = "(/d+/.?/d*|/./d+)"
public constant IUP_MASK_EFLOAT = "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
public constant IUP_MASK_UEFLOAT = "(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"
public constant IUP_MASK_FLOATCOMMA = "[+/-]?(/d+/,?/d*|/,/d+)"
public constant IUP_MASK_UFLOATCOMMA = "(/d+/,?/d*|/,/d+)"
public constant IUP_MASK_INT = "[+/-]?/d+"
public constant IUP_MASK_UINT = "/d+"

/* Old definitions for backward compatibility */
--#define IUPMASK_FLOAT     IUP_MASK_FLOAT
--#define IUPMASK_UFLOAT    IUP_MASK_UFLOAT
--#define IUPMASK_EFLOAT    IUP_MASK_EFLOAT
--#define IUPMASK_INT       IUP_MASK_INT
--#define IUPMASK_UINT      IUP_MASK_UINT

/************************************************************************/
/*                   IupGetParam Callback situations                    */
/************************************************************************/
public constant IUP_GETPARAM_BUTTON1 = -1
public constant IUP_GETPARAM_INIT = -2
public constant IUP_GETPARAM_BUTTON2 = -3
public constant IUP_GETPARAM_BUTTON3 = -4
public constant IUP_GETPARAM_CLOSE = -5
public constant IUP_GETPARAM_MAP = -6
public constant IUP_GETPARAM_OK = IUP_GETPARAM_BUTTON1
public constant IUP_GETPARAM_CANCEL = IUP_GETPARAM_BUTTON2
public constant IUP_GETPARAM_HELP = IUP_GETPARAM_BUTTON3

/************************************************************************/
/*                   Used by IupColorbar                                */
/************************************************************************/
public constant IUP_PRIMARY = -1
public constant IUP_SECONDARY = -2

/************************************************************************/
/*                   Record Input Modes                                 */
/************************************************************************/
public enum
	IUP_RECBINARY = 0,
	IUP_RECTEXT

/************************************************************************/
/*              Replacement for the WinMain in Windows,                 */
/*        this allows the application to start from "main".             */
/*        Used only for Watcom.                                         */
/************************************************************************/
--#if defined (__WATCOMC__)
--#ifdef __cplusplus
--extern "C" {
--int IupMain (int argc, char** argv); /* In C++ we have to declare the prototype */
--}
--#endif
--#define main IupMain /* this is the trick for Watcom and MetroWerks */
--#endif

/******************************************************************************
 * Copyright (C) 1994-2019 Tecgraf/PUC-Rio.
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 ******************************************************************************/

--#endif
