/**********************************************************************************************
*
*   raymath v1.5 - Math functions to work with Vector2, Vector3, Matrix and Quaternions
*
*   NOTICE: This is an incomplete Raylib wrapper for demonstrating libffi in Euphoria.
*
**********************************************************************************************/

public function Vector2Add( sequence v1, sequence v2 )

--	Vector2 result = { v1.x + v2.x, v1.y + v2.y };

	return v1 + v2
end function

public function Vector2Scale( sequence v, atom scale )

--	Vector2 result = { v.x*scale, v.y*scale };

	return v * scale
end function

