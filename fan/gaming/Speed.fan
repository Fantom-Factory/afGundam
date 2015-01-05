
@Js @NoDoc
class Speed : Coordinate {

	Int minSpeed	:= -10 * Sprite2D.SPEED_COEFF
	Int maxSpeed	:=  10 * Sprite2D.SPEED_COEFF

	Int defaultX	:= 0
	Int defaultY	:= 0
	
	Bool friction 	:= true
	Bool frictionY 	:= true	// fudge for SpikyPod
	
	override Int x := 0 {
		set { setX(it) }
	}
	
	override Int y := 0 {
		set { setY(it) }
	}
	
	new make() {}
	
	new makeWith(Int speedX, Int speedY) {
		x = speedX
		y = speedY
	}
	
	Void thrust(Int thrustX, Int thrustY) {
		x += thrustX
		y += thrustY
	}

	Void thrustX(Int thrustX) {
		x += thrustX
	}
	
	Void thrustY(Int thrustY) {
		y += thrustY
	}
	
	Void dampen() {
		if (!friction)
			return
		
		if (x > defaultX) &x--
		if (x < defaultX) &x++

		if (frictionY) {
			if (y > defaultY) &y--
			if (y < defaultY) &y++			
		}
	}
	
	override This offset(Int x, Int y) {
		Speed.makeWith(this.x + x, this.y + y)
	}
	
	override This translate(Coordinate t) { 
		Speed.makeWith(x + t.x, y + t.y) 
	}
	
	private Void setX(Int val) {
		&x = val 
		if (val > maxSpeed)
			&x = maxSpeed
		if (val < minSpeed)
			&x = minSpeed
	}
	
	private Void setY(Int val) {
		&y = val 
		if (val > maxSpeed)
			&y = maxSpeed
		if (val < minSpeed)
			&y = minSpeed	
	}	
}
