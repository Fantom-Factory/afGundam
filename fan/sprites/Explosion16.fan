
@Js
class Explosion16 : Sprite2D {

	new makeAt(Coordinate centreCoor, Coordinate speeds) : super.make(16, 16) {
		image 	= Ioc.images.explosion16
		coor.x 	= centreCoor.x - (size.w / 2)
		coor.y 	= centreCoor.y - (size.h / 2)
		speed.x	= speeds.x
		speed.y	= speeds.y
		speed.friction = false
		spriteTypes.add(SpriteType.explosion)
		
		spriteSheet.frameLoopFunc = |->| {
			dead = true
		}
	}
}
