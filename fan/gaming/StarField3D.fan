using gfx

@Js @NoDoc
class StarField3D {
	
//	static const Int noOfStars := Runtime.isJs ? 30 : 300
	static const Int noOfStars := 300
	
	private Star3D[] stars
	
	new make(Size size) {
		stars = List.makeObj(noOfStars)
		(1..noOfStars).each { 
			stars.add(Star3D(size))
		}
	}
	
	Void move() {
		stars.each |star| {
			star.move
		}
	}

	Void draw(Gfx g) {
		stars.each |star| {
			star.draw(g)
		}
	}
}

@Js @NoDoc
internal class Star3D {
	
//	static	const Color[] COLOURS	:= [Color.makeArgb(20, 65, 79, 155), Color.makeArgb(20, 129, 139, 192), Color.makeArgb(20, 192, 202, 245)]
	static	const Color[] COLOURS	:= [Color.makeRgb(65, 79, 155), Color.makeRgb(129, 139, 192), Color.makeRgb(192, 202, 245)]
	static 	const Int SPEED			:= -10 
	static 	const Int PERSPECTIVE	:= 300
	
	private	const Point centre
	private	const Int fieldDepth
	
	Int x
	Int y
	Int z
	Int speed
	Bool onScreen	:= true
	
	new make(Size size) {
		this.centre 	= Point(size.w / 2, size.h / 2)
		this.fieldDepth = (size.w + size.h) / 2
		this.x 			= (-fieldDepth..fieldDepth).random
		this.y 			= (-fieldDepth..fieldDepth).random
		this.z 			= (-(fieldDepth*2)..fieldDepth).random
	}

	Void move() {
		z += SPEED
		if (z < -(fieldDepth * 3))
			onScreen = false
		
		if (!onScreen) {
			z = fieldDepth

			// Randomise new coordinates
			x = (-fieldDepth..fieldDepth).random
			y = (-fieldDepth..fieldDepth).random

			onScreen = true
		}
	}
	
	Void draw(Gfx g) {
		// ensure the Z coor is positive
		intZ := z + (fieldDepth * 3)

		// If a star has travelled too far forward then it's Z coor may be negative
		if (intZ <= 0) {
			onScreen = false
			intZ = 1
		}

		intX := x * PERSPECTIVE / intZ
		intY := y * PERSPECTIVE / intZ

		if (intX.abs > centre.x)
			onScreen = false
		if (intY.abs > centre.y)
			onScreen = false
		
		if (onScreen) {
			Int zoom := 0
			if (z <  0)
				zoom++
			if (z < -fieldDepth)
				zoom++
			
			g.brush = COLOURS[zoom]
			g.drawRect(centre.x + intX, centre.y + intY, 1, 1)
		}
	}	
}

