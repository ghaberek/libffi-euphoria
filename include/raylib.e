/**********************************************************************************************
*
*   raylib v4.2 - A simple and easy-to-use library to enjoy videogames programming (www.raylib.com)
*
*   NOTICE: This is an incomplete Raylib wrapper for demonstrating libffi in Euphoria.
*
**********************************************************************************************/

include std/ffi.e
include std/machine.e

------------------------------------------------------------------------------------
-- Some basic Defines
------------------------------------------------------------------------------------

public constant PI = 3.14159265358979323846
public constant DEG2RAD = (PI / 180.0)
public constant RAD2DEG = (180.0 / PI)

-- Some Basic Colors
public constant LIGHTGRAY  = { 200, 200, 200, 255 } -- Light Gray
public constant GRAY       = { 130, 130, 130, 255 } -- Gray
public constant DARKGRAY   = { 80, 80, 80, 255 }    -- Dark Gray
public constant YELLOW     = { 253, 249, 0, 255 }   -- Yellow
public constant GOLD       = { 255, 203, 0, 255 }   -- Gold
public constant ORANGE     = { 255, 161, 0, 255 }   -- Orange
public constant PINK       = { 255, 109, 194, 255 } -- Pink
public constant RED        = { 230, 41, 55, 255 }   -- Red
public constant MAROON     = { 190, 33, 55, 255 }   -- Maroon
public constant GREEN      = { 0, 228, 48, 255 }    -- Green
public constant LIME       = { 0, 158, 47, 255 }    -- Lime
public constant DARKGREEN  = { 0, 117, 44, 255 }    -- Dark Green
public constant SKYBLUE    = { 102, 191, 255, 255 } -- Sky Blue
public constant BLUE       = { 0, 121, 241, 255 }   -- Blue
public constant DARKBLUE   = { 0, 82, 172, 255 }    -- Dark Blue
public constant PURPLE     = { 200, 122, 255, 255 } -- Purple
public constant VIOLET     = { 135, 60, 190, 255 }  -- Violet
public constant DARKPURPLE = { 112, 31, 126, 255 }  -- Dark Purple
public constant BEIGE      = { 211, 176, 131, 255 } -- Beige
public constant BROWN      = { 127, 106, 79, 255 }  -- Brown
public constant DARKBROWN  = { 76, 63, 47, 255 }    -- Dark Brown
public constant WHITE      = { 255, 255, 255, 255 } -- White
public constant BLACK      = { 0, 0, 0, 255 }       -- Black
public constant BLANK      = { 0, 0, 0, 0 }         -- Blank (Transparent)
public constant MAGENTA    = { 255, 0, 255, 255 }   -- Magenta
public constant RAYWHITE   = { 245, 245, 245, 255 } -- My own White (raylib logo)

------------------------------------------------------------------------------------
-- Structures Definition
------------------------------------------------------------------------------------

-- Boolean type
public enum type bool
	false = 0,
	true
end type

-- Vector2, 2 components
public constant RL_VECTOR2 = define_c_type({
	C_FLOAT, -- x   // Vector x component
	C_FLOAT  -- y   // Vector y component
})

-- Vector3, 3 components
public constant RL_VECTOR3 = define_c_type({
	C_FLOAT, -- x   // Vector x component
	C_FLOAT, -- y   // Vector y component
	C_FLOAT  -- z   // Vector z component
})

-- Vector4, 4 components
public constant RL_VECTOR4 = define_c_type({
	C_FLOAT, -- x   // Vector x component
	C_FLOAT, -- y   // Vector y component
	C_FLOAT, -- z   // Vector z component
	C_FLOAT  -- w   // Vector w component
})

-- Quaternion, 4 components (Vector4 alias)
public constant RL_QUATERNION = define_c_type( RL_VECTOR4 )

-- Matrix, 4x4 components, column major, OpenGL style, right handed
public constant RL_MATRIX = define_c_type({
	C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT, -- m0, m4, m8, m12,    // Matrix first row (4 components)
	C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT, -- m1, m5, m9, m13,    // Matrix second row (4 components)
	C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT, -- m2, m6, m10, m14,   // Matrix third row (4 components)
	C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT  -- m3, m7, m11, m15    // Matrix fourth row (4 components)
})

-- Color, 4 components, R8G8B8A8 (32bit)
public constant RL_COLOR = define_c_type({
	C_UCHAR, -- r   // Color red value
	C_UCHAR, -- g   // Color green value
	C_UCHAR, -- b   // Color blue value
	C_UCHAR  -- a   // Color alpha value
})

-- Rectangle, 4 components
public constant RL_RECTANGLE = define_c_type({
	C_FLOAT, -- x       // Rectangle top-left corner position x
	C_FLOAT, -- y       // Rectangle top-left corner position y
	C_FLOAT, -- width   // Rectangle width
	C_FLOAT  -- height  // Rectangle height
})

-- Image, pixel data stored in CPU memory (RAM)
public constant RL_IMAGE = define_c_type({
	C_POINTER, -- data      // Image raw data
	C_INT,     -- width     // Image base width
	C_INT,     -- height    // Image base height
	C_INT,     -- mipmaps   // Mipmap levels, 1 by default
	C_INT      -- format    // Data format (PixelFormat type)
})

-- Texture, tex data stored in GPU memory (VRAM)
public constant RL_TEXTURE = define_c_type({
	C_UINT, -- id       // OpenGL texture id
	C_INT,  -- width    // Texture base width
	C_INT,  -- height   // Texture base height
	C_INT,  -- mipmaps  // Mipmap levels, 1 by default
	C_INT   -- format   // Data format (PixelFormat type)
})

-- Texture2D, same as Texture
public constant RL_TEXTURE2D = define_c_type( RL_TEXTURE )

-- TextureCubemap, same as Texture
public constant RL_TEXTURECUBEMAP = define_c_type( RL_TEXTURE )

-- RenderTexture, fbo for texture rendering
public constant RL_RENDERTEXTURE = define_c_type({
	C_UINT,     -- id       // OpenGL framebuffer object id
	RL_TEXTURE, -- texture  // Color buffer attachment texture
	RL_TEXTURE  -- depth    // Depth buffer attachment texture
})

-- RenderTexture2D, same as RenderTexture
public constant RL_RENDERTEXTURE2D = define_c_type( RL_RENDERTEXTURE )

-- NPatchInfo, n-patch layout info
public constant RL_NPATCHINFO = define_c_type({
	RL_RECTANGLE, -- source   // Texture source rectangle
	C_INT,        -- left     // Left border offset
	C_INT,        -- top      // Top border offset
	C_INT,        -- right    // Right border offset
	C_INT,        -- bottom   // Bottom border offset
	C_INT         -- layout   // Layout of the n-patch: 3x3, 1x3 or 3x1
})

-- GlyphInfo, font characters glyphs info
public constant RL_CHARINFO = define_c_type({
	C_INT,   -- value     // Character value (Unicode)
	C_INT,   -- offsetX   // Character offset X when drawing
	C_INT,   -- offsetY   // Character offset Y when drawing
	C_INT,   -- advanceX  // Character advance position X
	RL_IMAGE -- image     // Character image data
})

-- Font, font texture and GlyphInfo array data
public constant RL_FONT = define_c_type({
	C_INT,        -- baseSize       // Base size (default chars height)
	C_INT,        -- glyphCount     // Number of glyph characters
	C_INT,        -- glyphPadding   // Padding around the glyph characters
	RL_TEXTURE2D, -- texture        // Texture atlas containing the glyphs
	C_POINTER,    -- recs           // Rectangles in texture for the glyphs
	C_POINTER     -- glyphs         // Glyphs info data
})

-- Camera, defines position/orientation in 3d space
public constant RL_CAMERA3D = define_c_type({
	RL_VECTOR3, -- position     // Camera position
	RL_VECTOR3, -- target       // Camera target it looks-at
	RL_VECTOR3, -- up           // Camera up vector (rotation over its axis)
	C_FLOAT,    -- fovy         // Camera field-of-view apperture in Y (degrees) in perspective, used as near plane width in orthographic
	C_INT       -- projection   // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
})

-- Camera type fallback, defaults to Camera3D
public constant RL_CAMERA = define_c_type( RL_CAMERA3D )

-- Camera2D, defines position/orientation in 2d space
public constant RL_CAMERA2D = define_c_type({
	RL_VECTOR2, -- offset     // Camera offset (displacement from target)
	RL_VECTOR2, -- target     // Camera target (rotation and zoom origin)
	C_FLOAT,    -- rotation   // Camera rotation in degrees
	C_FLOAT     -- zoom       // Camera zoom (scaling), should be 1.0f by default
})

-- Vertex data definning a mesh
public constant RL_MESH = define_c_type({
	C_INT,     -- vertexCount     // Number of vertices stored in arrays
	C_INT,     -- triangleCount   // Number of triangles stored (indexed or not)
	-- Default vertex data
	C_POINTER, -- vertices        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
	C_POINTER, -- texcoords       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
	C_POINTER, -- texcoords2      // Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
	C_POINTER, -- normals         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
	C_POINTER, -- tangents        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
	C_POINTER, -- colors          // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
	C_POINTER, -- indices         // Vertex indices (in case vertex data comes indexed)
	-- Animation vertex data
	C_POINTER, -- animVertices    // Animated vertex positions (after bones transformations)
	C_POINTER, -- animNormals     // Animated normals (after bones transformations)
	C_POINTER, -- boneIds         // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
	C_POINTER, -- boneWeights     // Vertex bone weight, up to 4 bones influence by vertex (skinning)
	-- OpenGL identifiers
	C_UINT,    -- vaoId           // OpenGL Vertex Array Object id
	C_POINTER  -- vboId           // OpenGL Vertex Buffer Objects id (default vertex data)
})

-- Shader
public constant RL_SHADER = define_c_type({
	C_UINT,   -- id     // Shader program id
	C_POINTER -- locs   // Shader locations array (RL_MAX_SHADER_LOCATIONS)
})

-- MaterialMap
public constant RL_MATERIALMAP = define_c_type({
	RL_TEXTURE2D, -- texture  // Material map texture
	RL_COLOR,     -- color    // Material map color
	C_FLOAT       -- value    // Material map value
})

-- Material, includes shader and maps
public constant RL_MATERIAL = define_c_type({
	RL_SHADER,  -- shader   // Material shader
	C_POINTER,  -- maps     // Material maps array (MAX_MATERIAL_MAPS)
	{C_FLOAT,4} -- params   // Material generic parameters (if required)
})

-- Transform, vectex transformation data
public constant RL_TRANSFORM = define_c_type({
	RL_VECTOR3,    -- translation   // Translation
	RL_QUATERNION, -- rotation      // Rotation
	RL_VECTOR3     -- scale         // Scale
})

-- Bone, skeletal animation bone
public constant RL_BONEINFO = define_c_type({
	{C_CHAR,32}, -- name    // Bone name
	C_INT        -- parent  // Bone parent
})

-- Model, meshes, materials and animation data
public constant RL_MODEL = define_c_type({
	RL_MATRIX, -- transform       // Local transform matrix
	C_INT,     -- meshCount       // Number of meshes
	C_INT,     -- materialCount   // Number of materials
	C_POINTER, -- meshes          // Meshes array
	C_POINTER, -- materials       // Materials array
	C_POINTER, -- meshMaterial    // Mesh material number
	-- Animation data
	C_INT,     -- boneCount       // Number of bones
	C_POINTER, -- bones           // Bones information (skeleton)
	C_POINTER  -- bindPose        // Bones base transformation (pose)
})

-- ModelAnimation
public constant RL_MODELANIMATION = define_c_type({
	C_INT,     -- boneCount   // Number of bones
	C_INT,     -- frameCount  // Number of animation frames
	C_POINTER, -- bones       // Bones information (skeleton)
	C_POINTER  -- framePoses  // Poses array by frame
})

-- Ray, ray for raycasting
public constant RL_RAY = define_c_type({
	RL_VECTOR3, -- position   // Ray position (origin)
	RL_VECTOR3  -- direction  // Ray direction
})

-- RayCollision, ray hit information
public constant RL_RAYCOLLISION = define_c_type({
	C_BOOL,     -- hit        // Did the ray hit something?
	C_FLOAT,    -- distance   // Distance to nearest hit
	RL_VECTOR3, -- point      // Point of nearest hit
	RL_VECTOR3  -- normal     // Surface normal of hit
})

-- BoundingBox
public constant RL_BOUNDINGBOX = define_c_type({
	RL_VECTOR3, -- min  // Minimum vertex box-corner
	RL_VECTOR3  -- max  // Maximum vertex box-corner
})

-- Wave, audio wave data
public constant RL_WAVE = define_c_type({
	C_UINT,   -- frameCount   // Total number of frames (considering channels)
	C_UINT,   -- sampleRate   // Frequency (samples per second)
	C_UINT,   -- sampleSize   // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	C_UINT,   -- channels     // Number of channels (1-mono, 2-stereo, ...)
	C_POINTER -- data         // Buffer data pointer
})

-- AudioStream, custom audio stream
public constant RL_AUDIOSTREAM = define_c_type({
	C_POINTER, -- buffer        // Pointer to internal data used by the audio system
	C_POINTER, -- processor     // Pointer to internal data processor, useful for audio effects
	C_UINT,    -- sampleRate    // Frequency (samples per second)
	C_UINT,    -- sampleSize    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	C_UINT     -- channels      // Number of channels (1-mono, 2-stereo, ...)
})

-- Keyboard keys (US keyboard layout)
-- NOTE: Use GetKeyPressed() to allow redefining
-- required keys for alternative layouts
public enum type KeyboardKey
	KEY_NULL            =   0,  -- Key: NULL, used for no key pressed
	-- Alphanumeric keys
	KEY_APOSTROPHE      =  39,  -- Key: '
	KEY_COMMA           =  44,  -- Key: ,
	KEY_MINUS           =  45,  -- Key: -
	KEY_PERIOD          =  46,  -- Key: .
	KEY_SLASH           =  47,  -- Key: /
	KEY_ZERO            =  48,  -- Key: 0
	KEY_ONE             =  49,  -- Key: 1
	KEY_TWO             =  50,  -- Key: 2
	KEY_THREE           =  51,  -- Key: 3
	KEY_FOUR            =  52,  -- Key: 4
	KEY_FIVE            =  53,  -- Key: 5
	KEY_SIX             =  54,  -- Key: 6
	KEY_SEVEN           =  55,  -- Key: 7
	KEY_EIGHT           =  56,  -- Key: 8
	KEY_NINE            =  57,  -- Key: 9
	KEY_SEMICOLON       =  59,  -- Key: ;
	KEY_EQUAL           =  61,  -- Key: =
	KEY_A               =  65,  -- Key: A | a
	KEY_B               =  66,  -- Key: B | b
	KEY_C               =  67,  -- Key: C | c
	KEY_D               =  68,  -- Key: D | d
	KEY_E               =  69,  -- Key: E | e
	KEY_F               =  70,  -- Key: F | f
	KEY_G               =  71,  -- Key: G | g
	KEY_H               =  72,  -- Key: H | h
	KEY_I               =  73,  -- Key: I | i
	KEY_J               =  74,  -- Key: J | j
	KEY_K               =  75,  -- Key: K | k
	KEY_L               =  76,  -- Key: L | l
	KEY_M               =  77,  -- Key: M | m
	KEY_N               =  78,  -- Key: N | n
	KEY_O               =  79,  -- Key: O | o
	KEY_P               =  80,  -- Key: P | p
	KEY_Q               =  81,  -- Key: Q | q
	KEY_R               =  82,  -- Key: R | r
	KEY_S               =  83,  -- Key: S | s
	KEY_T               =  84,  -- Key: T | t
	KEY_U               =  85,  -- Key: U | u
	KEY_V               =  86,  -- Key: V | v
	KEY_W               =  87,  -- Key: W | w
	KEY_X               =  88,  -- Key: X | x
	KEY_Y               =  89,  -- Key: Y | y
	KEY_Z               =  90,  -- Key: Z | z
	KEY_LEFT_BRACKET    =  91,  -- Key: [
	KEY_BACKSLASH       =  92,  -- Key: '\'
	KEY_RIGHT_BRACKET   =  93,  -- Key: ]
	KEY_GRAVE           =  96,  -- Key: `
	-- Function keys
	KEY_SPACE           =  32,  -- Key: Space
	KEY_ESCAPE          = 256,  -- Key: Esc
	KEY_ENTER           = 257,  -- Key: Enter
	KEY_TAB             = 258,  -- Key: Tab
	KEY_BACKSPACE       = 259,  -- Key: Backspace
	KEY_INSERT          = 260,  -- Key: Ins
	KEY_DELETE          = 261,  -- Key: Del
	KEY_RIGHT           = 262,  -- Key: Cursor right
	KEY_LEFT            = 263,  -- Key: Cursor left
	KEY_DOWN            = 264,  -- Key: Cursor down
	KEY_UP              = 265,  -- Key: Cursor up
	KEY_PAGE_UP         = 266,  -- Key: Page up
	KEY_PAGE_DOWN       = 267,  -- Key: Page down
	KEY_HOME            = 268,  -- Key: Home
	KEY_END             = 269,  -- Key: End
	KEY_CAPS_LOCK       = 280,  -- Key: Caps lock
	KEY_SCROLL_LOCK     = 281,  -- Key: Scroll down
	KEY_NUM_LOCK        = 282,  -- Key: Num lock
	KEY_PRINT_SCREEN    = 283,  -- Key: Print screen
	KEY_PAUSE           = 284,  -- Key: Pause
	KEY_F1              = 290,  -- Key: F1
	KEY_F2              = 291,  -- Key: F2
	KEY_F3              = 292,  -- Key: F3
	KEY_F4              = 293,  -- Key: F4
	KEY_F5              = 294,  -- Key: F5
	KEY_F6              = 295,  -- Key: F6
	KEY_F7              = 296,  -- Key: F7
	KEY_F8              = 297,  -- Key: F8
	KEY_F9              = 298,  -- Key: F9
	KEY_F10             = 299,  -- Key: F10
	KEY_F11             = 300,  -- Key: F11
	KEY_F12             = 301,  -- Key: F12
	KEY_LEFT_SHIFT      = 340,  -- Key: Shift left
	KEY_LEFT_CONTROL    = 341,  -- Key: Control left
	KEY_LEFT_ALT        = 342,  -- Key: Alt left
	KEY_LEFT_SUPER      = 343,  -- Key: Super left
	KEY_RIGHT_SHIFT     = 344,  -- Key: Shift right
	KEY_RIGHT_CONTROL   = 345,  -- Key: Control right
	KEY_RIGHT_ALT       = 346,  -- Key: Alt right
	KEY_RIGHT_SUPER     = 347,  -- Key: Super right
	KEY_KB_MENU         = 348,  -- Key: KB menu
	-- Keypad keys
	KEY_KP_0            = 320,  -- Key: Keypad 0
	KEY_KP_1            = 321,  -- Key: Keypad 1
	KEY_KP_2            = 322,  -- Key: Keypad 2
	KEY_KP_3            = 323,  -- Key: Keypad 3
	KEY_KP_4            = 324,  -- Key: Keypad 4
	KEY_KP_5            = 325,  -- Key: Keypad 5
	KEY_KP_6            = 326,  -- Key: Keypad 6
	KEY_KP_7            = 327,  -- Key: Keypad 7
	KEY_KP_8            = 328,  -- Key: Keypad 8
	KEY_KP_9            = 329,  -- Key: Keypad 9
	KEY_KP_DECIMAL      = 330,  -- Key: Keypad .
	KEY_KP_DIVIDE       = 331,  -- Key: Keypad /
	KEY_KP_MULTIPLY     = 332,  -- Key: Keypad *
	KEY_KP_SUBTRACT     = 333,  -- Key: Keypad -
	KEY_KP_ADD          = 334,  -- Key: Keypad +
	KEY_KP_ENTER        = 335,  -- Key: Keypad Enter
	KEY_KP_EQUAL        = 336   -- Key: Keypad =
end type

-- Mouse buttons
public enum type MouseButton
	MOUSE_BUTTON_LEFT    = 0,   -- Mouse button left
	MOUSE_BUTTON_RIGHT   = 1,   -- Mouse button right
	MOUSE_BUTTON_MIDDLE  = 2,   -- Mouse button middle (pressed wheel)
	MOUSE_BUTTON_SIDE    = 3,   -- Mouse button side (advanced mouse device)
	MOUSE_BUTTON_EXTRA   = 4,   -- Mouse button extra (advanced mouse device)
	MOUSE_BUTTON_FORWARD = 5,   -- Mouse button fordward (advanced mouse device)
	MOUSE_BUTTON_BACK    = 6    -- Mouse button back (advanced mouse device)
end type

-- Camera projection
public enum type CameraProjection
	CAMERA_PERSPECTIVE = 0,   -- Perspective projection
	CAMERA_ORTHOGRAPHIC       -- Orthographic projection
end type

export constant raylib = open_dll( "raylib.dll" ),
	xInitWindow         = define_c_proc( raylib, "+InitWindow", {C_INT,C_INT,C_STRING} ),
	xWindowShouldClose  = define_c_func( raylib, "+WindowShouldClose", {}, C_BOOL ),
	xCloseWindow        = define_c_proc( raylib, "+CloseWindow", {} ),
	xGetWindowPosition  = define_c_func( raylib, "+GetWindowPosition", {}, RL_VECTOR2 ),
	xGetScreenToWorld2D = define_c_func( raylib, "+GetScreenToWorld2D", {RL_VECTOR2,RL_CAMERA2D}, RL_VECTOR2 ),
	xSetTargetFPS       = define_c_proc( raylib, "+SetTargetFPS", {C_INT} ),
	xGetRandomValue     = define_c_func( raylib, "+GetRandomValue", {C_INT,C_INT}, C_INT ),
	xClearBackground    = define_c_proc( raylib, "+ClearBackground", {RL_COLOR} ),
	xBeginDrawing       = define_c_proc( raylib, "+BeginDrawing", {} ),
	xEndDrawing         = define_c_proc( raylib, "+EndDrawing", {} ),
	xBeginMode2D        = define_c_proc( raylib, "+BeginMode2D", {RL_CAMERA2D} ),
	xEndMode2D          = define_c_proc( raylib, "+EndMode2D", {} ),
	xBeginMode3D        = define_c_proc( raylib, "+BeginMode3D", {RL_CAMERA3D} ),
	xEndMode3D          = define_c_proc( raylib, "+EndMode3D", {} ),
	xIsKeyPressed       = define_c_func( raylib, "+IsKeyPressed", {C_INT}, C_BOOL ),
	xIsKeyDown          = define_c_func( raylib, "+IsKeyDown", {C_INT}, C_BOOL ),
	xIsMouseButtonDown  = define_c_func( raylib, "+IsMouseButtonDown", {C_INT}, C_BOOL ),
	xGetMousePosition   = define_c_func( raylib, "+GetMousePosition", {}, RL_VECTOR2 ),
	xGetMouseDelta      = define_c_func( raylib, "+GetMouseDelta", {}, RL_VECTOR2 ),
	xGetMouseWheelMove  = define_c_func( raylib, "+GetMouseWheelMove", {}, C_FLOAT ),
	xDrawLine           = define_c_proc( raylib, "+DrawLine", {C_INT,C_INT,C_INT,C_INT,RL_COLOR} ),
	xDrawCircle         = define_c_proc( raylib, "+DrawCircle", {C_INT,C_INT,C_FLOAT,RL_COLOR} ),
	xDrawRectangle      = define_c_proc( raylib, "+DrawRectangle", {C_INT,C_INT,C_INT,C_INT,RL_COLOR} ),
	xDrawRectangleRec   = define_c_proc( raylib, "+DrawRectangleRec", {RL_RECTANGLE,RL_COLOR} ),
	xDrawRectangleLines = define_c_proc( raylib, "+DrawRectangleLines", {C_INT,C_INT,C_INT,C_INT,RL_COLOR} ),
	xFade               = define_c_func( raylib, "+Fade", {RL_COLOR,C_FLOAT}, RL_COLOR ),
	xDrawFPS            = define_c_proc( raylib, "+DrawFPS", {C_INT,C_INT} ),
	xDrawText           = define_c_proc( raylib, "+DrawText", {C_STRING,C_INT,C_INT,C_INT,RL_COLOR} ),
	xDrawCube           = define_c_proc( raylib, "+DrawCube", {RL_VECTOR3,C_FLOAT,C_FLOAT,C_FLOAT,RL_COLOR} ),
	xDrawCubeWires      = define_c_proc( raylib, "+DrawCubeWires", {RL_VECTOR3,C_FLOAT,C_FLOAT,C_FLOAT,RL_COLOR} ),
	xDrawGrid           = define_c_proc( raylib, "+DrawGrid", {C_INT,C_FLOAT} ),
$

public procedure InitWindow( integer width, integer height, sequence title )
	c_proc( xInitWindow, {width,height,title} ) -- title string is allocated/freed automatically
end procedure

public function WindowShouldClose()
	return c_func( xWindowShouldClose, {} )
end function

public procedure CloseWindow()
	c_proc( xCloseWindow, {} )
end procedure

public function GetWindowPosition()
	return c_func( xGetWindowPosition, {} ) -- returns {x,y}
end function

public function GetScreenToWorld2D( sequence position, sequence camera )
	return c_func( xGetScreenToWorld2D, {position,camera} )
end function

public procedure SetTargetFPS( integer fps )
	c_proc( xSetTargetFPS, {fps} )
end procedure

public function GetRandomValue( integer min, integer max )
	return c_func( xGetRandomValue, {min,max} )
end function

public procedure ClearBackground( sequence color )
	c_proc( xClearBackground, {color} ) -- color is {r,g,b,a}
end procedure

public procedure BeginDrawing()
	c_proc( xBeginDrawing, {} )
end procedure

public procedure EndDrawing()
	c_proc( xEndDrawing, {} )
end procedure

public procedure BeginMode2D( sequence camera )
	c_proc( xBeginMode2D, {camera} )
end procedure

public procedure EndMode2D()
	c_proc( xEndMode2D, {} )
end procedure

public procedure BeginMode3D( sequence camera )
	c_proc( xBeginMode3D, {camera} )
end procedure

public procedure EndMode3D()
	c_proc( xEndMode3D, {} )
end procedure

public function IsKeyPressed( integer key )
	return c_func( xIsKeyPressed, {key} )
end function

public function IsKeyDown( integer key )
	return c_func( xIsKeyDown, {key} )
end function

public function IsMouseButtonDown( integer button )
	return c_func( xIsMouseButtonDown, {button} )
end function

public function GetMousePosition()
	return c_func( xGetMousePosition, {} )
end function

public function GetMouseDelta()
	return c_func( xGetMouseDelta, {} )
end function

public function GetMouseWheelMove()
	return c_func( xGetMouseWheelMove, {} )
end function

public procedure DrawLine( integer startPosX, integer startPosY, integer endPosX, integer endPosY, sequence color )
	c_proc( xDrawLine, {startPosX,startPosY,endPosX,endPosY,color} )
end procedure

public procedure DrawCircle( integer centerX, integer centerY, atom radius, sequence color )
	c_proc( xDrawCircle, {centerX,centerY,radius,color} )
end procedure

public procedure DrawRectangle( integer posX, integer posY, integer width, integer height, sequence color )
	c_proc( xDrawRectangle, {posX,posY,width,height,color} )
end procedure

public procedure DrawRectangleRec( sequence rec, sequence color )
	c_proc( xDrawRectangleRec, {rec,color} )
end procedure

public procedure DrawRectangleLines( integer posX, integer posY, integer width, integer height, sequence color )
	c_proc( xDrawRectangleLines, {posX,posY,width,height,color} )
end procedure

public function Fade( sequence color, atom alpha )
	return c_func( xFade, {color,alpha} )
end function

public procedure DrawFPS( integer posX, integer posY )
	c_proc( xDrawFPS, {posX,posY} )
end procedure

public procedure DrawText( sequence text, integer posX, integer posY, integer fontSize, sequence color )
	c_proc( xDrawText, {text,posX,posY,fontSize,color} )
end procedure

public procedure DrawCube( sequence position, atom width, atom height, atom length, sequence color )
	c_proc( xDrawCube, {position,width,height,length,color} )
end procedure

public procedure DrawCubeWires( sequence position, atom width, atom height, atom length, sequence color )
	c_proc( xDrawCubeWires, {position,width,height,length,color} )
end procedure

public procedure DrawGrid( integer slices, atom spacing )
	c_proc( xDrawGrid, {slices,spacing} )
end procedure

