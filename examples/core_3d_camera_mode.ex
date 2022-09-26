/*******************************************************************************************
*
*   raylib [core] example - Initialize 3d camera mode
*
*   Example originally created with raylib 1.0, last time updated with raylib 1.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2014-2022 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

include raylib.e

--------------------------------------------------------------------------------------
-- Program main entry point
--------------------------------------------------------------------------------------
procedure main()

	-- Initialization
	----------------------------------------------------------------------------------------
	integer screenWidth = 800
	integer screenHeight = 450

	InitWindow( screenWidth, screenHeight, "raylib [core] example - 3d camera mode" )

	-- Define the camera to look into our 3d world
	sequence camera = {
		{ 0.0, 10.0, 10.0 }, -- position   // Camera position
		{ 0.0,  0.0,  0.0 }, -- target     // Camera looking at point
		{ 0.0,  1.0,  0.0 }, -- up         // Camera up vector (rotation towards target)
		45.0,                -- fovy       // Camera field-of-view Y
		CAMERA_PERSPECTIVE   -- projection // Camera mode type
	}

	sequence cubePosition = { 0.0, 0.0, 0.0 }

	SetTargetFPS( 60 )               -- Set our game to run at 60 frames-per-second
	----------------------------------------------------------------------------------------

	-- Main game loop
	while not WindowShouldClose() do    -- Detect window close button or ESC key

		-- Update
		------------------------------------------------------------------------------------
		-- TODO: Update your variables here
		------------------------------------------------------------------------------------

		-- Draw
		------------------------------------------------------------------------------------
		BeginDrawing()

			ClearBackground( RAYWHITE )

			BeginMode3D( camera )

				DrawCube( cubePosition, 2.0, 2.0, 2.0, RED )
				DrawCubeWires( cubePosition, 2.0, 2.0, 2.0, MAROON )

				DrawGrid( 10, 1.0 )

			EndMode3D()

			DrawText( "Welcome to the third dimension!", 10, 40, 20, DARKGRAY )

			DrawFPS( 10, 10 )

		EndDrawing()
		------------------------------------------------------------------------------------
	end while

	-- De-Initialization
	----------------------------------------------------------------------------------------
	CloseWindow()        -- Close window and OpenGL context
	----------------------------------------------------------------------------------------

end procedure

main()
