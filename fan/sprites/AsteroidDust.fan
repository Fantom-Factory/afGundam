
@Js @NoDoc
class AsteroidDust : Sprite2D {
	
	new makeAt(Coordinate centreCoor, Coordinate speeds) : super.make(4, 4) {
		image 	= Ioc.images.asteroidDust
		coor.x 	= centreCoor.x - (size.w / 2)
		coor.y 	= centreCoor.y - (size.h / 2)
		speed.x	= speeds.x
		speed.y	= speeds.y
		speed.friction =  false
		spriteTypes.add(SpriteType.explosion)
		
		spriteSheet.frameLoopFunc = |->| {
			dead = true
		}
	}
}
