
include iup.e

constant EXTFILTER = "Text Documents (*.txt)|*.txt|All Files (*.*)|*.*"

function new_cb( atom ih )

	atom editor = IupGetHandle( "EDITOR" )
	IupSetAttribute( editor, "FILENAME", "" )
	IupSetAttribute( editor, "VALUE", "" )

	return IUP_DEFAULT
end function

function open_cb( atom ih )

	atom editor = IupGetHandle( "EDITOR" )

	atom filedlg = IupFileDlg()
	IupSetAttribute( filedlg, "DIALOGTYPE", "OPEN" )
	IupSetAttribute( filedlg, "EXTFILTER", EXTFILTER )
	IupSetAttribute( filedlg, "TITLE", "Open" )

	IupPopup( filedlg, IUP_CENTER, IUP_CENTER )

	if IupGetInt( filedlg, "STATUS" ) != -1 then

		sequence filename = IupGetAttribute( filedlg, "VALUE" )
		object str = read_file( filename )

		if sequence( str ) then
			IupSetAttribute( editor, "FILENAME", filename )
			IupSetAttribute( editor, "VALUE", str )
		end if

	end if

	IupDestroy( filedlg )
	IupSetFocus( editor )

	return IUP_DEFAULT
end function

function save_cb( atom ih )

	atom editor = IupGetHandle( "EDITOR" )
	sequence filename = IupGetAttribute( editor, "FILENAME" )

	if length( filename ) = 0 then
		return saveas_cb( ih )
	end if

	sequence str = IupGetAttribute( editor, "VALUE" )
	write_file( filename, str )

	return IUP_DEFAULT
end function

function saveas_cb( atom ih )

	atom editor = IupGetHandle( "EDITOR" )

	atom filedlg = IupFileDlg()
	IupSetAttribute( filedlg, "DIALOGTYPE", "SAVE" )
	IupSetAttribute( filedlg, "EXTFILTER", EXTFILTER )
	IupSetAttribute( filedlg, "TITLE", "Save" )

	IupPopup( filedlg, IUP_CENTER, IUP_CENTER )

	if IupGetInt( filedlg, "STATUS" ) != -1 then

		sequence filename = IupGetAttribute( filedlg, "VALUE" )
		IupSetAttribute( editor, "FILENAME", filename )

		sequence str = IupGetAttribute( editor, "VALUE" )
		write_file( filename, str )

	end if

	IupDestroy( filedlg )
	IupSetFocus( editor )

	return IUP_DEFAULT
end function

function exit_cb( atom ih )

	return IUP_CLOSE
end function

function k_any( atom ih, integer c )

	if iup_XkeyBase(c) = K_S and iup_isCtrlXkey(c) and iup_isShiftXkey(c) then
		return saveas_cb( ih )
	end if

	return IUP_CONTINUE
end function

procedure main()

	IupOpen()

	atom item_new = IupItem( "&New\tCtrl+N", NULL )
	IupSetCallback( item_new, "ACTION", Icallback("new_cb",{C_POINTER}) )

	atom item_open = IupItem( "&Open...\tCtrl+O", NULL )
	IupSetCallback( item_open, "ACTION", Icallback("open_cb",{C_POINTER}) )

	atom item_save = IupItem( "&Save\tCtrl+S", NULL )
	IupSetCallback( item_save, "ACTION", Icallback("save_cb",{C_POINTER}) )

	atom item_saveas = IupItem( "Save &As...\tCtrl+Shift+S", NULL )
	IupSetCallback( item_saveas, "ACTION", Icallback("saveas_cb",{C_POINTER}) )

	atom item_exit = IupItem( "E&xit", NULL )
	IupSetCallback( item_exit, "ACTION", Icallback("exit_cb",{C_POINTER}) )

	atom file_menu = IupMenu({
		item_new,
		item_open,
		item_save,
		item_saveas,
		IupSeparator(),
		item_exit
	})

	atom main_menu = IupMenu({
		IupSubmenu( "&File", file_menu )
	})

	atom editor = IupMultiLine( NULL )
	IupSetAttribute( editor, "BORDER", "NO" )
	IupSetAttribute( editor, "EXPAND", "YES" )
	IupSetAttribute( editor, "FONTFACE", "Consolas" )
	IupSetAttribute( editor, "FONTSIZE", "10" )
	IupSetHandle( "EDITOR", editor )

	atom dialog = IupDialog( editor )
	IupSetAttributeHandle( dialog, "MENU", main_menu )
	IupSetAttribute( dialog, "RASTERSIZE", "720x480" )
	IupSetAttribute( dialog, "TITLE", "Editor" )
	IupSetCallback( dialog, "K_ANY", Icallback("k_any",{C_POINTER,C_INT}) )
	IupSetHandle( "DIALOG", dialog )

	IupSetCallback( dialog, "K_cN", Icallback("new_cb",{C_POINTER}) )
	IupSetCallback( dialog, "K_cO", Icallback("open_cb",{C_POINTER}) )
	IupSetCallback( dialog, "K_cS", Icallback("save_cb",{C_POINTER}) )

	IupShow( dialog )
	IupMainLoop()

	IupClose()

end procedure

main()
