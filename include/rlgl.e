/**********************************************************************************************
*
*   rlgl v4.0 - A multi-OpenGL abstraction layer with an immediate-mode style API
*
*   NOTICE: This is an incomplete Raylib wrapper for demonstrating libffi in Euphoria.
*
**********************************************************************************************/

include std/ffi.e
include raylib.e

export constant
	_rlPushMatrix = define_c_proc( raylib, "+rlPushMatrix", {} ),
	_rlPopMatrix  = define_c_proc( raylib, "+rlPopMatrix", {} ),
	_rlTranslatef = define_c_proc( raylib, "+rlTranslatef", {C_FLOAT,C_FLOAT,C_FLOAT} ),
	_rlRotatef    = define_c_proc( raylib, "+rlRotatef", {C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT} ),
$

public procedure rlPushMatrix()
	c_proc( _rlPushMatrix, {} )
end procedure

public procedure rlPopMatrix()
	c_proc( _rlPopMatrix, {} )
end procedure

public procedure rlTranslatef( atom x, atom y, atom z )
	c_proc( _rlTranslatef, {x,y,z} )
end procedure

public procedure rlRotatef( atom angle, atom x, atom y, atom z )
	c_proc( _rlRotatef, {angle,x,y,z} )
end procedure

