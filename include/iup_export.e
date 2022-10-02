
public include std/cmdline.e
public include std/convert.e
public include std/error.e
public include std/ffi.e
public include std/filesys.e
public include std/io.e
public include std/machine.e
public include std/map.e
public include std/math.e
public include std/sequence.e
public include std/sort.e
public include std/text.e
public include std/types.e

without warning += { override }

--
-- Additional C types used by iup_scintilla.
--
export constant C_INTPTR_T = C_LONG_PTR
export constant C_UINTPTR_T = C_POINTER

--
-- Shorthand function for allocating a byte array.
--
export function _b( object data, integer cleanup=TRUE )

	if sequence( data ) then

		atom ptr = allocate_data( length(data)+1, cleanup )
		poke( ptr, data )
		poke( ptr + length(data), NULL )

		data = ptr
	end if

	return data
end function

--
-- Shorthand function for allocating a pointer array.
--
export function _p( object data, integer cleanup=TRUE )

	if sequence( data ) then

		atom ptr = allocate_data( sizeof(C_POINTER)*(length(data)+1), cleanup )
		poke_pointer( ptr, data )
		poke_pointer( ptr + (sizeof(C_POINTER)*length(data)), NULL )

		data = ptr
	end if

	return data
end function

--
-- Shorthand function for allocating a string.
--
export function _s( object data, integer cleanup=TRUE )
	if atom( data ) then return data end if
	return allocate_string( data, cleanup )
end function

--
-- Override peek_string() so it returns an empty
-- string when trying to peek at a NULL pointer.
--
override function peek_string( atom ptr )

	if ptr = NULL then
		return ""
	end if

	return eu:peek_string( ptr )
end function

--
-- Peek a 32-bit float from memory.
--
export function peek_float32( atom ptr )
	return float32_to_atom( peek({ ptr, sizeof(C_FLOAT) }) )
end function

--
-- Peek a 64-bit double from memory.
--
export function peek_float64( atom ptr )
	return float64_to_atom( peek({ ptr, sizeof(C_DOUBLE) }) )
end function

constant M_OPEN_DLL = 50
export object m_library = map:new()

--
-- Open a shared library and cache the result.
--
export function iup_open( sequence name )

	atom lib = map:get( m_library, name, NULL )

	if lib != NULL then
		return lib
	end if

	sequence cname

ifdef WINDOWS then
	cname = sprintf( "%s.dll", {name} )
elsifdef LINUX then
	cname = sprintf( "lib%s.so", {name} )
end ifdef

--	lib = machine_func( M_OPEN_DLL, cname )
	lib = ffi:open_dll( cname )

ifdef IUP_DEBUG then
	printf( STDERR, "0x%08x iup_open( \"%s\" )\n", {lib,name} )
end ifdef

	if lib = NULL then
		error:crash( "library \"%s\" not found!", {cname} )
	end if

	map:put( m_library, name, lib )

	return lib
end function

constant M_DEFINE_C = 51
export object m_function = map:new()

--
-- Define a C function and cache the result.
--
export function iup_func( atom lib, sequence name, sequence ptypes, atom rtype )

	integer id = map:get( m_function, {lib,name,ptypes,rtype}, -1 )

	if id != -1 then
		return id
	end if

	sequence cname = name

ifdef WINDOWS and BITS32 then
	-- use CDECL on 32-bit Windows
	cname = '+' & cname
end ifdef

--	id = machine_func( M_DEFINE_C, {lib,cname,ptypes,rtype} )
	id = ffi:define_c_func( lib, cname, ptypes, rtype )

ifdef IUP_DEBUG then
	printf( STDERR, "%d iup_func( 0x%08x, \"%s\", ... )\n", {id,lib,name} )
end ifdef

	if id = -1 then
		error:crash( "function \"%s\" not found!", {name} )
	end if

	map:put( m_function, {lib,name,ptypes,rtype}, id )

	return id
end function

/**
 * Define a C procedure and cache the result.
 */
export function iup_proc( atom lib, sequence name, sequence ptypes )
	return iup_func( lib, name, ptypes, C_VOID )
end function

export object m_callback = map:new()

/**
 * Define a C callback and cache the result.
 */
public function Icallback( sequence name, object arg_types=C_VOID, atom rtype=C_INT, integer id=routine_id(name) )

	if id = -1 then
		return NULL
	end if

	atom cb = map:get( m_callback, name, NULL )

	if cb != NULL then
		return cb
	end if

	object cid = id

	ifdef WINDOWS and BITS32 then
		cid = {'+',id}
	end ifdef

	cb = call_back( cid, arg_types, rtype )

ifdef IUP_DEBUG then
	printf( STDERR, "0x%08x Icallback( \"%s\", %d )\n", {cb,name,id} )
end ifdef

	if cb = NULL then
		error:crash( "callback \"%s\" not found!", {name} )
	end if

	map:put( m_callback, name, cb )

	return cb
end function

export constant iup = iup_open( "iup" )
export constant iupimglib = iup_open( "iupimglib" )

export constant xIupOpen = iup_func( iup, "IupOpen", {C_POINTER,C_POINTER}, C_INT )
export constant xIupClose = iup_proc( iup, "IupClose", {} )
export constant xIupIsOpened = iup_func( iup, "IupIsOpened", {}, C_INT )
export constant xIupImageLibOpen = iup_proc( iupimglib, "IupImageLibOpen", {} )
export constant xIupMainLoop = iup_func( iup, "IupMainLoop", {}, C_INT )
export constant xIupLoopStep = iup_func( iup, "IupLoopStep", {}, C_INT )
export constant xIupLoopStepWait = iup_func( iup, "IupLoopStepWait", {}, C_INT )
export constant xIupMainLoopLevel = iup_func( iup, "IupMainLoopLevel", {}, C_INT )
export constant xIupFlush = iup_proc( iup, "IupFlush", {} )
export constant xIupExitLoop = iup_proc( iup, "IupExitLoop", {} )
export constant xIupPostMessage = iup_proc( iup, "IupPostMessage", {C_POINTER,C_POINTER,C_INT,C_DOUBLE,C_POINTER} )
export constant xIupRecordInput = iup_func( iup, "IupRecordInput", {C_POINTER,C_INT}, C_INT )
export constant xIupPlayInput = iup_func( iup, "IupPlayInput", {C_POINTER}, C_INT )
export constant xIupUpdate = iup_proc( iup, "IupUpdate", {C_POINTER} )
export constant xIupUpdateChildren = iup_proc( iup, "IupUpdateChildren", {C_POINTER} )
export constant xIupRedraw = iup_proc( iup, "IupRedraw", {C_POINTER,C_INT} )
export constant xIupRefresh = iup_proc( iup, "IupRefresh", {C_POINTER} )
export constant xIupRefreshChildren = iup_proc( iup, "IupRefreshChildren", {C_POINTER} )
export constant xIupExecute = iup_func( iup, "IupExecute", {C_POINTER,C_POINTER}, C_INT )
export constant xIupExecuteWait = iup_func( iup, "IupExecuteWait", {C_POINTER,C_POINTER}, C_INT )
export constant xIupHelp = iup_func( iup, "IupHelp", {C_POINTER}, C_INT )
export constant xIupLoad = iup_func( iup, "IupLoad", {C_POINTER}, C_POINTER )
export constant xIupLoadBuffer = iup_func( iup, "IupLoadBuffer", {C_POINTER}, C_POINTER )
export constant xIupVersion = iup_func( iup, "IupVersion", {}, C_POINTER )
export constant xIupVersionDate = iup_func( iup, "IupVersionDate", {}, C_POINTER )
export constant xIupVersionNumber = iup_func( iup, "IupVersionNumber", {}, C_INT )
export constant xIupVersionShow = iup_proc( iup, "IupVersionShow", {} )
export constant xIupSetLanguage = iup_proc( iup, "IupSetLanguage", {C_POINTER} )
export constant xIupGetLanguage = iup_func( iup, "IupGetLanguage", {}, C_POINTER )
export constant xIupSetLanguageString = iup_proc( iup, "IupSetLanguageString", {C_POINTER,C_POINTER} )
export constant xIupStoreLanguageString = iup_proc( iup, "IupStoreLanguageString", {C_POINTER,C_POINTER} )
export constant xIupGetLanguageString = iup_func( iup, "IupGetLanguageString", {C_POINTER}, C_POINTER )
export constant xIupSetLanguagePack = iup_proc( iup, "IupSetLanguagePack", {C_POINTER} )
export constant xIupDestroy = iup_proc( iup, "IupDestroy", {C_POINTER} )
export constant xIupDetach = iup_proc( iup, "IupDetach", {C_POINTER} )
export constant xIupAppend = iup_func( iup, "IupAppend", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupInsert = iup_func( iup, "IupInsert", {C_POINTER,C_POINTER,C_POINTER}, C_POINTER )
export constant xIupGetChild = iup_func( iup, "IupGetChild", {C_POINTER,C_INT}, C_POINTER )
export constant xIupGetChildPos = iup_func( iup, "IupGetChildPos", {C_POINTER,C_POINTER}, C_INT )
export constant xIupGetChildCount = iup_func( iup, "IupGetChildCount", {C_POINTER}, C_INT )
export constant xIupGetNextChild = iup_func( iup, "IupGetNextChild", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupGetBrother = iup_func( iup, "IupGetBrother", {C_POINTER}, C_POINTER )
export constant xIupGetParent = iup_func( iup, "IupGetParent", {C_POINTER}, C_POINTER )
export constant xIupGetDialog = iup_func( iup, "IupGetDialog", {C_POINTER}, C_POINTER )
export constant xIupGetDialogChild = iup_func( iup, "IupGetDialogChild", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupReparent = iup_func( iup, "IupReparent", {C_POINTER,C_POINTER,C_POINTER}, C_INT )
export constant xIupPopup = iup_func( iup, "IupPopup", {C_POINTER,C_INT,C_INT}, C_INT )
export constant xIupShow = iup_func( iup, "IupShow", {C_POINTER}, C_INT )
export constant xIupShowXY = iup_func( iup, "IupShowXY", {C_POINTER,C_INT,C_INT}, C_INT )
export constant xIupHide = iup_func( iup, "IupHide", {C_POINTER}, C_INT )
export constant xIupMap = iup_func( iup, "IupMap", {C_POINTER}, C_INT )
export constant xIupUnmap = iup_proc( iup, "IupUnmap", {C_POINTER} )
export constant xIupResetAttribute = iup_proc( iup, "IupResetAttribute", {C_POINTER,C_POINTER} )
export constant xIupGetAllAttributes = iup_func( iup, "IupGetAllAttributes", {C_POINTER,C_POINTER,C_INT}, C_INT )
export constant xIupCopyAttributes = iup_proc( iup, "IupCopyAttributes", {C_POINTER,C_POINTER} )
export constant xIupSetAttributes = iup_func( iup, "IupSetAttributes", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupGetAttributes = iup_func( iup, "IupGetAttributes", {C_POINTER}, C_POINTER )
export constant xIupSetAttribute = iup_proc( iup, "IupSetAttribute", {C_POINTER,C_POINTER,C_POINTER} )
export constant xIupSetStrAttribute = iup_proc( iup, "IupSetStrAttribute", {C_POINTER,C_POINTER,C_POINTER} )
export constant xIupSetInt = iup_proc( iup, "IupSetInt", {C_POINTER,C_POINTER,C_INT} )
export constant xIupSetFloat = iup_proc( iup, "IupSetFloat", {C_POINTER,C_POINTER,C_FLOAT} )
export constant xIupSetDouble = iup_proc( iup, "IupSetDouble", {C_POINTER,C_POINTER,C_DOUBLE} )
export constant xIupSetRGB = iup_proc( iup, "IupSetRGB", {C_POINTER,C_POINTER,C_UCHAR,C_UCHAR,C_UCHAR} )
export constant xIupSetRGBA = iup_proc( iup, "IupSetRGBA", {C_POINTER,C_POINTER,C_UCHAR,C_UCHAR,C_UCHAR,C_UCHAR} )
export constant xIupGetAttribute = iup_func( iup, "IupGetAttribute", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupGetInt = iup_func( iup, "IupGetInt", {C_POINTER,C_POINTER}, C_INT )
export constant xIupGetInt2 = iup_func( iup, "IupGetInt2", {C_POINTER,C_POINTER}, C_INT )
export constant xIupGetIntInt = iup_func( iup, "IupGetIntInt", {C_POINTER,C_POINTER,C_POINTER,C_POINTER}, C_INT )
export constant xIupGetFloat = iup_func( iup, "IupGetFloat", {C_POINTER,C_POINTER}, C_FLOAT )
export constant xIupGetDouble = iup_func( iup, "IupGetDouble", {C_POINTER,C_POINTER}, C_DOUBLE )
export constant xIupGetRGB = iup_proc( iup, "IupGetRGB", {C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER} )
export constant xIupGetRGBA = iup_proc( iup, "IupGetRGBA", {C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER} )
export constant xIupSetAttributeId = iup_proc( iup, "IupSetAttributeId", {C_POINTER,C_POINTER,C_INT,C_POINTER} )
export constant xIupSetStrAttributeId = iup_proc( iup, "IupSetStrAttributeId", {C_POINTER,C_POINTER,C_INT,C_POINTER} )
export constant xIupSetIntId = iup_proc( iup, "IupSetIntId", {C_POINTER,C_POINTER,C_INT,C_INT} )
export constant xIupSetFloatId = iup_proc( iup, "IupSetFloatId", {C_POINTER,C_POINTER,C_INT,C_FLOAT} )
export constant xIupSetDoubleId = iup_proc( iup, "IupSetDoubleId", {C_POINTER,C_POINTER,C_INT,C_DOUBLE} )
export constant xIupSetRGBId = iup_proc( iup, "IupSetRGBId", {C_POINTER,C_POINTER,C_INT,C_UCHAR,C_UCHAR,C_UCHAR} )
export constant xIupGetAttributeId = iup_func( iup, "IupGetAttributeId", {C_POINTER,C_POINTER,C_INT}, C_POINTER )
export constant xIupGetIntId = iup_func( iup, "IupGetIntId", {C_POINTER,C_POINTER,C_INT}, C_INT )
export constant xIupGetFloatId = iup_func( iup, "IupGetFloatId", {C_POINTER,C_POINTER,C_INT}, C_FLOAT )
export constant xIupGetDoubleId = iup_func( iup, "IupGetDoubleId", {C_POINTER,C_POINTER,C_INT}, C_DOUBLE )
export constant xIupGetRGBId = iup_proc( iup, "IupGetRGBId", {C_POINTER,C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER} )
export constant xIupSetAttributeId2 = iup_proc( iup, "IupSetAttributeId2", {C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER} )
export constant xIupSetStrAttributeId2 = iup_proc( iup, "IupSetStrAttributeId2", {C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER} )
export constant xIupSetIntId2 = iup_proc( iup, "IupSetIntId2", {C_POINTER,C_POINTER,C_INT,C_INT,C_INT} )
export constant xIupSetFloatId2 = iup_proc( iup, "IupSetFloatId2", {C_POINTER,C_POINTER,C_INT,C_INT,C_FLOAT} )
export constant xIupSetDoubleId2 = iup_proc( iup, "IupSetDoubleId2", {C_POINTER,C_POINTER,C_INT,C_INT,C_DOUBLE} )
export constant xIupSetRGBId2 = iup_proc( iup, "IupSetRGBId2", {C_POINTER,C_POINTER,C_INT,C_INT,C_UCHAR,C_UCHAR,C_UCHAR} )
export constant xIupGetAttributeId2 = iup_func( iup, "IupGetAttributeId2", {C_POINTER,C_POINTER,C_INT,C_INT}, C_POINTER )
export constant xIupGetIntId2 = iup_func( iup, "IupGetIntId2", {C_POINTER,C_POINTER,C_INT,C_INT}, C_INT )
export constant xIupGetFloatId2 = iup_func( iup, "IupGetFloatId2", {C_POINTER,C_POINTER,C_INT,C_INT}, C_FLOAT )
export constant xIupGetDoubleId2 = iup_func( iup, "IupGetDoubleId2", {C_POINTER,C_POINTER,C_INT,C_INT}, C_DOUBLE )
export constant xIupGetRGBId2 = iup_proc( iup, "IupGetRGBId2", {C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER,C_POINTER,C_POINTER} )
export constant xIupSetGlobal = iup_proc( iup, "IupSetGlobal", {C_POINTER,C_POINTER} )
export constant xIupSetStrGlobal = iup_proc( iup, "IupSetStrGlobal", {C_POINTER,C_POINTER} )
export constant xIupGetGlobal = iup_func( iup, "IupGetGlobal", {C_POINTER}, C_POINTER )
export constant xIupSetFocus = iup_func( iup, "IupSetFocus", {C_POINTER}, C_POINTER )
export constant xIupGetFocus = iup_func( iup, "IupGetFocus", {}, C_POINTER )
export constant xIupPreviousField = iup_func( iup, "IupPreviousField", {C_POINTER}, C_POINTER )
export constant xIupNextField = iup_func( iup, "IupNextField", {C_POINTER}, C_POINTER )
export constant xIupGetCallback = iup_func( iup, "IupGetCallback", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupSetCallback = iup_func( iup, "IupSetCallback", {C_POINTER,C_POINTER,C_POINTER}, C_POINTER )
export constant xIupGetFunction = iup_func( iup, "IupGetFunction", {C_POINTER}, C_POINTER )
export constant xIupSetFunction = iup_func( iup, "IupSetFunction", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupGetHandle = iup_func( iup, "IupGetHandle", {C_POINTER}, C_POINTER )
export constant xIupSetHandle = iup_func( iup, "IupSetHandle", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupGetAllNames = iup_func( iup, "IupGetAllNames", {C_POINTER,C_INT}, C_INT )
export constant xIupGetAllDialogs = iup_func( iup, "IupGetAllDialogs", {C_POINTER,C_INT}, C_INT )
export constant xIupGetName = iup_func( iup, "IupGetName", {C_POINTER}, C_POINTER )
export constant xIupSetAttributeHandle = iup_proc( iup, "IupSetAttributeHandle", {C_POINTER,C_POINTER,C_POINTER} )
export constant xIupGetAttributeHandle = iup_func( iup, "IupGetAttributeHandle", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupSetAttributeHandleId = iup_proc( iup, "IupSetAttributeHandleId", {C_POINTER,C_POINTER,C_INT,C_POINTER} )
export constant xIupGetAttributeHandleId = iup_func( iup, "IupGetAttributeHandleId", {C_POINTER,C_POINTER,C_INT}, C_POINTER )
export constant xIupSetAttributeHandleId2 = iup_proc( iup, "IupSetAttributeHandleId2", {C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER} )
export constant xIupGetAttributeHandleId2 = iup_func( iup, "IupGetAttributeHandleId2", {C_POINTER,C_POINTER,C_INT,C_INT}, C_POINTER )
export constant xIupGetClassName = iup_func( iup, "IupGetClassName", {C_POINTER}, C_POINTER )
export constant xIupGetClassType = iup_func( iup, "IupGetClassType", {C_POINTER}, C_POINTER )
export constant xIupGetAllClasses = iup_func( iup, "IupGetAllClasses", {C_POINTER,C_INT}, C_INT )
export constant xIupGetClassAttributes = iup_func( iup, "IupGetClassAttributes", {C_POINTER,C_POINTER,C_INT}, C_INT )
export constant xIupGetClassCallbacks = iup_func( iup, "IupGetClassCallbacks", {C_POINTER,C_POINTER,C_INT}, C_INT )
export constant xIupSaveClassAttributes = iup_proc( iup, "IupSaveClassAttributes", {C_POINTER} )
export constant xIupCopyClassAttributes = iup_proc( iup, "IupCopyClassAttributes", {C_POINTER,C_POINTER} )
export constant xIupSetClassDefaultAttribute = iup_proc( iup, "IupSetClassDefaultAttribute", {C_POINTER,C_POINTER,C_POINTER} )
export constant xIupClassMatch = iup_func( iup, "IupClassMatch", {C_POINTER,C_POINTER}, C_INT )
export constant xIupCreatev = iup_func( iup, "IupCreatev", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupFill = iup_func( iup, "IupFill", {}, C_POINTER )
export constant xIupSpace = iup_func( iup, "IupSpace", {}, C_POINTER )
export constant xIupRadio = iup_func( iup, "IupRadio", {C_POINTER}, C_POINTER )
export constant xIupVboxv = iup_func( iup, "IupVboxv", {C_POINTER}, C_POINTER )
export constant xIupZboxv = iup_func( iup, "IupZboxv", {C_POINTER}, C_POINTER )
export constant xIupHboxv = iup_func( iup, "IupHboxv", {C_POINTER}, C_POINTER )
export constant xIupNormalizerv = iup_func( iup, "IupNormalizerv", {C_POINTER}, C_POINTER )
export constant xIupCboxv = iup_func( iup, "IupCboxv", {C_POINTER}, C_POINTER )
export constant xIupSbox = iup_func( iup, "IupSbox", {C_POINTER}, C_POINTER )
export constant xIupSplit = iup_func( iup, "IupSplit", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupScrollBox = iup_func( iup, "IupScrollBox", {C_POINTER}, C_POINTER )
export constant xIupFlatScrollBox = iup_func( iup, "IupFlatScrollBox", {C_POINTER}, C_POINTER )
export constant xIupGridBoxv = iup_func( iup, "IupGridBoxv", {C_POINTER}, C_POINTER )
export constant xIupMultiBoxv = iup_func( iup, "IupMultiBoxv", {C_POINTER}, C_POINTER )
export constant xIupExpander = iup_func( iup, "IupExpander", {C_POINTER}, C_POINTER )
export constant xIupDetachBox = iup_func( iup, "IupDetachBox", {C_POINTER}, C_POINTER )
export constant xIupBackgroundBox = iup_func( iup, "IupBackgroundBox", {C_POINTER}, C_POINTER )
export constant xIupFrame = iup_func( iup, "IupFrame", {C_POINTER}, C_POINTER )
export constant xIupFlatFrame = iup_func( iup, "IupFlatFrame", {C_POINTER}, C_POINTER )
export constant xIupImage = iup_func( iup, "IupImage", {C_INT,C_INT,C_POINTER}, C_POINTER )
export constant xIupImageRGB = iup_func( iup, "IupImageRGB", {C_INT,C_INT,C_POINTER}, C_POINTER )
export constant xIupImageRGBA = iup_func( iup, "IupImageRGBA", {C_INT,C_INT,C_POINTER}, C_POINTER )
export constant xIupItem = iup_func( iup, "IupItem", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupSubmenu = iup_func( iup, "IupSubmenu", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupSeparator = iup_func( iup, "IupSeparator", {}, C_POINTER )
export constant xIupMenuv = iup_func( iup, "IupMenuv", {C_POINTER}, C_POINTER )
export constant xIupButton = iup_func( iup, "IupButton", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupFlatButton = iup_func( iup, "IupFlatButton", {C_POINTER}, C_POINTER )
export constant xIupFlatToggle = iup_func( iup, "IupFlatToggle", {C_POINTER}, C_POINTER )
export constant xIupDropButton = iup_func( iup, "IupDropButton", {C_POINTER}, C_POINTER )
export constant xIupFlatLabel = iup_func( iup, "IupFlatLabel", {C_POINTER}, C_POINTER )
export constant xIupFlatSeparator = iup_func( iup, "IupFlatSeparator", {}, C_POINTER )
export constant xIupCanvas = iup_func( iup, "IupCanvas", {C_POINTER}, C_POINTER )
export constant xIupDialog = iup_func( iup, "IupDialog", {C_POINTER}, C_POINTER )
export constant xIupUser = iup_func( iup, "IupUser", {}, C_POINTER )
export constant xIupThread = iup_func( iup, "IupThread", {}, C_POINTER )
export constant xIupLabel = iup_func( iup, "IupLabel", {C_POINTER}, C_POINTER )
export constant xIupList = iup_func( iup, "IupList", {C_POINTER}, C_POINTER )
export constant xIupFlatList = iup_func( iup, "IupFlatList", {}, C_POINTER )
export constant xIupText = iup_func( iup, "IupText", {C_POINTER}, C_POINTER )
export constant xIupMultiLine = iup_func( iup, "IupMultiLine", {C_POINTER}, C_POINTER )
export constant xIupToggle = iup_func( iup, "IupToggle", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupTimer = iup_func( iup, "IupTimer", {}, C_POINTER )
export constant xIupClipboard = iup_func( iup, "IupClipboard", {}, C_POINTER )
export constant xIupProgressBar = iup_func( iup, "IupProgressBar", {}, C_POINTER )
export constant xIupVal = iup_func( iup, "IupVal", {C_POINTER}, C_POINTER )
export constant xIupFlatVal = iup_func( iup, "IupFlatVal", {C_POINTER}, C_POINTER )
export constant xIupFlatTree = iup_func( iup, "IupFlatTree", {}, C_POINTER )
export constant xIupTabsv = iup_func( iup, "IupTabsv", {C_POINTER}, C_POINTER )
export constant xIupFlatTabsv = iup_func( iup, "IupFlatTabsv", {C_POINTER}, C_POINTER )
export constant xIupTree = iup_func( iup, "IupTree", {}, C_POINTER )
export constant xIupLink = iup_func( iup, "IupLink", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupAnimatedLabel = iup_func( iup, "IupAnimatedLabel", {C_POINTER}, C_POINTER )
export constant xIupDatePick = iup_func( iup, "IupDatePick", {}, C_POINTER )
export constant xIupCalendar = iup_func( iup, "IupCalendar", {}, C_POINTER )
export constant xIupColorbar = iup_func( iup, "IupColorbar", {}, C_POINTER )
export constant xIupGauge = iup_func( iup, "IupGauge", {}, C_POINTER )
export constant xIupDial = iup_func( iup, "IupDial", {C_POINTER}, C_POINTER )
export constant xIupColorBrowser = iup_func( iup, "IupColorBrowser", {}, C_POINTER )
export constant xIupSpin = iup_func( iup, "IupSpin", {}, C_POINTER )
export constant xIupSpinbox = iup_func( iup, "IupSpinbox", {C_POINTER}, C_POINTER )
export constant xIupStringCompare = iup_func( iup, "IupStringCompare", {C_POINTER,C_POINTER,C_INT,C_INT}, C_INT )
export constant xIupSaveImageAsText = iup_func( iup, "IupSaveImageAsText", {C_POINTER,C_POINTER,C_POINTER,C_POINTER}, C_INT )
export constant xIupImageGetHandle = iup_func( iup, "IupImageGetHandle", {C_POINTER}, C_POINTER )
export constant xIupTextConvertLinColToPos = iup_proc( iup, "IupTextConvertLinColToPos", {C_POINTER,C_INT,C_INT,C_POINTER} )
export constant xIupTextConvertPosToLinCol = iup_proc( iup, "IupTextConvertPosToLinCol", {C_POINTER,C_INT,C_POINTER,C_POINTER} )
export constant xIupConvertXYToPos = iup_func( iup, "IupConvertXYToPos", {C_POINTER,C_INT,C_INT}, C_INT )
export constant xIupStoreGlobal = iup_proc( iup, "IupStoreGlobal", {C_POINTER,C_POINTER} )
export constant xIupStoreAttribute = iup_proc( iup, "IupStoreAttribute", {C_POINTER,C_POINTER,C_POINTER} )
export constant xIupStoreAttributeId = iup_proc( iup, "IupStoreAttributeId", {C_POINTER,C_POINTER,C_INT,C_POINTER} )
export constant xIupStoreAttributeId2 = iup_proc( iup, "IupStoreAttributeId2", {C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER} )
export constant xIupTreeSetUserId = iup_func( iup, "IupTreeSetUserId", {C_POINTER,C_INT,C_POINTER}, C_INT )
export constant xIupTreeGetUserId = iup_func( iup, "IupTreeGetUserId", {C_POINTER,C_INT}, C_POINTER )
export constant xIupTreeGetId = iup_func( iup, "IupTreeGetId", {C_POINTER,C_POINTER}, C_INT )
export constant xIupTreeSetAttributeHandle = iup_proc( iup, "IupTreeSetAttributeHandle", {C_POINTER,C_POINTER,C_INT,C_POINTER} )
export constant xIupFileDlg = iup_func( iup, "IupFileDlg", {}, C_POINTER )
export constant xIupMessageDlg = iup_func( iup, "IupMessageDlg", {}, C_POINTER )
export constant xIupColorDlg = iup_func( iup, "IupColorDlg", {}, C_POINTER )
export constant xIupFontDlg = iup_func( iup, "IupFontDlg", {}, C_POINTER )
export constant xIupProgressDlg = iup_func( iup, "IupProgressDlg", {}, C_POINTER )
export constant xIupGetFile = iup_func( iup, "IupGetFile", {C_POINTER}, C_INT )
export constant xIupMessage = iup_proc( iup, "IupMessage", {C_POINTER,C_POINTER} )
export constant xIupMessageError = iup_proc( iup, "IupMessageError", {C_POINTER,C_POINTER} )
export constant xIupMessageAlarm = iup_func( iup, "IupMessageAlarm", {C_POINTER,C_POINTER,C_POINTER,C_POINTER}, C_INT )
export constant xIupAlarm = iup_func( iup, "IupAlarm", {C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_POINTER}, C_INT )
export constant xIupListDialog = iup_func( iup, "IupListDialog", {C_INT,C_POINTER,C_INT,C_POINTER,C_INT,C_INT,C_INT,C_POINTER}, C_INT )
export constant xIupGetText = iup_func( iup, "IupGetText", {C_POINTER,C_POINTER,C_INT}, C_INT )
export constant xIupGetColor = iup_func( iup, "IupGetColor", {C_INT,C_INT,C_POINTER,C_POINTER,C_POINTER}, C_INT )
export constant xIupGetParamv = iup_func( iup, "IupGetParamv", {C_POINTER,C_POINTER,C_POINTER,C_POINTER,C_INT,C_INT,C_POINTER}, C_INT )
export constant xIupParam = iup_func( iup, "IupParam", {C_POINTER}, C_POINTER )
export constant xIupParamBoxv = iup_func( iup, "IupParamBoxv", {C_POINTER}, C_POINTER )
export constant xIupLayoutDialog = iup_func( iup, "IupLayoutDialog", {C_POINTER}, C_POINTER )
export constant xIupElementPropertiesDialog = iup_func( iup, "IupElementPropertiesDialog", {C_POINTER,C_POINTER}, C_POINTER )
export constant xIupGlobalsDialog = iup_func( iup, "IupGlobalsDialog", {}, C_POINTER )
export constant xIupClassInfoDialog = iup_func( iup, "IupClassInfoDialog", {C_POINTER}, C_POINTER )
