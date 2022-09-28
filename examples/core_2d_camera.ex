/*******************************************************************************************
*
*   raylib [core] example - 2d camera
*
*   Example originally created with raylib 1.5, last time updated with raylib 3.0
*
*   Example licensed under an unmodified zlib/libpng license, which is an OSI-certified,
*   BSD-like license that allows static linking with closed source software
*
*   Copyright (c) 2016-2022 Ramon Santamaria (@raysan5)
*
********************************************************************************************/

include raylib.e

constant MAX_BUILDINGS = 100

--------------------------------------------------------------------------------------
-- Program main entry point
--------------------------------------------------------------------------------------
procedure main()

	-- Initialization
	----------------------------------------------------------------------------------------
	integer screenWidth = 800
	integer screenHeight = 450

	InitWindow( screenWidth, screenHeight, "raylib [core] example - 2d camera" )

	sequence player = { 400, 280, 40, 40 }
	sequence buildings = repeat( 0, MAX_BUILDINGS )
	sequence buildColors = repeat( 0, MAX_BUILDINGS )

	integer spacing = 0

	for i = 1 to MAX_BUILDINGS do

		buildings[i] = { 0, 0, 0, 0 }                            -- Rectangle
		buildings[i][1] = GetRandomValue( 50, 200 )              -- .width
		buildings[i][2] = GetRandomValue( 100, 800 )             -- .height
		buildings[i][3] = screenHeight - 130.0 - buildings[i][2] -- .x
		buildings[i][4] = -6000.0 + spacing                      -- .y

		spacing += buildings[i][1] -- .width

		buildColors[i] = { GetRandomValue(200, 240), GetRandomValue(200, 240), GetRandomValue(200, 250), 255 }

	end for

	sequence camera = { 0, 0, 0, 0 }                   -- Camera2D
	camera[1] = { player[1] + 20.0, player[2] + 20.0 } -- .target
	camera[2] = { screenWidth/2.0, screenHeight/2.0 }  -- .offset
	camera[3] = 0.0                                    -- .rotation
	camera[4] = 1.0                                    -- .zoom

	SetTargetFPS(60)                   -- Set our game to run at 60 frames-per-second
	----------------------------------------------------------------------------------------

	-- Main game loop
	while not WindowShouldClose() do        -- Detect window close button or ESC key

		-- Update
		------------------------------------------------------------------------------------
		-- Player movement
		if IsKeyDown( KEY_RIGHT ) then
			player[1] += 2 -- .x
		elsif IsKeyDown( KEY_LEFT ) then
			player[1] -= 2 -- .x
		end if

		-- Camera target follows player
		camera[1] = { player[1] + 20, player[2] + 20 } -- .target

		-- Camera rotation controls
		if IsKeyDown( KEY_A ) then
			camera[3] -= 1 -- .rotation
		elsif IsKeyDown( KEY_S ) then
			camera[3] += 1 -- .rotation
		end if

		-- Limit camera rotation to 80 degrees (-40 to 40)
		if camera[3] > 40 then 
			camera[3] = 40 -- .rotation
		elsif camera[3] < -40 then
			camera[3] = -40 -- .rotation
		end if

		-- Camera zoom controls
		camera[4] += GetMouseWheelMove() * 0.05 -- .zoom

		if camera[4] > 3.0 then
			camera[4] = 3.0 -- .zoom
		elsif camera[4] < 0.1 then
			camera[4] = 0.1 -- .zoom
		end if

		-- Camera reset (zoom and rotation)
		if IsKeyPressed( KEY_R ) then
			camera[3] = 0.0 -- .rotation
			camera[4] = 1.0 -- .zoom
		end if
		------------------------------------------------------------------------------------

		-- Draw
		------------------------------------------------------------------------------------
		BeginDrawing()

			ClearBackground( RAYWHITE )

			BeginMode2D( camera )

				DrawRectangle( -6000, 320, 13000, 8000, DARKGRAY )

				for i = 1 to MAX_BUILDINGS do
					DrawRectangleRec( buildings[i], buildColors[i] )
				end for

				DrawRectangleRec( player, RED )

				DrawLine( floor(camera[1][1]), -screenHeight*10, floor(camera[1][1]), screenHeight*10, GREEN )
				DrawLine( -screenWidth*10, floor(camera[1][2]), screenWidth*10, floor(camera[1][2]), GREEN )

			EndMode2D()

			DrawText( "SCREEN AREA", 640, 10, 20, RED )

			DrawRectangle( 0, 0, screenWidth, 5, RED )
			DrawRectangle( 0, 5, 5, screenHeight-10, RED )
			DrawRectangle( screenWidth-5, 5, 5, screenHeight-10, RED )
			DrawRectangle( 0, screenHeight-5, screenWidth, 5, RED )

			DrawRectangle( 10, 10, 250, 113, Fade(SKYBLUE, 0.5) )
			DrawRectangleLines( 10, 10, 250, 113, BLUE )

			DrawText( "Free 2d camera controls:", 20, 20, 10, BLACK )
			DrawText( "- Right/Left to move Offset", 40, 40, 10, DARKGRAY )
			DrawText( "- Mouse Wheel to Zoom in-out", 40, 60, 10, DARKGRAY )
			DrawText( "- A / S to Rotate", 40, 80, 10, DARKGRAY )
			DrawText( "- R to reset Zoom and Rotation", 40, 100, 10, DARKGRAY )

		EndDrawing()
		------------------------------------------------------------------------------------
	end while

	-- De-Initialization
	----------------------------------------------------------------------------------------
	CloseWindow()        -- Close window and OpenGL context
	----------------------------------------------------------------------------------------

end procedure

main()
