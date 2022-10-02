/** \file
 * \brief Callbacks, Attributes and Attribute Values definitions.
 * Avoid using these definitions. Use the strings instead.
 *
 * See Copyright Notice in iup.h
 */

--#ifndef __IUPDEF_H
--#define __IUPDEF_H

/* ATTENTION: these are OLD definitions and they are NOT updated anymore since IUP 3.0 */
/* Avoid using them, directly use the strings instead. */
/* Define __IUPDEF_H to avoid the inclusion of this header */

public constant IUP_RUN = "RUN"
public constant IUP_ENGLISH = "ENGLISH"
public constant IUP_PORTUGUESE = "PORTUGUESE"
public constant IUP_SBH = "SBH"
public constant IUP_SBV = "SBV"

/************************************************************************/
/*                            Callbacks                                 */
/************************************************************************/

public constant IUP_IDLE_ACTION = "IDLE_ACTION"

public constant IUP_ACTION = "ACTION"
public constant IUP_GETFOCUS_CB = "GETFOCUS_CB"
public constant IUP_KILLFOCUS_CB = "KILLFOCUS_CB"
public constant IUP_K_ANY = "K_ANY"
public constant IUP_KEYPRESS_CB = "KEYPRESS_CB"
public constant IUP_HELP_CB = "HELP_CB"

public constant IUP_SCROLL_CB = "SCROLL_CB"
public constant IUP_RESIZE_CB = "RESIZE_CB"
public constant IUP_MOTION_CB = "MOTION_CB"
public constant IUP_BUTTON_CB = "BUTTON_CB"
public constant IUP_ENTERWINDOW_CB = "ENTERWINDOW_CB"
public constant IUP_LEAVEWINDOW_CB = "LEAVEWINDOW_CB"
public constant IUP_WHEEL_CB = "WHEEL_CB"

public constant IUP_MASK_CB = "MASK_CB"
public constant IUP_OPEN_CB = "OPEN_CB"
public constant IUP_HIGHLIGHT_CB = "HIGHLIGHT_CB"
public constant IUP_MENUCLOSE_CB = "MENUCLOSE_CB"

public constant IUP_MAP_CB = "MAP_CB"
public constant IUP_CLOSE_CB = "CLOSE_CB"
public constant IUP_SHOW_CB = "SHOW_CB"

public constant IUP_DROPFILES_CB = "DROPFILES_CB"
public constant IUP_WOM_CB = "WOM_CB"

/************************************************************************/
/*                            Attributes                                */
/************************************************************************/

public constant IUP_DIRECTION = "DIRECTION"
public constant IUP_ACTIVE = "ACTIVE"
public constant IUP_BGCOLOR = "BGCOLOR"
public constant IUP_FRAMECOLOR = "FRAMECOLOR"
public constant IUP_FGCOLOR = "FGCOLOR"
public constant IUP_COLOR = "COLOR"
public constant IUP_WID = "WID"
public constant IUP_SIZE = "SIZE"
public constant IUP_RASTERSIZE = "RASTERSIZE"
public constant IUP_TITLE = "TITLE"
public constant IUP_VALUE = "VALUE"
public constant IUP_VISIBLE = "VISIBLE"
public constant IUP_FONT = "FONT"
public constant IUP_TIP = "TIP"
public constant IUP_EXPAND = "EXPAND"
public constant IUP_SEPARATOR = "SEPARATOR"

public constant IUP_HOTSPOT = "HOTSPOT"
public constant IUP_HEIGHT = "HEIGHT"
public constant IUP_WIDTH = "WIDTH"

public constant IUP_KEY = "KEY"

public constant IUP_MULTIPLE = "MULTIPLE"
public constant IUP_DROPDOWN = "DROPDOWN"
public constant IUP_VISIBLE_ITEMS = "VISIBLE_ITEMS"

public constant IUP_MARGIN = "MARGIN"
public constant IUP_GAP = "GAP"
public constant IUP_ALIGNMENT = "ALIGNMENT"

public constant IUP_IMAGE = "IMAGE"
public constant IUP_IMINACTIVE = "IMINACTIVE"
public constant IUP_IMPRESS = "IMPRESS"
public constant IUP_WIN_SAVEBITS = "WIN_SAVEBITS"

public constant IUP_NC = "NC"
public constant IUP_MASK = "MASK"

public constant IUP_APPEND = "APPEND"
public constant IUP_BORDER = "BORDER"

public constant IUP_CARET = "CARET"
public constant IUP_SELECTION = "SELECTION"
public constant IUP_SELECTEDTEXT = "SELECTEDTEXT"
public constant IUP_INSERT = "INSERT"

public constant IUP_CONID = "CONID"
public constant IUP_CURSOR = "CURSOR"

public constant IUP_ICON = "ICON"
public constant IUP_MENUBOX = "MENUBOX"
public constant IUP_MINBOX = "MINBOX"
public constant IUP_MAXBOX = "MAXBOX"
public constant IUP_RESIZE = "RESIZE"
public constant IUP_MENU = "MENU"
public constant IUP_STARTFOCUS = "STARTFOCUS"
public constant IUP_PARENTDIALOG = "PARENTDIALOG"
public constant IUP_SHRINK = "SHRINK"
public constant IUP_DEFAULTENTER = "DEFAULTENTER"
public constant IUP_DEFAULTESC = "DEFAULTESC"
public constant IUP_X = "X"
public constant IUP_Y = "Y"
public constant IUP_TOOLBOX = "TOOLBOX"
public constant IUP_CONTROL = "CONTROL"
public constant IUP_READONLY = "READONLY"

public constant IUP_SCROLLBAR = "SCROLLBAR"
public constant IUP_POSY = "POSY"
public constant IUP_POSX = "POSX"
public constant IUP_DX = "DX"
public constant IUP_DY = "DY"
public constant IUP_XMAX = "XMAX"
public constant IUP_XMIN = "XMIN"
public constant IUP_YMAX = "YMAX"
public constant IUP_YMIN = "YMIN"

public constant IUP_RED = "255 0 0"
public constant IUP_GREEN = "0 255 0"
public constant IUP_BLUE = "0 0 255"

public constant IUP_MIN = "MIN"
public constant IUP_MAX = "MAX"

public constant IUP_TIME = "TIME"
public constant IUP_DRAG = "DRAG"
public constant IUP_DROP = "DROP"
public constant IUP_REPAINT = "REPAINT"
public constant IUP_TOPMOST = "TOPMOST"
public constant IUP_CLIPCHILDREN = "CLIPCHILDREN"

public constant IUP_DIALOGTYPE = "DIALOGTYPE"
public constant IUP_FILE = "FILE"
public constant IUP_MULTIPLEFILES = "MULTIPLEFILES"
public constant IUP_FILTER = "FILTER"
public constant IUP_FILTERUSED = "FILTERUSED"
public constant IUP_FILTERINFO = "FILTERINFO"
public constant IUP_EXTFILTER = "EXTFILTER"
public constant IUP_DIRECTORY = "DIRECTORY"
public constant IUP_ALLOWNEW = "ALLOWNEW"
public constant IUP_NOOVERWRITEPROMPT = "NOOVERWRITEPROMPT"
public constant IUP_NOCHANGEDIR = "NOCHANGEDIR"
public constant IUP_FILEEXIST = "FILEEXIST"
public constant IUP_STATUS = "STATUS"

public constant IUP_LOCKLOOP = "LOCKLOOP"
public constant IUP_SYSTEM = "SYSTEM"
public constant IUP_DRIVER = "DRIVER"
public constant IUP_SCREENSIZE = "SCREENSIZE"
public constant IUP_SYSTEMLANGUAGE = "SYSTEMLANGUAGE"
public constant IUP_COMPUTERNAME = "COMPUTERNAME"
public constant IUP_USERNAME = "USERNAME"

public constant IUP_OPEN = "OPEN"
public constant IUP_SAVE = "SAVE"
public constant IUP_DIR = "DIR"

public constant IUP_HORIZONTAL = "HORIZONTAL"
public constant IUP_VERTICAL = "VERTICAL"

/************************************************************************/
/*                       Attribute Values                               */
/************************************************************************/

public constant IUP_YES = "YES"
public constant IUP_NO = "NO"
public constant IUP_ON = "ON"
public constant IUP_OFF = "OFF"

public constant IUP_ACENTER = "ACENTER"
public constant IUP_ALEFT = "ALEFT"
public constant IUP_ARIGHT = "ARIGHT"
public constant IUP_ATOP = "ATOP"
public constant IUP_ABOTTOM = "ABOTTOM"

public constant IUP_NORTH = "NORTH"
public constant IUP_SOUTH = "SOUTH"
public constant IUP_WEST = "WEST"
public constant IUP_EAST = "EAST"
public constant IUP_NE = "NE"
public constant IUP_SE = "SE"
public constant IUP_NW = "NW"
public constant IUP_SW = "SW"

public constant IUP_FULLSCREEN = "FULLSCREEN"
public constant IUP_FULL = "FULL"
public constant IUP_HALF = "HALF"
public constant IUP_THIRD = "THIRD"
public constant IUP_QUARTER = "QUARTER"
public constant IUP_EIGHTH = "EIGHTH"

public constant IUP_ARROW = "ARROW"
public constant IUP_BUSY = "BUSY"
public constant IUP_RESIZE_N = "RESIZE_N"
public constant IUP_RESIZE_S = "RESIZE_S"
public constant IUP_RESIZE_E = "RESIZE_E"
public constant IUP_RESIZE_W = "RESIZE_W"
public constant IUP_RESIZE_NE = "RESIZE_NE"
public constant IUP_RESIZE_NW = "RESIZE_NW"
public constant IUP_RESIZE_SE = "RESIZE_SE"
public constant IUP_RESIZE_SW = "RESIZE_SW"
public constant IUP_MOVE = "MOVE"
public constant IUP_HAND = "HAND"
public constant IUP_NONE = "NONE"
public constant IUP_IUP = "IUP"
public constant IUP_CROSS = "CROSS"
public constant IUP_PEN = "PEN"
public constant IUP_TEXT = "TEXT"
public constant IUP_RESIZE_C = "RESIZE_C"
public constant IUP_OPENHAND = "OPENHAND"

/************************************************************************/
/*                           Keys                                       */
/************************************************************************/

public constant IUP_K_exclam = "K_exclam"
public constant IUP_K_quotedbl = "K_quotedbl"
public constant IUP_K_numbersign = "K_numbersign"
public constant IUP_K_dollar = "K_dollar"
public constant IUP_K_percent = "K_percent"
public constant IUP_K_ampersand = "K_ampersand"
public constant IUP_K_quoteright = "K_quoteright"
public constant IUP_K_parentleft = "K_parentleft"
public constant IUP_K_parentright = "K_parentright"
public constant IUP_K_asterisk = "K_asterisk"
public constant IUP_K_plus = "K_plus"
public constant IUP_K_comma = "K_comma"
public constant IUP_K_minus = "K_minus"
public constant IUP_K_period = "K_period"
public constant IUP_K_slash = "K_slash"
public constant IUP_K_0 = "K_0"
public constant IUP_K_1 = "K_1"
public constant IUP_K_2 = "K_2"
public constant IUP_K_3 = "K_3"
public constant IUP_K_4 = "K_4"
public constant IUP_K_5 = "K_5"
public constant IUP_K_6 = "K_6"
public constant IUP_K_7 = "K_7"
public constant IUP_K_8 = "K_8"
public constant IUP_K_9 = "K_9"
public constant IUP_K_colon = "K_colon"
public constant IUP_K_semicolon = "K_semicolon "
public constant IUP_K_less = "K_less"
public constant IUP_K_equal = "K_equal"
public constant IUP_K_greater = "K_greater"
public constant IUP_K_question = "K_question"
public constant IUP_K_at = "K_at"
public constant IUP_K_A = "K_A"
public constant IUP_K_B = "K_B"
public constant IUP_K_C = "K_C"
public constant IUP_K_D = "K_D"
public constant IUP_K_E = "K_E"
public constant IUP_K_F = "K_F"
public constant IUP_K_G = "K_G"
public constant IUP_K_H = "K_H"
public constant IUP_K_I = "K_I"
public constant IUP_K_J = "K_J"
public constant IUP_K_K = "K_K"
public constant IUP_K_L = "K_L"
public constant IUP_K_M = "K_M"
public constant IUP_K_N = "K_N"
public constant IUP_K_O = "K_O"
public constant IUP_K_P = "K_P"
public constant IUP_K_Q = "K_Q"
public constant IUP_K_R = "K_R"
public constant IUP_K_S = "K_S"
public constant IUP_K_T = "K_T"
public constant IUP_K_U = "K_U"
public constant IUP_K_V = "K_V"
public constant IUP_K_W = "K_W"
public constant IUP_K_X = "K_X"
public constant IUP_K_Y = "K_Y"
public constant IUP_K_Z = "K_Z"
public constant IUP_K_bracketleft = "K_bracketleft"
public constant IUP_K_backslash = "K_backslash"
public constant IUP_K_bracketright = "K_bracketright"
public constant IUP_K_circum = "K_circum"
public constant IUP_K_underscore = "K_underscore"
public constant IUP_K_quoteleft = "K_quoteleft"
public constant IUP_K_a = "K_a"
public constant IUP_K_b = "K_b"
public constant IUP_K_c = "K_c"
public constant IUP_K_d = "K_d"
public constant IUP_K_e = "K_e"
public constant IUP_K_f = "K_f"
public constant IUP_K_g = "K_g"
public constant IUP_K_h = "K_h"
public constant IUP_K_i = "K_i"
public constant IUP_K_j = "K_j"
public constant IUP_K_k = "K_k"
public constant IUP_K_l = "K_l"
public constant IUP_K_m = "K_m"
public constant IUP_K_n = "K_n"
public constant IUP_K_o = "K_o"
public constant IUP_K_p = "K_p"
public constant IUP_K_q = "K_q"
public constant IUP_K_r = "K_r"
public constant IUP_K_s = "K_s"
public constant IUP_K_t = "K_t"
public constant IUP_K_u = "K_u"
public constant IUP_K_v = "K_v"
public constant IUP_K_w = "K_w"
public constant IUP_K_x = "K_x"
public constant IUP_K_y = "K_y"
public constant IUP_K_z = "K_z"
public constant IUP_K_braceleft = "K_braceleft"
public constant IUP_K_bar = "K_bar"
public constant IUP_K_braceright = "K_braceright"
public constant IUP_K_tilde = "K_tilde"

public constant IUP_K_cA = "K_cA"
public constant IUP_K_cB = "K_cB"
public constant IUP_K_cC = "K_cC"
public constant IUP_K_cD = "K_cD"
public constant IUP_K_cE = "K_cE"
public constant IUP_K_cF = "K_cF"
public constant IUP_K_cG = "K_cG"
public constant IUP_K_cJ = "K_cJ"
public constant IUP_K_cK = "K_cK"
public constant IUP_K_cL = "K_cL"
public constant IUP_K_cN = "K_cN"
public constant IUP_K_cO = "K_cO"
public constant IUP_K_cP = "K_cP"
public constant IUP_K_cQ = "K_cQ"
public constant IUP_K_cR = "K_cR"
public constant IUP_K_cS = "K_cS"
public constant IUP_K_cT = "K_cT"
public constant IUP_K_cU = "K_cU"
public constant IUP_K_cV = "K_cV"
public constant IUP_K_cW = "K_cW"
public constant IUP_K_cX = "K_cX"
public constant IUP_K_cY = "K_cY"
public constant IUP_K_cZ = "K_cZ"
public constant IUP_K_mA = "K_mA"
public constant IUP_K_mB = "K_mB"
public constant IUP_K_mC = "K_mC"
public constant IUP_K_mD = "K_mD"
public constant IUP_K_mE = "K_mE"
public constant IUP_K_mF = "K_mF"
public constant IUP_K_mG = "K_mG"
public constant IUP_K_mH = "K_mH"
public constant IUP_K_mI = "K_mI"
public constant IUP_K_mJ = "K_mJ"
public constant IUP_K_mK = "K_mK"
public constant IUP_K_mL = "K_mL"
public constant IUP_K_mM = "K_mM"
public constant IUP_K_mN = "K_mN"
public constant IUP_K_mO = "K_mO"
public constant IUP_K_mP = "K_mP"
public constant IUP_K_mQ = "K_mQ"
public constant IUP_K_mR = "K_mR"
public constant IUP_K_mS = "K_mS"
public constant IUP_K_mT = "K_mT"
public constant IUP_K_mU = "K_mU"
public constant IUP_K_mV = "K_mV"
public constant IUP_K_mW = "K_mW"
public constant IUP_K_mX = "K_mX"
public constant IUP_K_mY = "K_mY"
public constant IUP_K_mZ = "K_mZ"
public constant IUP_K_BS = "K_BS"
public constant IUP_K_TAB = "K_TAB"
public constant IUP_K_CR = "K_CR"
public constant IUP_K_SP = "K_SP"
public constant IUP_K_ESC = "K_ESC"
public constant IUP_K_sCR = "K_sCR"
public constant IUP_K_sTAB = "K_sTAB"
public constant IUP_K_cTAB = "K_cTAB"
public constant IUP_K_mTAB = "K_mTAB"
public constant IUP_K_HOME = "K_HOME"
public constant IUP_K_UP = "K_UP"
public constant IUP_K_PGUP = "K_PGUP"
public constant IUP_K_LEFT = "K_LEFT"
public constant IUP_K_RIGHT = "K_RIGHT"
public constant IUP_K_END = "K_END"
public constant IUP_K_DOWN = "K_DOWN"
public constant IUP_K_PGDN = "K_PGDN"
public constant IUP_K_MIDDLE = "K_MIDDLE"
public constant IUP_K_INS = "K_INS"
public constant IUP_K_DEL = "K_DEL"
public constant IUP_K_sHOME = "K_sHOME"
public constant IUP_K_sUP = "K_sUP"
public constant IUP_K_sPGUP = "K_sPGUP"
public constant IUP_K_sLEFT = "K_sLEFT"
public constant IUP_K_sRIGHT = "K_sRIGHT"
public constant IUP_K_sEND = "K_sEND"
public constant IUP_K_sDOWN = "K_sDOWN"
public constant IUP_K_sPGDN = "K_sPGDN"
public constant IUP_K_cHOME = "K_cHOME"
public constant IUP_K_cPGUP = "K_cPGUP"
public constant IUP_K_cLEFT = "K_cLEFT"
public constant IUP_K_cRIGHT = "K_cRIGHT"
public constant IUP_K_cEND = "K_cEND"
public constant IUP_K_cPGDN = "K_cPGDN"
public constant IUP_K_cUP = "K_cUP"
public constant IUP_K_cDOWN = "K_cDOWN"
public constant IUP_K_cMIDDLE = "K_cMIDDLE"
public constant IUP_K_cINS = "K_cINS"
public constant IUP_K_cDEL = "K_cDEL"
public constant IUP_K_mHOME = "K_mHOME"
public constant IUP_K_mPGUP = "K_mPGUP"
public constant IUP_K_mLEFT = "K_mLEFT"
public constant IUP_K_mRIGHT = "K_mRIGHT"
public constant IUP_K_mEND = "K_mEND"
public constant IUP_K_mPGDN = "K_mPGDN"
public constant IUP_K_mUP = "K_mUP"
public constant IUP_K_mDOWN = "K_mDOWN"
public constant IUP_K_mINS = "K_mINS"
public constant IUP_K_mDEL = "K_mDEL"
public constant IUP_K_F1 = "K_F1"
public constant IUP_K_F2 = "K_F2"
public constant IUP_K_F3 = "K_F3"
public constant IUP_K_F4 = "K_F4"
public constant IUP_K_F5 = "K_F5"
public constant IUP_K_F6 = "K_F6"
public constant IUP_K_F7 = "K_F7"
public constant IUP_K_F8 = "K_F8"
public constant IUP_K_F9 = "K_F9"
public constant IUP_K_F10 = "K_F10"
public constant IUP_K_F11 = "K_F11"
public constant IUP_K_F12 = "K_F12"
public constant IUP_K_sF1 = "K_sF1"
public constant IUP_K_sF2 = "K_sF2"
public constant IUP_K_sF3 = "K_sF3"
public constant IUP_K_sF4 = "K_sF4"
public constant IUP_K_sF5 = "K_sF5"
public constant IUP_K_sF6 = "K_sF6"
public constant IUP_K_sF7 = "K_sF7"
public constant IUP_K_sF8 = "K_sF8"
public constant IUP_K_sF9 = "K_sF9"
public constant IUP_K_sF10 = "K_sF10"
public constant IUP_K_sF11 = "K_sF11"
public constant IUP_K_sF12 = "K_sF12"
public constant IUP_K_cF1 = "K_cF1"
public constant IUP_K_cF2 = "K_cF2"
public constant IUP_K_cF3 = "K_cF3"
public constant IUP_K_cF4 = "K_cF4"
public constant IUP_K_cF5 = "K_cF5"
public constant IUP_K_cF6 = "K_cF6"
public constant IUP_K_cF7 = "K_cF7"
public constant IUP_K_cF8 = "K_cF8"
public constant IUP_K_cF9 = "K_cF9"
public constant IUP_K_cF10 = "K_cF10"
public constant IUP_K_cF11 = "K_cF11"
public constant IUP_K_cF12 = "K_cF12"
public constant IUP_K_mF1 = "K_mF1"
public constant IUP_K_mF2 = "K_mF2"
public constant IUP_K_mF3 = "K_mF3"
public constant IUP_K_mF4 = "K_mF4"
public constant IUP_K_mF5 = "K_mF5"
public constant IUP_K_mF6 = "K_mF6"
public constant IUP_K_mF7 = "K_mF7"
public constant IUP_K_mF8 = "K_mF8"
public constant IUP_K_mF9 = "K_mF9"
public constant IUP_K_mF10 = "K_mF10"
public constant IUP_K_m1 = "K_m1"
public constant IUP_K_m2 = "K_m2"
public constant IUP_K_m3 = "K_m3"
public constant IUP_K_m4 = "K_m4"
public constant IUP_K_m5 = "K_m5"
public constant IUP_K_m6 = "K_m6"
public constant IUP_K_m7 = "K_m7"
public constant IUP_K_m8 = "K_m8"
public constant IUP_K_m9 = "K_m9"
public constant IUP_K_m0 = "K_m0"

/************/
/* Colorbar */
/************/

public constant IUP_NUM_PARTS = "NUM_PARTS"
public constant IUP_NUM_CELLS = "NUM_CELLS"
public constant IUP_CELL = "CELL"
public constant IUP_PREVIEW_SIZE = "PREVIEW_SIZE"
public constant IUP_SHOW_PREVIEW = "SHOW_PREVIEW"
public constant IUP_SHOW_SECONDARY = "SHOW_SECONDARY"
public constant IUP_PRIMARY_CELL = "PRIMARY_CELL"
public constant IUP_SECONDARY_CELL = "SECONDARY_CELL"
public constant IUP_ORIENTATION = "ORIENTATION"
public constant IUP_SQUARED = "SQUARED"
public constant IUP_SHADOWED = "SHADOWED"
public constant IUP_BUFFERIZE = "BUFFERIZE"
public constant IUP_TRANSPARENCY = "TRANSPARENCY"
public constant IUP_CELL_CB = "CELL_CB"
public constant IUP_EXTENDED_CB = "EXTENDED_CB"
public constant IUP_SELECT_CB = "SELECT_CB"
public constant IUP_SWITCH_CB = "SWITCH_CB"
--#define IUP_VERTICAL    "VERTICAL"
--#define IUP_HORIZONTAL  "HORIZONTAL"

/************/
/* Cells    */
/************/

public constant IUP_ALL = "ALL"
public constant IUP_BOXED = "BOXED"
public constant IUP_CLIPPED = "CLIPPED"
public constant IUP_TRANSPARENT = "TRANSPARENT"
public constant IUP_NON_SCROLLABLE_LINES = "NON_SCROLLABLE_LINES"
public constant IUP_NON_SCROLLABLE_COLS = "NON_SCROLLABLE_COLS"
public constant IUP_ORIGIN = "ORIGIN"
public constant IUP_NO_COLOR = "NO_COLOR"
public constant IUP_FIRST_LINE = "FIRST_LINE"
public constant IUP_FIRST_COL = "FIRST_COL"
public constant IUP_DOUBLE_BUFFER = "DOUBLE_BUFFER"
public constant IUP_LIMITS = "LIMITS"
public constant IUP_CANVAS = "CANVAS"
public constant IUP_IMAGE_CANVAS = "IMAGE_CANVAS"
public constant IUP_FULL_VISIBLE = "FULL_VISIBLE"
public constant IUP_MOUSECLICK_CB = "MOUSECLICK_CB"
public constant IUP_MOUSEMOTION_CB = "MOUSEMOTION_CB"
public constant IUP_DRAW_CB = "DRAW_CB"
public constant IUP_WIDTH_CB = "WIDTH_CB"
public constant IUP_HEIGHT_CB = "HEIGHT_CB"
public constant IUP_NLINES_CB = "NLINES_CB"
public constant IUP_NCOLS_CB = "NCOLS_CB"
public constant IUP_HSPAN_CB = "HSPAN_CB"
public constant IUP_VSPAN_CB = "VSPAN_CB"
public constant IUP_SCROLLING_CB = "SCROLLING_CB"

/*****************/
/* ColorBrowser  */
/*****************/

public constant IUP_RGB = "RGB"
public constant IUP_CHANGE_CB = "CHANGE_CB"
public constant IUP_DRAG_CB = "DRAG_CB"

/*****************/
/* Val           */
/*****************/

public constant ICTL_MOUSEMOVE_CB = "MOUSEMOVE_CB"
public constant ICTL_BUTTON_PRESS_CB = "BUTTON_PRESS_CB"
public constant ICTL_BUTTON_RELEASE_CB = "BUTTON_RELEASE_CB"
public constant ICTL_HORIZONTAL = "HORIZONTAL"
public constant ICTL_VERTICAL = "VERTICAL"
public constant ICTL_SHOWTICKS = "SHOWTICKS"

/*****************/
/* Tabs          */
/*****************/

public constant ICTL_TOP = "TOP"
public constant ICTL_BOTTOM = "BOTTOM"
public constant ICTL_LEFT = "LEFT"
public constant ICTL_RIGHT = "RIGHT"
public constant ICTL_TABTYPE = "TABTYPE"
public constant ICTL_TABTITLE = "TABTITLE"
public constant ICTL_TABSIZE = "TABSIZE"
public constant ICTL_TABCHANGE_CB = "TABCHANGE_CB"
public constant ICTL_FONT = "FONT"
public constant ICTL_FONT_ACTIVE = "FONT_ACTIVE"
public constant ICTL_FONT_INACTIVE = "FONT_INACTIVE"

/*****************/
/* Gauge         */
/*****************/

public constant ICTL_SHOW_TEXT = "SHOW_TEXT"
public constant ICTL_DASHED = "DASHED"
public constant ICTL_MARGIN = "MARGIN"
public constant ICTL_TEXT = "TEXT"

/*****************/
/* Dial          */
/*****************/

public constant ICTL_DENSITY = "DENSITY"
--#define ICTL_HORIZONTAL "HORIZONTAL"
--#define ICTL_VERTICAL "VERTICAL"
public constant ICTL_CIRCULAR = "CIRCULAR"
public constant ICTL_UNIT = "UNIT"

/*****************/
/* Matrix        */
/*****************/

public constant IUP_ENTERITEM_CB = "ENTERITEM_CB"
public constant IUP_LEAVEITEM_CB = "LEAVEITEM_CB"
public constant IUP_EDITION_CB = "EDITION_CB"
public constant IUP_CLICK_CB = "CLICK_CB"
public constant IUP_DROP_CB = "DROP_CB"
public constant IUP_DROPSELECT_CB = "DROPSELECT_CB"
public constant IUP_DROPCHECK_CB = "DROPCHECK_CB"
--#define IUP_SCROLL_CB      "SCROLL_CB"
public constant IUP_VALUE_CB = "VALUE_CB"
public constant IUP_VALUE_EDIT_CB = "VALUE_EDIT_CB"
public constant IUP_FIELD_CB = "FIELD_CB"
public constant IUP_RESIZEMATRIX = "RESIZEMATRIX"
public constant IUP_ADDLIN = "ADDLIN"
public constant IUP_ADDCOL = "ADDCOL"
public constant IUP_DELLIN = "DELLIN"
public constant IUP_DELCOL = "DELCOL"
public constant IUP_NUMLIN = "NUMLIN"
public constant IUP_NUMCOL = "NUMCOL"
public constant IUP_NUMLIN_VISIBLE = "NUMLIN_VISIBLE"
public constant IUP_NUMCOL_VISIBLE = "NUMCOL_VISIBLE"
public constant IUP_MARKED = "MARKED"
public constant IUP_WIDTHDEF = "WIDTHDEF"
public constant IUP_HEIGHTDEF = "HEIGHTDEF"
public constant IUP_AREA = "AREA"
public constant IUP_MARK_MODE = "MARK_MODE"
public constant IUP_LIN = "LIN"
public constant IUP_COL = "COL"
public constant IUP_LINCOL = "LINCOL"
--#define IUP_CELL           "CELL"
public constant IUP_EDIT_MODE = "EDIT_MODE"
public constant IUP_FOCUS_CELL = "FOCUS_CELL"
--#define IUP_ORIGIN         "ORIGIN"
public constant IUP_REDRAW = "REDRAW"
public constant IUP_PREVIOUSVALUE = "PREVIOUSVALUE"
public constant IUP_MOUSEMOVE_CB = "MOUSEMOVE_CB"

/*****************/
/* Tree          */
/*****************/

public constant IUP_ADDLEAF = "ADDLEAF"
public constant IUP_ADDBRANCH = "ADDBRANCH"
public constant IUP_DELNODE = "DELNODE"
public constant IUP_IMAGELEAF = "IMAGELEAF"
public constant IUP_IMAGEBRANCHCOLLAPSED = "IMAGEBRANCHCOLLAPSED"
public constant IUP_IMAGEBRANCHEXPANDED = "IMAGEBRANCHEXPANDED"
public constant IUP_IMAGEEXPANDED = "IMAGEEXPANDED"
public constant IUP_KIND = "KIND"
public constant IUP_PARENT = "PARENT"
public constant IUP_DEPTH = "DEPTH"
--#define IUP_MARKED           "MARKED"
public constant IUP_ADDEXPANDED = "ADDEXPANDED"
public constant IUP_CTRL = "CTRL"
public constant IUP_SHIFT = "SHIFT"
public constant IUP_STATE = "STATE"
public constant IUP_STARTING = "STARTING"
public constant IUP_LEAF = "LEAF"
public constant IUP_BRANCH = "BRANCH"
public constant IUP_SELECTED = "SELECTED"
public constant IUP_CHILDREN = "CHILDREN"
--#define IUP_MARKED           "MARKED"
public constant IUP_ROOT = "ROOT"
public constant IUP_LAST = "LAST"
public constant IUP_PGUP = "PGUP"
public constant IUP_PGDN = "PGDN"
public constant IUP_NEXT = "NEXT"
public constant IUP_PREVIOUS = "PREVIOUS"
public constant IUP_INVERT = "INVERT"
public constant IUP_BLOCK = "BLOCK"
public constant IUP_CLEARALL = "CLEARALL"
public constant IUP_MARKALL = "MARKALL"
public constant IUP_INVERTALL = "INVERTALL"
--#define IUP_REDRAW           "REDRAW"
public constant IUP_COLLAPSED = "COLLAPSED"
public constant IUP_EXPANDED = "EXPANDED"
public constant IUP_SELECTION_CB = "SELECTION_CB"
public constant IUP_BRANCHOPEN_CB = "BRANCHOPEN_CB"
public constant IUP_BRANCHCLOSE_CB = "BRANCHCLOSE_CB"
public constant IUP_RIGHTCLICK_CB = "RIGHTCLICK_CB"
public constant IUP_EXECUTELEAF_CB = "EXECUTELEAF_CB"
public constant IUP_RENAMENODE_CB = "RENAMENODE_CB"
public constant IUP_IMGLEAF = "IMGLEAF"
public constant IUP_IMGCOLLAPSED = "IMGCOLLAPSED"
public constant IUP_IMGEXPANDED = "IMGEXPANDED"
public constant IUP_IMGBLANK = "IMGBLANK"
public constant IUP_IMGPAPER = "IMGPAPER"

--#endif