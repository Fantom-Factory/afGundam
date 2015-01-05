using gfx::Graphics
using gfx::Size

@Js
class GunSight : Sprite2D {

	private static const Int 	minThrust	:= -3 * SPEED_COEFF
	private static const Int 	maxThrust	:=  3 * SPEED_COEFF
	private static const Range 	thrustRange	:=  minThrust..maxThrust
	
	private Int pause := 900
	
	private Random random := Random()

	new make() : super(167, 167) { 
		image 	= Ioc.images.gunSight
		coor.x 	= 52
		coor.y 	= 10
		coor.clipStrategy = CoorClipStrategy.insideScreen
		spriteTypes.add(SpriteType.alien)
	}
	
	override Void move() {
		if (pause >= 0)
			pause--
		
		if (pause == 0)
			speed.thrust(8 * SPEED_COEFF, 0)

		if (pause < 0) {
			Int thrustX := 0
			Int thrustY := 0
			
			if (random.nextBool(30)) 
				thrustX = random.nextInt(thrustRange)

			if (random.nextBool(30)) 
				thrustY = random.nextInt(thrustRange)
			
			speed.thrust(thrustX, thrustY)
		}
		
		super.move
	}
}
