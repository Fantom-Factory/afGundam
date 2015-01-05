using gfx

@Js
const class Point2 : Coordinate {
	
	** Default instance is 0, 0.
	const static Point2 defVal := Point2(0, 0)
	
	const override Int x
	const override Int y
	
	new make(Int x, Int y) {
		this.x = x; this.y = y
	}
	
	override Int hash() {
		x.xor(y.shiftl(16)) 
	}

	override Bool equals(Obj? obj) {
	    that := obj as Point
	    if (that == null) return false
	    return this.x == that.x && this.y == that.y
    }

    override Str toStr() { 
		"$x,$y" 
    }
	
	// ---- My Methods --------------------------------------------------------

	override This offset(Int x, Int y) {
		Point2(this.x  + x, this.y + y)
	}
	
	override This translate(Coordinate t) { 
		Point2(x + t.x, y + t.y) 
	}
	
}
