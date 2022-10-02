
include iup.e

function action_cb( atom ih, atom posx, atom posy )
	printf( STDERR, "action_cb( ih=0x%08x, posx=%g, posy=%g )\n", {ih,posx,posy} )

	return IUP_DEFAULT
end function

function button_cb( atom ih, integer button, integer pressed, integer x, integer y, sequence status )
	printf( STDERR, "button_cb( ih=0x%08x, button=%d, pressed=%d, x=%d, y=%d, status=\"%s\" )\n", {ih,button,pressed,x,y,status} )

	return IUP_DEFAULT
end function

function dropfiles_cb( atom ih, sequence filename, integer num, integer x, integer y )
	printf( STDERR, "dropfiles_cb( ih=0x%08x, filename=\"%s\", num=%d, x=%d, y=%d )\n", {ih,filename,num,x,y} )

	return IUP_DEFAULT
end function

function focus_cb( atom ih, integer focus )
	printf( STDERR, "focus_cb( ih=0x%08x, focus=%d )\n", {ih,focus} )

	return IUP_DEFAULT
end function

function motion_cb( atom ih, integer x, integer y, sequence status )
	printf( STDERR, "motion_cb( ih=0x%08x, x=%d, y=%d, status=\"%s\" )\n", {ih,x,y,status} )

	return IUP_DEFAULT
end function

function keypress_cb( atom ih, integer c, integer press )
	printf( STDERR, "keypress_cb( ih=0x%08x, c=%d, press=%d )\n", {ih,c,press} )

	return IUP_DEFAULT
end function

function resize_cb( atom ih, integer width, integer height )
	printf( STDERR, "motion_cb( ih=0x%08x, width=%d, height=%d )\n", {ih,width,height} )

	return IUP_DEFAULT
end function

function scroll_cb( atom ih, integer op, atom posx, atom posy )
	printf( STDERR, "scroll_cb( atom ih=0x%08x, op=%d, posx=%g, posy=%g )\n", {ih,op,posx,posy} )

	return IUP_DEFAULT
end function

function touch_cb( atom ih, integer id, integer x, integer y, sequence state )
	printf( STDERR, "touch_cb( ih=0x%08x, id=%d, x=%d, y=%d, state=\"%s\" )\n", {ih,id,x,y,state} )

	return IUP_DEFAULT
end function

function multitouch_cb( atom ih, integer count, atom pid, atom px, atom py, atom pstate )
	printf( STDERR, "touch_cb( ih=0x%08x, count=%d, pid=0x%08x, px=0x%08x, py=0x%08x, pstate=0x%08x )\n", {ih,count,pid,px,py,pstate} )

	return IUP_DEFAULT
end function

function wheel_cb( atom ih, atom delta, integer x, integer y, sequence status )
	printf( STDERR, "wheel_cb( ih=0x%08x, delta=%g, x=%d, y=%d, status=\"%s\" )\n", {ih,delta,x,y,status} )

	return IUP_DEFAULT
end function

function map_cb( atom ih )
	printf( STDERR, "map_cb( ih=0x%08x )\n", {ih} )

	return IUP_DEFAULT
end function

function unmap_cb( atom ih )
	printf( STDERR, "unmap_cb( ih=0x%08x )\n", {ih} )

	return IUP_DEFAULT
end function

function destroy_cb( atom ih )
	printf( STDERR, "destroy_cb( ih=0x%08x )\n", {ih} )

	return IUP_DEFAULT
end function

function getfocus_cb( atom ih )
	printf( STDERR, "getfocus_cb( ih=0x%08x )\n", {ih} )

	return IUP_DEFAULT
end function

function killfocus_cb( atom ih )
	printf( STDERR, "killfocus_cb( ih=0x%08x )\n", {ih} )

	return IUP_DEFAULT
end function

function enterwindow_cb( atom ih )
	printf( STDERR, "enterwindow_cb( ih=0x%08x )\n", {ih} )

	return IUP_DEFAULT
end function

function leavewindow_cb( atom ih )
	printf( STDERR, "leavewindow_cb( ih=0x%08x )\n", {ih} )

	return IUP_DEFAULT
end function

function k_any( atom ih, integer c )
	printf( STDERR, "k_any( ih=0x%08x, c=%d )\n", {ih,c} )

	return IUP_DEFAULT
end function

function help_cb( atom ih )
	printf( STDERR, "help_cb( ih=0x%08x )\n", {ih} )

	return IUP_DEFAULT
end function

procedure main()

	IupOpen()

	atom canvas = IupCanvas( NULL )
	IupSetAttribute( canvas, "BORDER", "NO" )
	IupSetAttribute( canvas, "DROPFILESTARGET", "YES" )
	IupSetAttribute( canvas, "SCROLLBAR", "YES" )

	-- Canvas callbacks
	IupSetCallback( canvas, "ACTION", Icallback("action_cb",{C_POINTER,C_FLOAT,C_FLOAT}) )
	IupSetCallback( canvas, "BUTTON_CB", Icallback("button_cb",{C_POINTER,C_INT,C_INT,C_INT,C_INT,C_STRING}) )
	IupSetCallback( canvas, "DROPFILES_CB", Icallback("dropfiles_cb",{C_POINTER,C_STRING,C_INT,C_INT,C_INT}) )
	IupSetCallback( canvas, "FOCUS_CB", Icallback("focus_cb",{C_POINTER,C_INT}) )
	IupSetCallback( canvas, "MOTION_CB", Icallback("motion_cb",{C_POINTER,C_INT,C_INT,C_STRING}) )
	IupSetCallback( canvas, "KEYPRESS_CB", Icallback("keypress_cb",{C_POINTER,C_INT,C_INT}) )
	IupSetCallback( canvas, "RESIZE_CB", Icallback("resize_cb",{C_POINTER,C_INT,C_INT}) )
	IupSetCallback( canvas, "SCROLL_CB", Icallback("scroll_cb",{C_POINTER,C_INT,C_FLOAT,C_FLOAT}) )
	IupSetCallback( canvas, "TOUCH_CB", Icallback("touch_cb",{C_POINTER,C_INT,C_INT,C_INT,C_STRING}) )
	IupSetCallback( canvas, "MULTITOUCH_CB", Icallback("multitouch_cb",{C_POINTER,C_INT,C_POINTER,C_POINTER,C_POINTER,C_POINTER}) )
	IupSetCallback( canvas, "WHEEL_CB", Icallback("wheel_cb",{C_POINTER,C_FLOAT,C_INT,C_INT,C_STRING}) )

	-- Generic callbacks
	IupSetCallback( canvas, "MAP_CB", Icallback("map_cb",{C_POINTER}) )
	IupSetCallback( canvas, "UNMAP_CB", Icallback("unmap_cb",{C_POINTER}) )
	IupSetCallback( canvas, "DESTROY_CB", Icallback("destroy_cb",{C_POINTER}) )
	IupSetCallback( canvas, "GETFOCUS_CB", Icallback("getfocus_cb",{C_POINTER}) )
	IupSetCallback( canvas, "KILLFOCUS_CB", Icallback("killfocus_cb",{C_POINTER}) )
	IupSetCallback( canvas, "ENTERWINDOW_CB", Icallback("enterwindow_cb",{C_POINTER}) )
	IupSetCallback( canvas, "LEAVEWINDOW_CB", Icallback("leavewindow_cb",{C_POINTER}) )
	IupSetCallback( canvas, "K_ANY", Icallback("k_any",{C_POINTER,C_INT}) )
	IupSetCallback( canvas, "HELP_CB", Icallback("help_cb",{C_POINTER}) )

	atom dialog = IupDialog( canvas )
	IupSetAttribute( dialog, "RASTERSIZE", "720x480" )
	IupSetAttribute( dialog, "TITLE", "Canvas" )

	IupShow( dialog )
	IupMainLoop()

	IupClose()

end procedure

main()
