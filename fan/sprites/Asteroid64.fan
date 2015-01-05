
@Js @NoDoc
class Asteroid64 : AbsAsteroid {

	new makeExploding(Coordinate centreCoor, Coordinate speeds) : this.makeAt(centreCoor.x, centreCoor.y) {
		coor.x 	= centreCoor.x - (size.w / 2)
		coor.y 	= centreCoor.y - (size.h / 2)
		speed.x = speeds.x
		speed.y = speeds.y
		hitCountdown = 20		
	}
	
	new makeAt(Int x, Int y) : super.makeAt(x, y, 64, 64) {
		image 			= Ioc.images.asteroid64
		speed.x			= (Sprite2D.SPEED_COEFF * -1.5f).toInt
		speed.defaultX	= (Sprite2D.SPEED_COEFF * -1.5f).toInt
		spriteSheet.setRandomFrameIndex
		nrg				= 40
		mass 			= 80
		
		// Gawd it was DULL working these numbers out!
		addCollisionRect( 0, Rect2(27,  8, 15, 52))
		addCollisionRect( 0, Rect2(20, 11, 35, 23))
		addCollisionRect( 0, Rect2( 8, 21, 43, 23))
		addCollisionRect( 0, Rect2(18, 12, 28, 43))
		addCollisionRect( 1, Rect2(25,  8, 17, 52))
		addCollisionRect( 1, Rect2(12, 15, 45, 14))
		addCollisionRect( 1, Rect2(18, 11, 28, 43))
		addCollisionRect( 1, Rect2(12, 15, 40, 30))
		addCollisionRect( 2, Rect2(25,  8, 18, 51))
		addCollisionRect( 2, Rect2(14, 16, 42, 18))
		addCollisionRect( 2, Rect2(19, 11, 29, 42))
		addCollisionRect( 3, Rect2(25,  7, 18, 54))
		addCollisionRect( 3, Rect2(16, 21, 40, 22))
		addCollisionRect( 3, Rect2(19, 10, 31, 42))
		addCollisionRect( 4, Rect2(25,  6, 19, 55))
		addCollisionRect( 4, Rect2(16, 23, 43, 18))
		addCollisionRect( 4, Rect2(23,  7, 29, 44))
		addCollisionRect( 5, Rect2(15, 20, 45, 20))
		addCollisionRect( 5, Rect2(27,  5, 20, 54))
		addCollisionRect( 5, Rect2(23,  8, 30, 43))
		addCollisionRect( 6, Rect2(29,  4, 21, 53))
		addCollisionRect( 6, Rect2(18, 13, 43, 26))
		addCollisionRect( 6, Rect2(14, 20, 42, 26))
		addCollisionRect( 7, Rect2(10, 26, 49, 19))
		addCollisionRect( 7, Rect2(17, 14, 49, 19))
		addCollisionRect( 7, Rect2(26,  7, 28, 47))
		addCollisionRect( 8, Rect2(30,  4, 23, 51))
		addCollisionRect( 8, Rect2( 7, 31, 51, 14))
		addCollisionRect( 8, Rect2(15, 16, 41, 34))
		addCollisionRect( 9, Rect2(29,  5, 27, 48))
		addCollisionRect( 9, Rect2(15, 15, 43, 34))
		addCollisionRect( 9, Rect2( 6, 30, 53, 15))
		addCollisionRect(10, Rect2(32,  5, 18, 48))
		addCollisionRect(10, Rect2( 5, 30, 54, 17))
		addCollisionRect(10, Rect2(15, 15, 43, 36))
		addCollisionRect(11, Rect2(27,  7, 21, 45))
		addCollisionRect(11, Rect2( 4, 32, 55, 16))
		addCollisionRect(11, Rect2(15, 15, 41, 36))
		addCollisionRect(12, Rect2(24,  9, 23, 43))
		addCollisionRect(12, Rect2( 8, 26, 51, 23))
		addCollisionRect(12, Rect2(15, 15, 38, 36))
		addCollisionRect(13, Rect2(22, 11, 21, 41))
		addCollisionRect(13, Rect2( 8, 27, 50, 20))
		addCollisionRect(13, Rect2(14, 16, 36, 34))
		addCollisionRect(14, Rect2(17, 13, 25, 39))
		addCollisionRect(14, Rect2( 8, 31, 53, 15))
		addCollisionRect(14, Rect2(12, 18, 37, 32))
		addCollisionRect(15, Rect2(18, 12, 18, 40))
		addCollisionRect(15, Rect2(10, 32, 51, 13))
		addCollisionRect(15, Rect2(13, 19, 35, 32))
		addCollisionRect(16, Rect2(18, 12, 18, 41))
		addCollisionRect(16, Rect2( 8, 23, 44, 18))
		addCollisionRect(16, Rect2(14, 30, 45, 17))
		addCollisionRect(17, Rect2(17, 13, 28, 42))
		addCollisionRect(17, Rect2( 5, 25, 51, 16))
		addCollisionRect(17, Rect2(12, 18, 39, 32))
		addCollisionRect(18, Rect2(20, 11, 29, 44))
		addCollisionRect(18, Rect2( 5, 23, 52, 20))
		addCollisionRect(18, Rect2(12, 17, 38, 37))
		addCollisionRect(19, Rect2( 5, 22, 48, 28))
		addCollisionRect(19, Rect2( 9, 19, 40, 36))
		addCollisionRect(19, Rect2(22, 10, 32, 29))
		addCollisionRect(20, Rect2( 2, 24, 53, 20))
		addCollisionRect(20, Rect2(28,  8, 26, 38))
		addCollisionRect(20, Rect2(14, 16, 32, 41))
		addCollisionRect(21, Rect2( 3, 22, 48, 25))
		addCollisionRect(21, Rect2(26,  8, 28, 28))
		addCollisionRect(21, Rect2(19, 12, 27, 45))
		addCollisionRect(22, Rect2(25,  8, 30, 24))
		addCollisionRect(22, Rect2( 3, 24, 47, 23))
		addCollisionRect(22, Rect2(21, 11, 24, 46))
		addCollisionRect(23, Rect2( 6, 21, 44, 26))
		addCollisionRect(23, Rect2(22, 10, 34, 20))
		addCollisionRect(23, Rect2(23, 10, 21, 48))
	}
	
	override Void explode(Speed exploSpeed) {
		score := ScoreSheet.asteroid64Hit
		Ioc.scoreSheet.add(score)
	}
	
	override Void destroyed(Speed exploSpeed)  {
		score := ScoreSheet.asteroid64Destroyed
		Ioc.scoreSheet.add(score)
		Ioc.sprites.add(Label8.makeAt(coor.centre, score))
		Ioc.sprites.add(Explosion64.makeAt(coor.centre, exploSpeed))
		
		// when we die, generate some smaller asteroids, we're not quite dead yet!
		random := Int.random(20..45)
		Ioc.sprites.add(Asteroid32.makeExploding(coor.centre.offset(-16,   0), exploSpeed.offset(-random, 0)))
		Ioc.sprites.add(Asteroid32.makeExploding(coor.centre.offset( 16, -16), exploSpeed.offset( random, -random)))
		Ioc.sprites.add(Asteroid32.makeExploding(coor.centre.offset( 16,  16), exploSpeed.offset( random,  random)))
	}		
}
