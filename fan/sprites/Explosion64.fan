
@Js @NoDoc
class Explosion64 : Sprite2D {

	new make(Int x, Int y) : super.make(64, 64) {
		image 	= Ioc.images.explosion64
		coor.x 	= x
		coor.y 	= y
		spriteTypes.add(SpriteType.explosion)
		spriteSheet.frameLoopFunc = |->| {
			dead = true
		}
	}
	
	new makeAt(Coordinate centreCoor, Coordinate speeds) : super.make(64, 64) {
		image 	= Ioc.images.explosion64
		coor.x 	= centreCoor.x - (size.w / 2)
		coor.y 	= centreCoor.y - (size.h / 2)
		speed.x	= speeds.x
		speed.y	= speeds.y
		spriteTypes.add(SpriteType.explosion)
		spriteSheet.frameLoopFunc = |->| {
			dead = true
		}
	}
}
