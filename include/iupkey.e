/** \file
 * \brief Keyboard Keys definitions.
 *
 * See Copyright Notice in "iup.h"
 */

--#ifndef __IUPKEY_H
--#define __IUPKEY_H

/* from 32 to 126, all character sets are equal, the key code is the same as the ASCii character code. */

public constant K_SP = ' ' /* 32 (0x20) */
public constant K_exclam = '!' /* 33 */
public constant K_quotedbl = '\"' /* 34 */
public constant K_numbersign = '#' /* 35 */
public constant K_dollar = '$' /* 36 */
public constant K_percent = '%' /* 37 */
public constant K_ampersand = '&' /* 38 */
public constant K_apostrophe = '\'' /* 39 */
public constant K_parentleft = '(' /* 40 */
public constant K_parentright = ')' /* 41 */
public constant K_asterisk = '*' /* 42 */
public constant K_plus = '+' /* 43 */
public constant K_comma = ',' /* 44 */
public constant K_minus = '-' /* 45 */
public constant K_period = '.' /* 46 */
public constant K_slash = '/' /* 47 */
public constant K_0 = '0' /* 48 (0x30) */
public constant K_1 = '1' /* 49 */
public constant K_2 = '2' /* 50 */
public constant K_3 = '3' /* 51 */
public constant K_4 = '4' /* 52 */
public constant K_5 = '5' /* 53 */
public constant K_6 = '6' /* 54 */
public constant K_7 = '7' /* 55 */
public constant K_8 = '8' /* 56 */
public constant K_9 = '9' /* 57 */
public constant K_colon = ':' /* 58 */
public constant K_semicolon = ';' /* 59 */
public constant K_less = '<' /* 60 */
public constant K_equal = '=' /* 61 */
public constant K_greater = '>' /* 62 */
public constant K_question = '?' /* 63 */
public constant K_at = '@' /* 64 */
public constant K_A = 'A' /* 65 (0x41) */
public constant K_B = 'B' /* 66 */
public constant K_C = 'C' /* 67 */
public constant K_D = 'D' /* 68 */
public constant K_E = 'E' /* 69 */
public constant K_F = 'F' /* 70 */
public constant K_G = 'G' /* 71 */
public constant K_H = 'H' /* 72 */
public constant K_I = 'I' /* 73 */
public constant K_J = 'J' /* 74 */
public constant K_K = 'K' /* 75 */
public constant K_L = 'L' /* 76 */
public constant K_M = 'M' /* 77 */
public constant K_N = 'N' /* 78 */
public constant K_O = 'O' /* 79 */
public constant K_P = 'P' /* 80 */
public constant K_Q = 'Q' /* 81 */
public constant K_R = 'R' /* 82 */
public constant K_S = 'S' /* 83 */
public constant K_T = 'T' /* 84 */
public constant K_U = 'U' /* 85 */
public constant K_V = 'V' /* 86 */
public constant K_W = 'W' /* 87 */
public constant K_X = 'X' /* 88 */
public constant K_Y = 'Y' /* 89 */
public constant K_Z = 'Z' /* 90 */
public constant K_bracketleft = '[' /* 91 */
public constant K_backslash = '\\' /* 92 */
public constant K_bracketright = ']' /* 93 */
public constant K_circum = '^' /* 94 */
public constant K_underscore = '_' /* 95 */
public constant K_grave = '`' /* 96 */
public constant K_a = 'a' /* 97 (0x61) */
public constant K_b = 'b' /* 98 */
public constant K_c = 'c' /* 99 */
public constant K_d = 'd' /* 100 */
public constant K_e = 'e' /* 101 */
public constant K_f = 'f' /* 102 */
public constant K_g = 'g' /* 103 */
public constant K_h = 'h' /* 104 */
public constant K_i = 'i' /* 105 */
public constant K_j = 'j' /* 106 */
public constant K_k = 'k' /* 107 */
public constant K_l = 'l' /* 108 */
public constant K_m = 'm' /* 109 */
public constant K_n = 'n' /* 110 */
public constant K_o = 'o' /* 111 */
public constant K_p = 'p' /* 112 */
public constant K_q = 'q' /* 113 */
public constant K_r = 'r' /* 114 */
public constant K_s = 's' /* 115 */
public constant K_t = 't' /* 116 */
public constant K_u = 'u' /* 117 */
public constant K_v = 'v' /* 118 */
public constant K_w = 'w' /* 119 */
public constant K_x = 'x' /* 120 */
public constant K_y = 'y' /* 121 */
public constant K_z = 'z' /* 122 */
public constant K_braceleft = '{' /* 123 */
public constant K_bar = '|' /* 124 */
public constant K_braceright = '}' /* 125 */
public constant K_tilde = '~' /* 126 (0x7E) */

/* Printable ASCii keys */

public function iup_isprint( integer _c ) return ((_c) > 31 and (_c) < 127) end function

/* also define the escape sequences that have keys associated */

public constant K_BS = '\x08' /* 8 */
public constant K_TAB = '\t' /* 9 */
public constant K_LF = '\n' /* 10 (0x0A) not a real key, is a combination of CR with a modifier, just to document */
public constant K_CR = '\r' /* 13 (0x0D) */

/* backward compatible definitions */

--#define  K_quoteleft   K_grave
--#define  K_quoteright  K_apostrophe
--#define  isxkey        iup_isXkey

/* IUP Extended Key Codes, range start at 128      */

public function iup_isXkey( integer _c ) return ((_c) >= 128) end function

/* These use the same definition as X11 and GDK.
   This also means that any X11 or GDK definition can also be used. */

public constant K_PAUSE = 0xFF13
public constant K_ESC = 0xFF1B
public constant K_HOME = 0xFF50
public constant K_LEFT = 0xFF51
public constant K_UP = 0xFF52
public constant K_RIGHT = 0xFF53
public constant K_DOWN = 0xFF54
public constant K_PGUP = 0xFF55
public constant K_PGDN = 0xFF56
public constant K_END = 0xFF57
public constant K_MIDDLE = 0xFF0B
public constant K_Print = 0xFF61
public constant K_INS = 0xFF63
public constant K_Menu = 0xFF67
public constant K_DEL = 0xFFFF
public constant K_F1 = 0xFFBE
public constant K_F2 = 0xFFBF
public constant K_F3 = 0xFFC0
public constant K_F4 = 0xFFC1
public constant K_F5 = 0xFFC2
public constant K_F6 = 0xFFC3
public constant K_F7 = 0xFFC4
public constant K_F8 = 0xFFC5
public constant K_F9 = 0xFFC6
public constant K_F10 = 0xFFC7
public constant K_F11 = 0xFFC8
public constant K_F12 = 0xFFC9
public constant K_F13 = 0xFFCA
public constant K_F14 = 0xFFCB
public constant K_F15 = 0xFFCC
public constant K_F16 = 0xFFCD
public constant K_F17 = 0xFFCE
public constant K_F18 = 0xFFCF
public constant K_F19 = 0xFFD0
public constant K_F20 = 0xFFD1

/* no Shift/Ctrl/Alt */
public constant K_LSHIFT = 0xFFE1
public constant K_RSHIFT = 0xFFE2
public constant K_LCTRL = 0xFFE3
public constant K_RCTRL = 0xFFE4
public constant K_LALT = 0xFFE9
public constant K_RALT = 0xFFEA

public constant K_NUM = 0xFF7F
public constant K_SCROLL = 0xFF14
public constant K_CAPS = 0xFFE5

/* Mac clear button. Value randomly picked trying to avoid clashing with an existing value. */
public constant K_CLEAR = 0xFFD2
/* Help button if anybody has it. Value randomly picked trying to avoid clashing with an existing value. */
public constant K_HELP = 0xFFD3

/* Also, these are the same as the Latin-1 definition */

public constant K_ccedilla = 0x00E7
public constant K_Ccedilla = 0x00C7
public constant K_acute = 0x00B4 /* no Shift/Ctrl/Alt */
public constant K_diaeresis = 0x00A8

/******************************************************/
/* Modifiers use last 4 bits. Since IUP 3.9           */
/* These modifiers definitions are specific to IUP    */
/******************************************************/

public function iup_isShiftXkey( integer _c ) return (and_bits((_c), 0x10000000) != 0) end function
public function iup_isCtrlXkey( integer _c )  return (and_bits((_c), 0x20000000) != 0) end function
public function iup_isAltXkey( integer _c )   return (and_bits((_c), 0x40000000) != 0) end function
public function iup_isSysXkey( integer _c )   return (and_bits((_c), 0x80000000) != 0) end function

public function iup_XkeyBase( integer _c )  return and_bits((_c), 0x0FFFFFFF) end function
public function iup_XkeyShift( integer _c ) return or_bits((_c), 0x10000000) /* Shift */ end function
public function iup_XkeyCtrl( integer _c )  return or_bits((_c), 0x20000000) /* Ctrl  */ end function
public function iup_XkeyAlt( integer _c )   return or_bits((_c), 0x40000000) /* Alt   */ end function
public function iup_XkeySys( integer _c )   return or_bits((_c), 0x80000000) /* Sys   */ end function

/* These definitions are here for backward compatibility
   and to simplify some key combination usage.
   But since IUP 3.9, modifiers can be combined with any key
   and they can be mixed together. */

public constant K_sHOME = iup_XkeyShift(K_HOME)
public constant K_sUP = iup_XkeyShift(K_UP)
public constant K_sPGUP = iup_XkeyShift(K_PGUP)
public constant K_sLEFT = iup_XkeyShift(K_LEFT)
public constant K_sMIDDLE = iup_XkeyShift(K_MIDDLE)
public constant K_sRIGHT = iup_XkeyShift(K_RIGHT)
public constant K_sEND = iup_XkeyShift(K_END)
public constant K_sDOWN = iup_XkeyShift(K_DOWN)
public constant K_sPGDN = iup_XkeyShift(K_PGDN)
public constant K_sINS = iup_XkeyShift(K_INS)
public constant K_sDEL = iup_XkeyShift(K_DEL)
public constant K_sSP = iup_XkeyShift(K_SP)
public constant K_sTAB = iup_XkeyShift(K_TAB)
public constant K_sCR = iup_XkeyShift(K_CR)
public constant K_sBS = iup_XkeyShift(K_BS)
public constant K_sPAUSE = iup_XkeyShift(K_PAUSE)
public constant K_sESC = iup_XkeyShift(K_ESC)
public constant K_sCLEAR = iup_XkeyShift(K_CLEAR)
public constant K_sF1 = iup_XkeyShift(K_F1)
public constant K_sF2 = iup_XkeyShift(K_F2)
public constant K_sF3 = iup_XkeyShift(K_F3)
public constant K_sF4 = iup_XkeyShift(K_F4)
public constant K_sF5 = iup_XkeyShift(K_F5)
public constant K_sF6 = iup_XkeyShift(K_F6)
public constant K_sF7 = iup_XkeyShift(K_F7)
public constant K_sF8 = iup_XkeyShift(K_F8)
public constant K_sF9 = iup_XkeyShift(K_F9)
public constant K_sF10 = iup_XkeyShift(K_F10)
public constant K_sF11 = iup_XkeyShift(K_F11)
public constant K_sF12 = iup_XkeyShift(K_F12)
public constant K_sF13 = iup_XkeyShift(K_F13)
public constant K_sF14 = iup_XkeyShift(K_F14)
public constant K_sF15 = iup_XkeyShift(K_F15)
public constant K_sF16 = iup_XkeyShift(K_F16)
public constant K_sF17 = iup_XkeyShift(K_F17)
public constant K_sF18 = iup_XkeyShift(K_F18)
public constant K_sF19 = iup_XkeyShift(K_F19)
public constant K_sF20 = iup_XkeyShift(K_F20)
public constant K_sPrint = iup_XkeyShift(K_Print)
public constant K_sMenu = iup_XkeyShift(K_Menu)

public constant K_cHOME = iup_XkeyCtrl(K_HOME)
public constant K_cUP = iup_XkeyCtrl(K_UP)
public constant K_cPGUP = iup_XkeyCtrl(K_PGUP)
public constant K_cLEFT = iup_XkeyCtrl(K_LEFT)
public constant K_cMIDDLE = iup_XkeyCtrl(K_MIDDLE)
public constant K_cRIGHT = iup_XkeyCtrl(K_RIGHT)
public constant K_cEND = iup_XkeyCtrl(K_END)
public constant K_cDOWN = iup_XkeyCtrl(K_DOWN)
public constant K_cPGDN = iup_XkeyCtrl(K_PGDN)
public constant K_cINS = iup_XkeyCtrl(K_INS)
public constant K_cDEL = iup_XkeyCtrl(K_DEL)
public constant K_cSP = iup_XkeyCtrl(K_SP)
public constant K_cTAB = iup_XkeyCtrl(K_TAB)
public constant K_cCR = iup_XkeyCtrl(K_CR)
public constant K_cBS = iup_XkeyCtrl(K_BS)
public constant K_cPAUSE = iup_XkeyCtrl(K_PAUSE)
public constant K_cESC = iup_XkeyCtrl(K_ESC)
public constant K_cCLEAR = iup_XkeyCtrl(K_CLEAR)
public constant K_cCcedilla = iup_XkeyCtrl(K_Ccedilla)
public constant K_cF1 = iup_XkeyCtrl(K_F1)
public constant K_cF2 = iup_XkeyCtrl(K_F2)
public constant K_cF3 = iup_XkeyCtrl(K_F3)
public constant K_cF4 = iup_XkeyCtrl(K_F4)
public constant K_cF5 = iup_XkeyCtrl(K_F5)
public constant K_cF6 = iup_XkeyCtrl(K_F6)
public constant K_cF7 = iup_XkeyCtrl(K_F7)
public constant K_cF8 = iup_XkeyCtrl(K_F8)
public constant K_cF9 = iup_XkeyCtrl(K_F9)
public constant K_cF10 = iup_XkeyCtrl(K_F10)
public constant K_cF11 = iup_XkeyCtrl(K_F11)
public constant K_cF12 = iup_XkeyCtrl(K_F12)
public constant K_cF13 = iup_XkeyCtrl(K_F13)
public constant K_cF14 = iup_XkeyCtrl(K_F14)
public constant K_cF15 = iup_XkeyCtrl(K_F15)
public constant K_cF16 = iup_XkeyCtrl(K_F16)
public constant K_cF17 = iup_XkeyCtrl(K_F17)
public constant K_cF18 = iup_XkeyCtrl(K_F18)
public constant K_cF19 = iup_XkeyCtrl(K_F19)
public constant K_cF20 = iup_XkeyCtrl(K_F20)
public constant K_cPrint = iup_XkeyCtrl(K_Print)
public constant K_cMenu = iup_XkeyCtrl(K_Menu)

public constant K_mHOME = iup_XkeyAlt(K_HOME)
public constant K_mUP = iup_XkeyAlt(K_UP)
public constant K_mPGUP = iup_XkeyAlt(K_PGUP)
public constant K_mLEFT = iup_XkeyAlt(K_LEFT)
public constant K_mMIDDLE = iup_XkeyAlt(K_MIDDLE)
public constant K_mRIGHT = iup_XkeyAlt(K_RIGHT)
public constant K_mEND = iup_XkeyAlt(K_END)
public constant K_mDOWN = iup_XkeyAlt(K_DOWN)
public constant K_mPGDN = iup_XkeyAlt(K_PGDN)
public constant K_mINS = iup_XkeyAlt(K_INS)
public constant K_mDEL = iup_XkeyAlt(K_DEL)
public constant K_mSP = iup_XkeyAlt(K_SP)
public constant K_mTAB = iup_XkeyAlt(K_TAB)
public constant K_mCR = iup_XkeyAlt(K_CR)
public constant K_mBS = iup_XkeyAlt(K_BS)
public constant K_mPAUSE = iup_XkeyAlt(K_PAUSE)
public constant K_mESC = iup_XkeyAlt(K_ESC)
public constant K_mCLEAR = iup_XkeyAlt(K_CLEAR)
public constant K_mCcedilla = iup_XkeyAlt(K_Ccedilla)
public constant K_mF1 = iup_XkeyAlt(K_F1)
public constant K_mF2 = iup_XkeyAlt(K_F2)
public constant K_mF3 = iup_XkeyAlt(K_F3)
public constant K_mF4 = iup_XkeyAlt(K_F4)
public constant K_mF5 = iup_XkeyAlt(K_F5)
public constant K_mF6 = iup_XkeyAlt(K_F6)
public constant K_mF7 = iup_XkeyAlt(K_F7)
public constant K_mF8 = iup_XkeyAlt(K_F8)
public constant K_mF9 = iup_XkeyAlt(K_F9)
public constant K_mF10 = iup_XkeyAlt(K_F10)
public constant K_mF11 = iup_XkeyAlt(K_F11)
public constant K_mF12 = iup_XkeyAlt(K_F12)
public constant K_mF13 = iup_XkeyAlt(K_F13)
public constant K_mF14 = iup_XkeyAlt(K_F14)
public constant K_mF15 = iup_XkeyAlt(K_F15)
public constant K_mF16 = iup_XkeyAlt(K_F16)
public constant K_mF17 = iup_XkeyAlt(K_F17)
public constant K_mF18 = iup_XkeyAlt(K_F18)
public constant K_mF19 = iup_XkeyAlt(K_F19)
public constant K_mF20 = iup_XkeyAlt(K_F20)
public constant K_mPrint = iup_XkeyAlt(K_Print)
public constant K_mMenu = iup_XkeyAlt(K_Menu)

public constant K_yHOME = iup_XkeySys(K_HOME)
public constant K_yUP = iup_XkeySys(K_UP)
public constant K_yPGUP = iup_XkeySys(K_PGUP)
public constant K_yLEFT = iup_XkeySys(K_LEFT)
public constant K_yMIDDLE = iup_XkeySys(K_MIDDLE)
public constant K_yRIGHT = iup_XkeySys(K_RIGHT)
public constant K_yEND = iup_XkeySys(K_END)
public constant K_yDOWN = iup_XkeySys(K_DOWN)
public constant K_yPGDN = iup_XkeySys(K_PGDN)
public constant K_yINS = iup_XkeySys(K_INS)
public constant K_yDEL = iup_XkeySys(K_DEL)
public constant K_ySP = iup_XkeySys(K_SP)
public constant K_yTAB = iup_XkeySys(K_TAB)
public constant K_yCR = iup_XkeySys(K_CR)
public constant K_yBS = iup_XkeySys(K_BS)
public constant K_yPAUSE = iup_XkeySys(K_PAUSE)
public constant K_yESC = iup_XkeySys(K_ESC)
public constant K_yCLEAR = iup_XkeySys(K_CLEAR)
public constant K_yCcedilla = iup_XkeySys(K_Ccedilla)
public constant K_yF1 = iup_XkeySys(K_F1)
public constant K_yF2 = iup_XkeySys(K_F2)
public constant K_yF3 = iup_XkeySys(K_F3)
public constant K_yF4 = iup_XkeySys(K_F4)
public constant K_yF5 = iup_XkeySys(K_F5)
public constant K_yF6 = iup_XkeySys(K_F6)
public constant K_yF7 = iup_XkeySys(K_F7)
public constant K_yF8 = iup_XkeySys(K_F8)
public constant K_yF9 = iup_XkeySys(K_F9)
public constant K_yF10 = iup_XkeySys(K_F10)
public constant K_yF11 = iup_XkeySys(K_F11)
public constant K_yF12 = iup_XkeySys(K_F12)
public constant K_yF13 = iup_XkeySys(K_F13)
public constant K_yF14 = iup_XkeySys(K_F14)
public constant K_yF15 = iup_XkeySys(K_F15)
public constant K_yF16 = iup_XkeySys(K_F16)
public constant K_yF17 = iup_XkeySys(K_F17)
public constant K_yF18 = iup_XkeySys(K_F18)
public constant K_yF19 = iup_XkeySys(K_F19)
public constant K_yF20 = iup_XkeySys(K_F20)
public constant K_yPrint = iup_XkeySys(K_Print)
public constant K_yMenu = iup_XkeySys(K_Menu)

public constant K_sPlus = iup_XkeyShift(K_plus)
public constant K_sComma = iup_XkeyShift(K_comma)
public constant K_sMinus = iup_XkeyShift(K_minus)
public constant K_sPeriod = iup_XkeyShift(K_period)
public constant K_sSlash = iup_XkeyShift(K_slash)
public constant K_sAsterisk = iup_XkeyShift(K_asterisk)

public constant K_cA = iup_XkeyCtrl(K_A)
public constant K_cB = iup_XkeyCtrl(K_B)
public constant K_cC = iup_XkeyCtrl(K_C)
public constant K_cD = iup_XkeyCtrl(K_D)
public constant K_cE = iup_XkeyCtrl(K_E)
public constant K_cF = iup_XkeyCtrl(K_F)
public constant K_cG = iup_XkeyCtrl(K_G)
public constant K_cH = iup_XkeyCtrl(K_H)
public constant K_cI = iup_XkeyCtrl(K_I)
public constant K_cJ = iup_XkeyCtrl(K_J)
public constant K_cK = iup_XkeyCtrl(K_K)
public constant K_cL = iup_XkeyCtrl(K_L)
public constant K_cM = iup_XkeyCtrl(K_M)
public constant K_cN = iup_XkeyCtrl(K_N)
public constant K_cO = iup_XkeyCtrl(K_O)
public constant K_cP = iup_XkeyCtrl(K_P)
public constant K_cQ = iup_XkeyCtrl(K_Q)
public constant K_cR = iup_XkeyCtrl(K_R)
public constant K_cS = iup_XkeyCtrl(K_S)
public constant K_cT = iup_XkeyCtrl(K_T)
public constant K_cU = iup_XkeyCtrl(K_U)
public constant K_cV = iup_XkeyCtrl(K_V)
public constant K_cW = iup_XkeyCtrl(K_W)
public constant K_cX = iup_XkeyCtrl(K_X)
public constant K_cY = iup_XkeyCtrl(K_Y)
public constant K_cZ = iup_XkeyCtrl(K_Z)
public constant K_c1 = iup_XkeyCtrl(K_1)
public constant K_c2 = iup_XkeyCtrl(K_2)
public constant K_c3 = iup_XkeyCtrl(K_3)
public constant K_c4 = iup_XkeyCtrl(K_4)
public constant K_c5 = iup_XkeyCtrl(K_5)
public constant K_c6 = iup_XkeyCtrl(K_6)
public constant K_c7 = iup_XkeyCtrl(K_7)
public constant K_c8 = iup_XkeyCtrl(K_8)
public constant K_c9 = iup_XkeyCtrl(K_9)
public constant K_c0 = iup_XkeyCtrl(K_0)
public constant K_cPlus = iup_XkeyCtrl(K_plus)
public constant K_cComma = iup_XkeyCtrl(K_comma)
public constant K_cMinus = iup_XkeyCtrl(K_minus)
public constant K_cPeriod = iup_XkeyCtrl(K_period)
public constant K_cSlash = iup_XkeyCtrl(K_slash)
public constant K_cSemicolon = iup_XkeyCtrl(K_semicolon)
public constant K_cEqual = iup_XkeyCtrl(K_equal)
public constant K_cBracketleft = iup_XkeyCtrl(K_bracketleft)
public constant K_cBracketright = iup_XkeyCtrl(K_bracketright)
public constant K_cBackslash = iup_XkeyCtrl(K_backslash)
public constant K_cAsterisk = iup_XkeyCtrl(K_asterisk)

public constant K_mA = iup_XkeyAlt(K_A)
public constant K_mB = iup_XkeyAlt(K_B)
public constant K_mC = iup_XkeyAlt(K_C)
public constant K_mD = iup_XkeyAlt(K_D)
public constant K_mE = iup_XkeyAlt(K_E)
public constant K_mF = iup_XkeyAlt(K_F)
public constant K_mG = iup_XkeyAlt(K_G)
public constant K_mH = iup_XkeyAlt(K_H)
public constant K_mI = iup_XkeyAlt(K_I)
public constant K_mJ = iup_XkeyAlt(K_J)
public constant K_mK = iup_XkeyAlt(K_K)
public constant K_mL = iup_XkeyAlt(K_L)
public constant K_mM = iup_XkeyAlt(K_M)
public constant K_mN = iup_XkeyAlt(K_N)
public constant K_mO = iup_XkeyAlt(K_O)
public constant K_mP = iup_XkeyAlt(K_P)
public constant K_mQ = iup_XkeyAlt(K_Q)
public constant K_mR = iup_XkeyAlt(K_R)
public constant K_mS = iup_XkeyAlt(K_S)
public constant K_mT = iup_XkeyAlt(K_T)
public constant K_mU = iup_XkeyAlt(K_U)
public constant K_mV = iup_XkeyAlt(K_V)
public constant K_mW = iup_XkeyAlt(K_W)
public constant K_mX = iup_XkeyAlt(K_X)
public constant K_mY = iup_XkeyAlt(K_Y)
public constant K_mZ = iup_XkeyAlt(K_Z)
public constant K_m1 = iup_XkeyAlt(K_1)
public constant K_m2 = iup_XkeyAlt(K_2)
public constant K_m3 = iup_XkeyAlt(K_3)
public constant K_m4 = iup_XkeyAlt(K_4)
public constant K_m5 = iup_XkeyAlt(K_5)
public constant K_m6 = iup_XkeyAlt(K_6)
public constant K_m7 = iup_XkeyAlt(K_7)
public constant K_m8 = iup_XkeyAlt(K_8)
public constant K_m9 = iup_XkeyAlt(K_9)
public constant K_m0 = iup_XkeyAlt(K_0)
public constant K_mPlus = iup_XkeyAlt(K_plus)
public constant K_mComma = iup_XkeyAlt(K_comma)
public constant K_mMinus = iup_XkeyAlt(K_minus)
public constant K_mPeriod = iup_XkeyAlt(K_period)
public constant K_mSlash = iup_XkeyAlt(K_slash)
public constant K_mSemicolon = iup_XkeyAlt(K_semicolon)
public constant K_mEqual = iup_XkeyAlt(K_equal)
public constant K_mBracketleft = iup_XkeyAlt(K_bracketleft)
public constant K_mBracketright = iup_XkeyAlt(K_bracketright)
public constant K_mBackslash = iup_XkeyAlt(K_backslash)
public constant K_mAsterisk = iup_XkeyAlt(K_asterisk)

public constant K_yA = iup_XkeySys(K_A)
public constant K_yB = iup_XkeySys(K_B)
public constant K_yC = iup_XkeySys(K_C)
public constant K_yD = iup_XkeySys(K_D)
public constant K_yE = iup_XkeySys(K_E)
public constant K_yF = iup_XkeySys(K_F)
public constant K_yG = iup_XkeySys(K_G)
public constant K_yH = iup_XkeySys(K_H)
public constant K_yI = iup_XkeySys(K_I)
public constant K_yJ = iup_XkeySys(K_J)
public constant K_yK = iup_XkeySys(K_K)
public constant K_yL = iup_XkeySys(K_L)
public constant K_yM = iup_XkeySys(K_M)
public constant K_yN = iup_XkeySys(K_N)
public constant K_yO = iup_XkeySys(K_O)
public constant K_yP = iup_XkeySys(K_P)
public constant K_yQ = iup_XkeySys(K_Q)
public constant K_yR = iup_XkeySys(K_R)
public constant K_yS = iup_XkeySys(K_S)
public constant K_yT = iup_XkeySys(K_T)
public constant K_yU = iup_XkeySys(K_U)
public constant K_yV = iup_XkeySys(K_V)
public constant K_yW = iup_XkeySys(K_W)
public constant K_yX = iup_XkeySys(K_X)
public constant K_yY = iup_XkeySys(K_Y)
public constant K_yZ = iup_XkeySys(K_Z)
public constant K_y1 = iup_XkeySys(K_1)
public constant K_y2 = iup_XkeySys(K_2)
public constant K_y3 = iup_XkeySys(K_3)
public constant K_y4 = iup_XkeySys(K_4)
public constant K_y5 = iup_XkeySys(K_5)
public constant K_y6 = iup_XkeySys(K_6)
public constant K_y7 = iup_XkeySys(K_7)
public constant K_y8 = iup_XkeySys(K_8)
public constant K_y9 = iup_XkeySys(K_9)
public constant K_y0 = iup_XkeySys(K_0)
public constant K_yPlus = iup_XkeySys(K_plus)
public constant K_yComma = iup_XkeySys(K_comma)
public constant K_yMinus = iup_XkeySys(K_minus)
public constant K_yPeriod = iup_XkeySys(K_period)
public constant K_ySlash = iup_XkeySys(K_slash)
public constant K_ySemicolon = iup_XkeySys(K_semicolon)
public constant K_yEqual = iup_XkeySys(K_equal)
public constant K_yBracketleft = iup_XkeySys(K_bracketleft)
public constant K_yBracketright = iup_XkeySys(K_bracketright)
public constant K_yBackslash = iup_XkeySys(K_backslash)
public constant K_yAsterisk = iup_XkeySys(K_asterisk)

--#endif
