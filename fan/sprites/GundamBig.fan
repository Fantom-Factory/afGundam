
@Js @NoDoc
class GundamBig : Sprite2D {
	
	private Int angle
	
	new make() : super(276, 348) { 
		image 	= Ioc.images.gundamBig
		spriteTypes.add(SpriteType.player)
	}
	
	override Void move() {	
		angle += 3
		if (angle >= 360) 
			angle -= 360

		sin := (Sin.sin(angle) * 20).toInt

		x :=   Ioc.gameWindow.size.w - size.w - 20
		y := ((Ioc.gameWindow.size.h - size.h) / 2) + sin + 30
		
		coor.x = x
		coor.y = y
	}
}
