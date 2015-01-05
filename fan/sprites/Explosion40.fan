
@Js @NoDoc
class Explosion40 : Sprite2D {

	new makeAt(Coordinate centreCoor, Coordinate speeds) : super.make(40, 40) {
		image 	= Ioc.images.explosion40
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
