/*******************************************************************************************
*
*   raylib [core] example - 2d camera mouse zoom
*
*   Example originally created with raylib 4.2, last time updated with raylib 4.2
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2022 Jeffery Myers (@JeffM2501)
*
********************************************************************************************/

include raylib.e

include rlgl.e
include raymath.e

--------------------------------------------------------------------------------------
-- Program main entry point
--------------------------------------------------------------------------------------
procedure  main()

	-- Initialization
	----------------------------------------------------------------------------------------
	integer screenWidth = 800
	integer screenHeight = 450

	InitWindow( screenWidth, screenHeight, "raylib [core] example - 2d camera mouse zoom" )

	sequence camera = {0,0,0,0} -- Camera2D
	camera[1] = {0,0}           -- .target
	camera[2] = {0,0}           -- .offset
	camera[3] = 0.0             -- .rotation
	camera[4] = 1.0             -- .zoom

	SetTargetFPS( 60 )                   -- Set our game to run at 60 frames-per-second
	----------------------------------------------------------------------------------------

	-- Main game loop
	while not WindowShouldClose() do        -- Detect window close button or ESC key

		-- Update
		------------------------------------------------------------------------------------
		-- Translate based on mouse right click
		if IsMouseButtonDown( MOUSE_BUTTON_RIGHT ) then

			sequence delta = GetMouseDelta()
			delta = Vector2Scale( delta, -1.0/camera[4] ) -- .zoom

			camera[1] = Vector2Add( camera[1], delta )    -- .target

		end if

		-- Zoom based on mouse wheel
		atom wheel = GetMouseWheelMove()

		if wheel != 0 then

			-- Get the world point that is under the mouse
			sequence mouseWorldPos = GetScreenToWorld2D( GetMousePosition(), camera )

			-- Set the offset to where the mouse is
			camera[2] = GetMousePosition() -- .offset

			-- Set the target to match, so that the camera maps the world space point 
			-- under the cursor to the screen space point under the cursor at any zoom
			camera[1] = mouseWorldPos -- .target

			-- Zoom increment
			atom zoomIncrement = 0.125

			camera[4] += wheel * zoomIncrement -- .zoom

			if camera[4] < zoomIncrement then
				camera[4] = zoomIncrement -- .zoom
			end if

		end if
		------------------------------------------------------------------------------------

		-- Draw
		------------------------------------------------------------------------------------
		BeginDrawing()
			ClearBackground( BLACK )

			BeginMode2D( camera )

				-- Draw the 3d grid, rotated 90 degrees and centered around 0,0 
				-- just so we have something in the XY plane
				rlPushMatrix()
					rlTranslatef( 0, 25*50, 0 )
					rlRotatef( 90, 1, 0, 0 )
					DrawGrid( 100, 50 )
				rlPopMatrix()

				-- Draw a reference circle
				DrawCircle( 100, 100, 50, YELLOW )
				
			EndMode2D()

			DrawText( "Mouse right button drag to move, mouse wheel to zoom", 10, 10, 20, WHITE )

		EndDrawing()
		------------------------------------------------------------------------------------
	end while

	-- De-Initialization
	----------------------------------------------------------------------------------------
	CloseWindow()        -- Close window and OpenGL context
	----------------------------------------------------------------------------------------

end procedure

main()
