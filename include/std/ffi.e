--****
-- == Foreign Function Interface (FFI)
--
-- <<LEVELTOC level=2 depth=4>>
--
-- The //foreign function interface// library is a drop-in replacement for the
-- now-deprecated ##std/dll.e## library. While ##std/dll.e## used a hand-built
-- methods for setting up the required memory and stack pointers for linking to
-- external C functions, the new ##std/ffi.e## library is effectively a wrapper
-- around [[https://sourceware.org/libffi/|libffi]], which provides the same
-- programming interface as the original library while adding many new features.
--
-- || Feature             || std/dll.e || std/ffi.e || Status ||
-- | Define C variables          | YES     | YES     | //Done// |
-- | Define C functions          | YES     | YES     | //Done// |
-- | Define machine functions    | YES     | YES     | **TODO** |
-- | STDCALL convention          | YES     | YES     | //Done// |
-- | CDECL convention            | YES     | YES     | //Done// |
-- | FASTCALL convention         | //NO//  | **YES** | **TODO** |
-- | PASCAL convention           | //NO//  | **YES** | **TODO** |
-- | THISCALL convention         | //NO//  | **YES** | **TODO** |
-- | Pass Euphoria objects       | **YES** | //NO//  | **TODO** |
-- | Receive Euphoria objects    | **YES** | //NO//  | **TODO** |
-- | Pass structures by value    | //NO//  | **YES** | //Done// |
-- | Receive structures by value | //NO//  | **YES** | //Done// |
-- | Variable-length call-backs  | //NO//  | **YES** | **TODO** |
-- | Floating-point call-backs   | //NO//  | **YES** | **TODO** |
--

namespace ffi

without warning += { override }

constant
	M_ALLOC      =  16,
	M_FREE       =  17,
	M_A_TO_F64   =  46,
	M_F64_TO_A   =  47,
	M_A_TO_F32   =  48,
	M_F32_TO_A   =  49,
	M_OPEN_DLL   =  50,
	M_DEFINE_C   =  51,
	M_CALL_BACK  =  52,
	M_DEFINE_VAR =  56,
	M_CRASH      =  67,
	M_F80_TO_A   = 101,
	M_A_TO_F80   = 105

--from std/dll.e:
-- #01000004 C_INT
-- #02000004 C_UINT
-- #02000008 C_SIZE_T
-- #03000001 C_POINTER

ifdef WINDOWS then

	ifdef X86_64 then
		with define X86_WIN64
	elsifdef X86 then
		with define X86_WIN32
	end ifdef

	constant libffi_name = "libffi-8.dll",
		kernel32 = machine_func( M_OPEN_DLL, "kernel32.dll" ),
		xLoadLibrary = machine_func( M_DEFINE_C, {kernel32,"LoadLibraryA",{#03000001},#03000001} ),
		xGetProcAddress = machine_func( M_DEFINE_C, {kernel32,"GetProcAddress",{#03000001,#03000001},#03000001} )

elsedef

	constant RTLD_LAZY = 0x00001, RTLD_GLOBAL = 0x00100

	constant libffi_name = "libffi.so.8",
		libdl = machine_func( M_OPEN_DLL, "libdl.so.2" ),
		_dlopen = machine_func( M_DEFINE_C, {libdl,"dlopen",{#03000001,#01000004},#03000001} ),
		_dlsym = machine_func( M_DEFINE_C, {libdl,"dlsym",{#03000001,#03000001},#03000001} )

end ifdef

constant libffi = machine_func( M_OPEN_DLL, libffi_name )

if not libffi then
	machine_proc( M_CRASH, sprintf("%s not found!",{libffi_name}) )
end if

constant
	_ffi_closure_alloc = machine_func( M_DEFINE_C, {libffi,"+ffi_closure_alloc",
		{#02000008,#03000001},#03000001} ),
	_ffi_closure_free = machine_func( M_DEFINE_C, {libffi,"+ffi_closure_free",
		{#03000001},#00000000} ),
	_ffi_prep_closure_loc = machine_func( M_DEFINE_C, {libffi,"+ffi_prep_closure_loc",
		{#03000001,#03000001,#03000001,#03000001,#03000001},#01000004} ),
	_ffi_prep_cif = machine_func( M_DEFINE_C, {libffi,"+ffi_prep_cif",
		{#03000001,#01000004,#02000004,#03000001,#03000001},#01000004} ),
	_ffi_prep_cif_var = machine_func( M_DEFINE_C, {libffi,"+ffi_prep_cif_var",
		{#03000001,#01000004,#02000004,#02000004,#03000001,#03000001},#01000004} ),
	_ffi_call = machine_func( M_DEFINE_C, {libffi,"+ffi_call",
		{#03000001,#03000001,#03000001,#03000001},#00000000} ),
	_ffi_get_struct_offsets = machine_func( M_DEFINE_C, {libffi,"+ffi_get_struct_offsets",
		{#01000004,#03000001,#03000001},#01000004} )

constant
	ffi_type_void       = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_void"} ),
	ffi_type_uint8      = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_uint8"} ),
	ffi_type_sint8      = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_sint8"} ),
	ffi_type_uint16     = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_uint16"} ),
	ffi_type_sint16     = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_sint16"} ),
	ffi_type_uint32     = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_uint32"} ),
	ffi_type_sint32     = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_sint32"} ),
	ffi_type_uint64     = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_uint64"} ),
	ffi_type_sint64     = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_sint64"} ),
	ffi_type_float      = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_float"} ),
	ffi_type_double     = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_double"} ),
	ffi_type_pointer    = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_pointer"} ),
	ffi_type_longdouble = machine_func( M_DEFINE_VAR, {libffi,"ffi_type_longdouble"} )

ifdef WINDOWS or BITS32 then

	constant
		ffi_type_uchar  = ffi_type_uint8,
		ffi_type_schar  = ffi_type_sint8,
		ffi_type_ushort = ffi_type_uint16,
		ffi_type_sshort = ffi_type_sint16,
		ffi_type_uint   = ffi_type_uint32,
		ffi_type_sint   = ffi_type_sint32,
		ffi_type_ulong  = ffi_type_uint32,
		ffi_type_slong  = ffi_type_sint32

elsedef

	constant
		ffi_type_uchar  = ffi_type_uint8,
		ffi_type_schar  = ffi_type_sint8,
		ffi_type_ushort = ffi_type_uint16,
		ffi_type_sshort = ffi_type_sint16,
		ffi_type_uint   = ffi_type_uint32,
		ffi_type_sint   = ffi_type_sint32,
		ffi_type_ulong  = ffi_type_uint64,
		ffi_type_slong  = ffi_type_sint64

end ifdef

ifdef X86_WIN64 then

	--**
	-- @nodoc@
	public enum
		FFI_FIRST_ABI = 0,
		FFI_WIN64,      /* sizeof(long double) == 8  - microsoft compilers */
		FFI_GNUW64,     /* sizeof(long double) == 16 - GNU compilers */
		FFI_LAST_ABI,
		FFI_DEFAULT_ABI = FFI_GNUW64

elsifdef X86_64 then

	--**
	-- @nodoc@
	public enum
		FFI_FIRST_ABI = 1,
		FFI_UNIX64,
		FFI_WIN64,
		FFI_EFI64 = FFI_WIN64,
		FFI_GNUW64,
		FFI_LAST_ABI,
		FFI_DEFAULT_ABI = FFI_UNIX64

elsifdef X86_WIN32 then

	--**
	-- @nodoc@
	public enum
		FFI_FIRST_ABI = 0,
		FFI_SYSV      = 1,
		FFI_STDCALL   = 2,
		FFI_THISCALL  = 3,
		FFI_FASTCALL  = 4,
		FFI_MS_CDECL  = 5,
		FFI_PASCAL    = 6,
		FFI_REGISTER  = 7,
		FFI_LAST_ABI,
		FFI_DEFAULT_ABI = FFI_MS_CDECL

elsifdef X86 then

	--**
	-- @nodoc@
	public enum
		FFI_FIRST_ABI = 0,
		FFI_SYSV      = 1,
		FFI_THISCALL  = 3,
		FFI_FASTCALL  = 4,
		FFI_STDCALL   = 5,
		FFI_PASCAL    = 6,
		FFI_REGISTER  = 7,
		FFI_MS_CDECL  = 8,
		FFI_LAST_ABI,
		FFI_DEFAULT_ABI = FFI_SYSV

elsedef -- ARM? AARCH64?

	machine_proc( M_CRASH, "Platform not yet supported by std/ffi.e" )

end ifdef

ifdef X86_64 then

	--**
	-- @nodoc@
	public constant FFI_TRAMPOLINE_SIZE = 32

	constant
		ffi_type__size      =  0, -- size_t
		ffi_type__alignment =  8, -- unsigned short
		ffi_type__type      = 10, -- unsigned short
		ffi_type__elements  = 16, -- ffi_type**
		SIZEOF_FFI_TYPE     = 24

	constant
		ffi_cif__abi        =  0, -- ffi_abi
		ffi_cif__nargs      =  4, -- unsigned int
		ffi_cif__arg_types  =  8, -- ffi_type**
		ffi_cif__rtype      = 16, -- ffi_type*
		ffi_cif__bytes      = 24, -- unsigned int
		ffi_cif__flags      = 28, -- unsigned int
		SIZEOF_FFI_CIF      = 32

	constant
		ffi_closure__tramp     =  0, -- char[FFI_TRAMPOLINE_SIZE]
		ffi_closure__ftramp    =  0, -- void*
		ffi_closure__cif       = 32, -- ffi_cif*
		ffi_closure__fun       = 40, -- void(*fun)(ffi_cif*,void*,void**,void*)
		ffi_closure__user_data = 48, -- void*
		SIZEOF_FFI_CLOSURE     = 56

elsifdef X86 then

	--**
	-- @nodoc@
	public constant FFI_TRAMPOLINE_SIZE = 16

	constant
		ffi_type__size      =  0, -- size_t
		ffi_type__alignment =  4, -- unsigned short
		ffi_type__type      =  6, -- unsigned short
		ffi_type__elements  =  8, -- ffi_type**
		SIZEOF_FFI_TYPE     = 12

	constant
		ffi_cif__abi        =  0, -- ffi_abi
		ffi_cif__nargs      =  4, -- unsigned int
		ffi_cif__arg_types  =  8, -- ffi_type**
		ffi_cif__rtype      = 12, -- ffi_type*
		ffi_cif__bytes      = 16, -- unsigned int
		ffi_cif__flags      = 20, -- unsigned int
		SIZEOF_FFI_CIF      = 24

	constant
		ffi_closure__tramp     =  0, -- char[FFI_TRAMPOLINE_SIZE]
		ffi_closure__ftramp    =  0, -- void*
		ffi_closure__cif       = 16, -- ffi_cif*
		ffi_closure__fun       = 20, -- void(*fun)(ffi_cif*,void*,void**,void*)
		ffi_closure__user_data = 24, -- void*
		SIZEOF_FFI_CLOSURE     = 28

elsedef

	-- TBD

end ifdef

enum FFI_OK = 0,
	FFI_BAD_TYPEDEF,
	FFI_BAD_ABI,
	FFI_BAD_ARGTYPE

constant ffi_errors = {
	"FFI_BAD_TYPEDEF",
	"FFI_BAD_ABI",
	"FFI_BAD_ARGTYPE"
}

function allocate_string( sequence s )

	atom mem = machine_func( M_ALLOC, length(s) + 1 )

	if mem then
		poke( mem, s )
		poke( mem+length(s), 0 )
	end if

	return mem
end function

function allocate_wstring( sequence s )

	atom mem = machine_func( M_ALLOC, (length(s)+1) * 2 )

	if mem then
		poke2( mem, s )
		poke2( mem + length(s)*2, 0 )
	end if

	return mem
end function

function peek_wstring( atom addr )

	atom ptr = addr

	integer ch = 0
	sequence s = ""

	while ch with entry do
		s &= ch
		ptr += 2
	entry
		ch = peek2u( ptr )
	end while

	return s
end function

type string( object x )

	if not sequence( x ) then
		return 0
	end if

	for i = 1 to length( x ) do
		if not integer(x[i]) or x[i] < 0 or x[i] > 255 then
			return 0
		end if
	end for

	return 1
end type

sequence m_funcs = {
	0 -- skip -1, which indicates an error
}
sequence m_types = {
	ffi_type_void,
	ffi_type_uint8,
	ffi_type_sint8,
	ffi_type_uint16,
	ffi_type_sint16,
	ffi_type_uint32,
	ffi_type_sint32,
	ffi_type_uint64,
	ffi_type_sint64,
	ffi_type_float,
	ffi_type_double,
	ffi_type_pointer,
	ffi_type_longdouble
}

--****
-- === C Type Constants
-- These C type constants are used when defining external C functions in a shared
-- library file.
--
-- Example 1:
--   See [[:define_c_proc]]
--
-- See Also:
--   [[:define_c_proc]], [[:define_c_func]], [[:define_c_var]]

with define NO_CHANDLE --???

public constant
	--** char  8-bits
	C_CHAR       = ffi_type_schar,
	--** byte  8-bits
	C_BYTE       = ffi_type_sint,
	--** unsigned char 8-bits
	C_UCHAR      = ffi_type_uchar,
	--** ubyte 8-bits
	C_UBYTE      = ffi_type_uchar,
	--** short 16-bits
	C_SHORT      = ffi_type_sshort,
	--** word 16-bits
	C_WORD       = ffi_type_sshort,
	--** unsigned short 16-bits
	C_USHORT     = ffi_type_ushort,
	--** int 32-bits
	C_INT        = ffi_type_sint,
	--** bool 32-bits
	C_BOOL       = ffi_type_schar,
	--** unsigned int 32-bits
	C_UINT       = ffi_type_uint,
	--** long 32-bits except on 64-bit //Unix//, where it is 64-bits
	C_LONG       = ffi_type_slong,
	--** unsigned long 32-bits except on 64-bit //Unix//, where it is 64-bits
	C_ULONG      = ffi_type_ulong,
	--** size_t unsigned long 32-bits except on 64-bit //Unix//, where it is 64-bits
	C_SIZE_T     = ffi_type_ulong,
	--** any valid pointer
	C_POINTER    = ffi_type_pointer,
	--** longlong 64-bits
	C_LONGLONG   = ffi_type_sint64,
	--** unsigned longlong 64-bits
	C_ULONGLONG  = ffi_type_uint64

ifdef BITS32 then
	--** signed integer sizeof pointer
	public constant C_LONG_PTR = ffi_type_slong
elsedef
	--** signed integer sizeof pointer
	public constant C_LONG_PTR = ffi_type_sint64
end ifdef

public constant
	--** dword 32-bits
	C_DWORD      = ffi_type_uint,
	--** float 32-bits
	C_FLOAT      = ffi_type_float,
	--** double 64-bits
	C_DOUBLE     = ffi_type_double,
	--** dwordlong 64-bits
	C_DWORDLONG  = ffi_type_sint64,
	--** long double 80-bits
	C_LONGDOUBLE = ffi_type_longdouble

public constant
	--** void type (indicates functions whic do not return a value)
	C_VOID       = ffi_type_void,
	--** signed int 8-bits
	C_INT8       = ffi_type_sint8,
	--** signed int 16-bits
	C_INT16      = ffi_type_sint16,
	--** signed int 32-bits
	C_INT32      = ffi_type_sint32,
	--** signed int 64-bits
	C_INT64      = ffi_type_sint64,
	--** unsigned int 8-bits
	C_UINT8      = ffi_type_uint8,
	--** unsigned int 16-bits
	C_UINT16     = ffi_type_uint16,
	--** unsigned int 32-bits
	C_UINT32     = ffi_type_uint32,
	--** unsigned int 64-bits
	C_UINT64     = ffi_type_uint64

public constant
	--** C-style null-terminated char string
	C_STRING = define_c_type( C_POINTER ),
	--** C-style null-terminated wchar_t string
	C_WSTRING = define_c_type( C_POINTER )

--****
-- === C Type Identifiers
-- These values are returned by [[:typeof]] to identify the simple type of the
-- parameter type constants listed above or created using [[:define_c_type]].
--
-- See Also:
--   [[:define_c_type]], [[:typeof]]

public constant
	FFI_TYPE_VOID       =  0,
	FFI_TYPE_INT        =  1,
	FFI_TYPE_FLOAT      =  2,
	FFI_TYPE_DOUBLE     =  3,
	FFI_TYPE_LONGDOUBLE =  4,
	FFI_TYPE_UINT8      =  5,
	FFI_TYPE_SINT8      =  6,
	FFI_TYPE_UINT16     =  7,
	FFI_TYPE_SINT16     =  8,
	FFI_TYPE_UINT32     =  9,
	FFI_TYPE_SINT32     = 10,
	FFI_TYPE_UINT64     = 11,
	FFI_TYPE_SINT64     = 12,
	FFI_TYPE_STRUCT     = 13,
	FFI_TYPE_POINTER    = 14,
	FFI_TYPE_COMPLEX    = 15

--**
-- Get the size of the specified data type.
--
-- Parameters:
-- # ##ctype## A C data type constant
--
-- Returns:
--   The size of the specified data type in bytes.
--
override function sizeof( atom ctype )

	if not find( ctype, m_types ) then
		return eu:sizeof( ctype )
	end if

	ifdef BITS64 then
		return peek8u( ctype + ffi_type__size )
	elsedef
		return peek4u( ctype + ffi_type__size )
	end ifdef

end function

--**
-- Get the type ID of the specified data type.
--
-- Parameters:
-- # ##ctype## A C data type constant
--
-- Returns:
--   The type ID of the specified data type.
--
public function typeof( atom ctype )
	return peek2u( ctype + ffi_type__type )
end function

constant SIZEOF_POINTER = sizeof( C_POINTER )


--****
-- === Constants

--**
-- C's NULL pointer
--
public constant NULL = 0

--****
-- === Routines

--**
-- Read a value of the specified type from memory.
--
public function peek_type( atom ptr, atom ctype )

	integer type_id = typeof( ctype )

	switch type_id with fallthru do
		case FFI_TYPE_FLOAT then -- 2
			return machine_func( M_F32_TO_A, peek({ptr,4}) )
		case FFI_TYPE_DOUBLE then -- 3
			return machine_func( M_F64_TO_A, peek({ptr,8}) )
		case FFI_TYPE_LONGDOUBLE then -- 4
			return machine_func( M_F80_TO_A, peek({ptr,10}) )
		case FFI_TYPE_UINT8 then -- 5
			return peek( ptr )
		case FFI_TYPE_SINT8 then -- 6
			return peek( ptr )
		case FFI_TYPE_UINT16 then -- 7
			return peek2u( ptr )
		case FFI_TYPE_SINT16 then -- 8
			return peek2s( ptr )
		case FFI_TYPE_UINT32 then -- 9
			return peek4u( ptr )
		case FFI_TYPE_INT then -- 1 (deprecated?)
		case FFI_TYPE_SINT32 then -- 10
			return peek4s( ptr )
		case FFI_TYPE_UINT64 then -- 11
			return peek8u( ptr )
		case FFI_TYPE_SINT64 then -- 12
			return peek8s( ptr )
		case FFI_TYPE_STRUCT then -- 13
			return peek_struct( ptr, ctype )
		case FFI_TYPE_VOID then -- 0 (undefined?)
		case FFI_TYPE_POINTER then -- 14
			return peek_pointer( ptr )
	end switch

	machine_proc( M_CRASH, sprintf("Unknown type ID %d",type_id) )

end function

--**
-- Write a value of the specified type into memory.
--
public procedure poke_type( atom ptr, atom ctype, object value )

	integer type_id = typeof( ctype )

	switch type_id with fallthru do
		case FFI_TYPE_FLOAT then -- 2
			poke( ptr, machine_func(M_A_TO_F32,value) )
			return
		case FFI_TYPE_DOUBLE then -- 3
			poke( ptr, machine_func(M_A_TO_F64,value) )
			return
		case FFI_TYPE_LONGDOUBLE then -- 4
			poke( ptr, machine_func(M_A_TO_F80,value) )
			return
		case FFI_TYPE_UINT8 then -- 5
		case FFI_TYPE_SINT8 then -- 6
			poke( ptr, value )
			return
		case FFI_TYPE_UINT16 then -- 7
		case FFI_TYPE_SINT16 then -- 8
			poke2( ptr, value )
			return
		case FFI_TYPE_INT then -- 1 (deprecated?)
		case FFI_TYPE_UINT32 then -- 9
		case FFI_TYPE_SINT32 then -- 10
			poke4( ptr, value )
			return
		case FFI_TYPE_UINT64 then -- 11
		case FFI_TYPE_SINT64 then -- 12
			poke8( ptr, value )
			return
		case FFI_TYPE_STRUCT then -- 13
			poke_struct( ptr, ctype, value )
			return
		case FFI_TYPE_VOID then -- 0 (undefined?)
		case FFI_TYPE_POINTER then -- 14
			poke_pointer( ptr, value )
			return
	end switch

	machine_proc( M_CRASH, sprintf("Unknown type ID %d",type_id) )

end procedure

--**
-- Get a sequence of the types comprising a structure.
--
public function get_struct_elements( atom ctype )

	atom elements = peek_pointer( ctype + ffi_type__elements )

	if elements = NULL then
		return {}
	end if

	atom element = NULL
	sequence result = {}

	while element with entry do
		result = append( result, element )
		elements += SIZEOF_POINTER

	entry
		element = peek_pointer( elements )

	end while

	return result
end function

--**
-- Get a sequence of the element offsets (in bytes) of a structure.
--
public function get_struct_offsets( atom ctype, integer count, integer abi=FFI_DEFAULT_ABI )

	atom buffer = machine_func( M_ALLOC, SIZEOF_POINTER*count )

	eu:c_func( _ffi_get_struct_offsets, {abi,ctype,buffer} )

	sequence result = peek_pointer({ buffer, count })

	machine_proc( M_FREE, buffer )

	return result
end function

--**
-- Read the values of a structure from memory.
--
public function peek_struct( atom ptr, object ctype )

	integer element = 0

	if sequence( ctype ) then
		element = ctype[2]
		ctype = ctype[1]
	end if

	sequence elements = get_struct_elements( ctype )
	sequence offsets = get_struct_offsets( ctype, length(elements) )

	object result

	if element then
		result = peek_type( ptr+offsets[element], elements[element] )

	else
		result = repeat( NULL, length(elements) )

		for i = 1 to length( elements ) do
			result[i] = peek_type( ptr+offsets[i], elements[i] )
		end for

	end if

	return result
end function

--**
-- Write the values of a structure into memory.
--
public procedure poke_struct( atom ptr, object ctype, object values )

	integer element = 0

	if sequence( ctype ) then
		element = ctype[2]
		ctype = ctype[1]
	end if

	sequence elements = get_struct_elements( ctype )
	sequence offsets = get_struct_offsets( ctype, length(elements) )

	if element then
		poke_type( ptr+offsets[element], elements[element], values )

	else

		if length( values ) < length( elements ) then
			values &= repeat( NULL, length(elements)-length(values) )
		end if

		for i = 1 to length( elements ) do
			poke_type( ptr+offsets[i], elements[i], values[i] )
		end for

	end if

end procedure

--**
-- Allocate space for a structure and, optionally, fill it with values.
--
public function allocate_struct( atom ctype, sequence values={} )

	atom ptr = machine_func( M_ALLOC, sizeof(ctype) )

	if ptr and length( values ) then
		poke_struct( ptr, ctype, values )
	end if

	return ptr
end function

--**
-- Open a shared library and return its handle.
--
public function open_dll( sequence name )

	atom lib = NULL

	if length( name ) and string( name ) then
		name = {name}
	end if

	for i = 1 to length( name ) do

		atom pname = allocate_string( name[i] )

		ifdef WINDOWS then
			lib = eu:c_func( xLoadLibrary, {pname} )
		elsedef
			lib = eu:c_func( _dlopen, {pname,or_bits(RTLD_LAZY,RTLD_GLOBAL)} )
		end ifdef

		machine_proc( M_FREE, pname )

		if lib then
			exit
		end if

	end for

	return lib
end function

--**
-- Get the address of a symbol in a shared library.
--
public function define_c_var( atom lib, sequence name )

	atom addr = NULL
	atom pname = allocate_string( name )

	ifdef WINDOWS then
		addr = eu:c_func( xGetProcAddress, {lib,pname} )
	elsedef
		addr = eu:c_func( _dlsym, {lib,pname} )
	end ifdef

	machine_proc( M_FREE, pname )

	return addr
end function

--**
-- Create a new C type definition (typically a structure made up of several types).
--
public function define_c_type( object elements, integer abi=FFI_DEFAULT_ABI )

	atom ctype = machine_func( M_ALLOC, SIZEOF_FFI_TYPE )

	if atom( elements ) then

		mem_copy( ctype, elements, SIZEOF_FFI_TYPE )

	else

		for i = 1 to length( elements ) do
			if sequence( elements[i] ) then
				elements[i] = define_c_type( repeat(elements[i][1],elements[i][2]), abi )
			end if
		end for

		atom nelements = length( elements )
		atom pelements = machine_func( M_ALLOC, SIZEOF_POINTER*(nelements+1) )
		poke_pointer( pelements, elements )
		poke_pointer( pelements+(SIZEOF_POINTER*nelements), 0 )

		poke_pointer( ctype + ffi_type__size, 0 )
		       poke2( ctype + ffi_type__alignment, 0 )
		       poke2( ctype + ffi_type__type, FFI_TYPE_STRUCT )
		poke_pointer( ctype + ffi_type__elements, pelements )

	end if

	if typeof( ctype ) = FFI_TYPE_STRUCT then

		atom status = eu:c_func( _ffi_get_struct_offsets, {abi,ctype,NULL} )

		if status != FFI_OK then
			machine_proc( M_CRASH, sprintf("ffi_get_struct_offsets() returned %s (%d)",{ffi_errors[status],status}) )
		end if

	end if

	m_types = append( m_types, ctype )

	return ctype
end function

--**
-- Define the arguments and return types of a C function.
--
public function define_c_func( atom lib, sequence name, sequence arg_types, atom rtype )

ifdef WINDOWS and BITS32 then
	integer abi = FFI_STDCALL
elsedef
	integer abi = FFI_DEFAULT_ABI
end ifdef

	if name[1] = '+' then

		ifdef WINDOWS and BITS32 then
			abi = FFI_MS_CDECL
		end ifdef

		name = name[2..$]

	end if

	atom fn = NULL
	atom pname = allocate_string( name )

	ifdef WINDOWS then
		fn = eu:c_func( xGetProcAddress, {lib,pname} )
	elsedef
		fn = eu:c_func( _dlsym, {lib,pname} )
	end ifdef

	machine_proc( M_FREE, pname )

	if fn = NULL then
		return -1
	end if

	atom parg_types = NULL
	atom nargs = length( arg_types )

	if nargs then
		parg_types = machine_func( M_ALLOC, SIZEOF_POINTER*nargs )
		poke_pointer( parg_types, arg_types )
	end if

	atom cif = machine_func( M_ALLOC, SIZEOF_FFI_CIF )
	atom status = eu:c_func( _ffi_prep_cif, {cif,abi,nargs,rtype,parg_types} )

	if status != FFI_OK then
		machine_proc( M_CRASH, sprintf("ffi_prep_cif() returned %s (%d)\n",{ffi_errors[status],status}) )
	end if

	m_funcs = append( m_funcs, {fn,cif,name} )

	-- N.B. we return a negative integer to differentiate between routines defined
	-- with dll:define_c_func/proc (positive) and ffi:define_c_func/proc (negative)

	return length( m_funcs ) * -1
end function

--**
-- Define the arguments of a C procedure.
--
public function define_c_proc( atom lib, sequence name, sequence arg_types )
	return define_c_func( lib, name, arg_types, C_VOID )
end function

--**
-- Call a C function and return the value.
--
override function c_func( integer rid, sequence args )

	if rid > 0 then
		return eu:c_func( rid, args )
	end if

	rid = rid * -1

	atom fn       = m_funcs[rid][1]
	atom cif      = m_funcs[rid][2]
	sequence name = m_funcs[rid][3]

	atom nargs = peek4u( cif + ffi_cif__nargs )
	atom parg_types = peek_pointer( cif + ffi_cif__arg_types )
	atom rtype = peek_pointer( cif + ffi_cif__rtype )

	if length( args ) != nargs then
		machine_proc( M_CRASH, sprintf("C function '%s' expects %d args, not %d",{name,nargs,length(args)}) )
	end if

	atom pargs = NULL
	sequence pfree = {}

	if nargs then

		sequence arg_types = peek_pointer({ parg_types, nargs })

		pargs = machine_func( M_ALLOC, SIZEOF_POINTER*nargs )
		pfree &= pargs

		for i = 1 to nargs do

			if sequence(args[i]) and arg_types[i] = C_STRING then
				args[i] = allocate_string( args[i] )
			elsif sequence(args[i]) and arg_types[i] = C_WSTRING then
				args[i] = allocate_wstring( args[i] )
			end if

			atom parg = machine_func( M_ALLOC, sizeof(arg_types[i]) )
			poke_type( parg, arg_types[i], args[i] )

			poke_pointer( pargs+SIZEOF_POINTER*(i-1), parg )
			pfree &= parg

		end for


	end if

	atom rtype_size = sizeof( rtype )

	if rtype_size < SIZEOF_POINTER then
		-- return value should always
		-- be at least size of pointer
		rtype_size = SIZEOF_POINTER
	end if

	atom prvalue = machine_func( M_ALLOC, rtype_size )
	pfree &= prvalue

	eu:c_proc( _ffi_call, {cif,fn,prvalue,pargs} )

	object rvalue = NULL

	if rtype != C_VOID then

		rvalue = peek_type( prvalue, rtype )

		if rtype = C_STRING and rvalue != NULL then
			rvalue = peek_string( rvalue )
		elsif rtype = C_WSTRING and rvalue != NULL then
			rvalue = peek_wstring( rvalue )
		end if

	end if

	for i = 1 to length( pfree ) do
		machine_proc( M_FREE, pfree[i] )
	end for

	return rvalue
end function

--**
-- Call a C procedure.
--
override procedure c_proc( integer rid, sequence args )

	if rid > 0 then
		eu:c_proc( rid, args )
		return
	end if

	object void = c_func( rid, args )

end procedure

function closure_func( atom cif, atom prvalue, atom pargs, atom id )

	atom nargs = peek4u( cif + ffi_cif__nargs )
	atom parg_types = peek_pointer( cif + ffi_cif__arg_types )
	atom rtype = peek_pointer( cif + ffi_cif__rtype )

	sequence args = repeat( NULL, nargs )
	sequence arg_types = peek_pointer({ parg_types, nargs })

	for i = 1 to nargs do

		atom parg = peek_pointer( pargs+SIZEOF_POINTER*(i-1) )
		args[i] = peek_type( parg, arg_types[i] )

		if arg_types[i] = C_STRING then
			args[i] = peek_string( args[i] )
		elsif arg_types[i] = C_WSTRING then
			args[i] = peek_wstring( args[i] )
		end if

	end for

	object rvalue = call_func( id, args )

	if rtype != C_VOID then
		poke_type( prvalue, rtype, rvalue )
	end if

	return NULL
end function
constant CLOSURE_FUNC = machine_func( M_CALL_BACK, routine_id("closure_func") )

--**
-- Return the memory address for a Euphoria routine.
--
public function call_back( object id, object arg_types=C_VOID, atom rtype=C_INT )

	if equal( arg_types, C_VOID ) then
		return machine_func( M_CALL_BACK, id )
	end if

ifdef WINDOWS and BITS32 then
	integer abi = FFI_STDCALL
elsedef
	integer abi = FFI_DEFAULT_ABI
end ifdef

	if sequence( id ) and id[1] = '+' then

		ifdef WINDOWS and BITS32 then
			abi = FFI_MS_CDECL
		end ifdef

		id = id[2]

	end if

	atom parg_types = NULL
	atom nargs = length( arg_types )

	if nargs then
		parg_types = machine_func( M_ALLOC, SIZEOF_POINTER*nargs )
		poke_pointer( parg_types, arg_types )
	end if

	atom cif = machine_func( M_ALLOC, SIZEOF_FFI_CIF )
	atom cif_status = eu:c_func( _ffi_prep_cif, {cif,abi,nargs,rtype,parg_types} )

	if cif_status != FFI_OK then
		machine_proc( M_CRASH, sprintf("ffi_prep_cif() returned %s (%d)\n",{ffi_errors[cif_status],cif_status}) )
	end if

	atom pmemory = machine_func( M_ALLOC, SIZEOF_POINTER )
	atom closure = eu:c_func( _ffi_closure_alloc, {SIZEOF_FFI_CLOSURE,pmemory} )

	atom codeloc = peek_pointer( pmemory )
	atom loc_status = eu:c_func( _ffi_prep_closure_loc, {closure,cif,CLOSURE_FUNC,id,codeloc} )

	machine_proc( M_FREE, pmemory )

	if loc_status != FFI_OK then
		machine_proc( M_CRASH, sprintf("ffi_prep_closure_loc() returned %s (%d)\n",{ffi_errors[loc_status],loc_status}) )
	end if

	return codeloc
end function

