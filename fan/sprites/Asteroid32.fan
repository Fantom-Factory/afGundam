
@Js @NoDoc
class Asteroid32 : AbsAsteroid {

	new makeExploding(Coordinate centreCoor, Coordinate speeds) : this.makeAt(centreCoor.x, centreCoor.y) {
		coor.x 	= centreCoor.x - (size.w / 2)
		coor.y 	= centreCoor.y - (size.h / 2)
		speed.x = speeds.x
		speed.y = speeds.y
		hitCountdown = 20
	}
	
	new makeAt(Int x, Int y) : super.makeAt(x, y, 32, 32) {
		image 			= Ioc.images.asteroid32
		speed.x			= Sprite2D.SPEED_COEFF * -2
		speed.defaultX	= Sprite2D.SPEED_COEFF * -2
		spriteSheet.setRandomFrameIndex
		nrg				= 15
		mass 			= 50
		
		// Gawd it was DULL working these numbers out!
		addCollisionRect( 0, Rect2( 5,  7, 22, 17))
		addCollisionRect( 0, Rect2(14,  3,  9, 25))
		addCollisionRect( 1, Rect2( 4,  8, 24, 13))
		addCollisionRect( 1, Rect2(14,  4, 12, 26))
		addCollisionRect( 2, Rect2(11,  3, 13, 28))
		addCollisionRect( 2, Rect2( 5,  7, 24, 14))
		addCollisionRect( 3, Rect2( 5,  8, 24, 14))
		addCollisionRect( 3, Rect2(13,  2,  9, 28))
		addCollisionRect( 4, Rect2( 7,  5, 12, 25))
		addCollisionRect( 4, Rect2( 7,  6, 20, 20))
		addCollisionRect( 5, Rect2( 3, 13, 24, 14))
		addCollisionRect( 5, Rect2( 8,  6, 20, 20))
		addCollisionRect( 6, Rect2( 2, 10, 25, 15))
		addCollisionRect( 6, Rect2( 8,  6, 20, 18))
		addCollisionRect( 7, Rect2( 2, 10, 28, 12))
		addCollisionRect( 7, Rect2( 5,  5, 20, 20))
		addCollisionRect( 7, Rect2(12,  4,  9, 27))
		addCollisionRect( 8, Rect2( 4,  6, 24, 17))
		addCollisionRect( 8, Rect2( 9,  3,  9, 28))
		addCollisionRect( 9, Rect2( 6,  3, 14, 26))
		addCollisionRect( 9, Rect2( 4,  6, 24, 19))
		addCollisionRect(10, Rect2( 4,  9, 24, 16))
		addCollisionRect(10, Rect2( 8,  2, 14, 28))
		addCollisionRect(11, Rect2( 3, 11, 25, 13))
		addCollisionRect(11, Rect2(12,  1, 10, 29))
		addCollisionRect(12, Rect2(10,  4,  9, 27))
		addCollisionRect(12, Rect2( 3,  9, 24, 17))
		addCollisionRect(13, Rect2( 3,  8, 25, 15))
		addCollisionRect(13, Rect2( 7,  5, 15, 24))
		addCollisionRect(14, Rect2( 3,  9, 28, 14))
		addCollisionRect(14, Rect2( 8,  4, 16, 23))
		addCollisionRect(15, Rect2( 8,  5, 17, 22))
		addCollisionRect(15, Rect2( 3, 10, 27, 14))
	}
	
	override Void explode(Speed exploSpeed) {
		score := ScoreSheet.asteroid32Hit
		Ioc.scoreSheet.add(score)
	}
	
	override Void destroyed(Speed exploSpeed)  {
		score := ScoreSheet.asteroid32Destroyed
		Ioc.scoreSheet.add(score)
		Ioc.sprites.add(Label8.makeAt(coor.centre, score))
		Ioc.sprites.add(Explosion32.makeAt(coor.centre, exploSpeed))
	}	
}
