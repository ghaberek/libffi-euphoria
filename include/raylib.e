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

-- Camera projection
public enum type CameraProjection
	CAMERA_PERSPECTIVE = 0,   -- Perspective projection
	CAMERA_ORTHOGRAPHIC       -- Orthographic projection
end type

constant raylib = open_dll( "raylib.dll" ),
	xInitWindow        = define_c_proc( raylib, "+InitWindow", {C_INT,C_INT,C_STRING} ),
	xWindowShouldClose = define_c_func( raylib, "+WindowShouldClose", {}, C_BOOL ),
	xCloseWindow       = define_c_proc( raylib, "+CloseWindow", {} ),
	xGetWindowPosition = define_c_func( raylib, "+GetWindowPosition", {}, RL_VECTOR2 ),
	xSetTargetFPS      = define_c_proc( raylib, "+SetTargetFPS", {C_INT} ),
	xClearBackground   = define_c_proc( raylib, "+ClearBackground", {RL_COLOR} ),
	xBeginDrawing      = define_c_proc( raylib, "+BeginDrawing", {} ),
	xEndDrawing        = define_c_proc( raylib, "+EndDrawing", {} ),
	xBeginMode3D       = define_c_proc( raylib, "+BeginMode3D", {RL_CAMERA3D} ),
	xEndMode3D         = define_c_proc( raylib, "+EndMode3D", {} ),
	xDrawFPS           = define_c_proc( raylib, "+DrawFPS", {C_INT,C_INT} ),
	xDrawText          = define_c_proc( raylib, "+DrawText", {C_STRING,C_INT,C_INT,C_INT,RL_COLOR} ),
	xDrawCube          = define_c_proc( raylib, "+DrawCube", {RL_VECTOR3,C_FLOAT,C_FLOAT,C_FLOAT,RL_COLOR} ),
	xDrawCubeWires     = define_c_proc( raylib, "+DrawCubeWires", {RL_VECTOR3,C_FLOAT,C_FLOAT,C_FLOAT,RL_COLOR} ),
	xDrawGrid          = define_c_proc( raylib, "+DrawGrid", {C_INT,C_FLOAT} ),
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

public procedure SetTargetFPS( integer fps )
	c_proc( xSetTargetFPS, {fps} )
end procedure

public procedure ClearBackground( sequence color )
	c_proc( xClearBackground, {color} ) -- color is {r,g,b,a}
end procedure

public procedure BeginDrawing()
	c_proc( xBeginDrawing, {} )
end procedure

public procedure EndDrawing()
	c_proc( xEndDrawing, {} )
end procedure

public procedure BeginMode3D( sequence camera )
	c_proc( xBeginMode3D, {camera} )
end procedure

public procedure EndMode3D()
	c_proc( xEndMode3D, {} )
end procedure

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

