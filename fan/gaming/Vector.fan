//using [java] java.lang::Math
using gfx

@Js @NoDoc
@Serializable { simple = true }
const class Vector : Coordinate {

	const override Int x
	const override Int y

	new make(Int x, Int y) {
		this.x = x
		this.y = y
	}
	
	new makeFromPolar(Int angle, Int scalar) {
		x =  scalar * Sin.sin(angle).toInt
		y = -scalar * Sin.cos(angle).toInt
	}
	
	@Operator
	This plus(Vector p) {
		return Vector.make(
			this.x + p.x, 
			this.y + p.y
		)
	}

	@Operator
	This minus(Vector p) {
		return Vector.make(
			this.x - p.x,
			this.y - p.y
		)
	}
	
//	Int angle() {
//		// -y 'cos my y-axis is inverted
//		// http://mathforum.org/library/drmath/view/54114.html
//		return Math.atan2(x.toFloat, -y.toFloat).toDegrees.toInt
//	}

	Int scalar() {
		return ((x*x) + (y*y)).toFloat.sqrt.toInt
	}

	This rotateBy(Int angle) {
		xx := (x * Sin.cos(angle)) - (y * Sin.sin(angle))
		yy := (y * Sin.cos(angle)) + (x * Sin.sin(angle))
		return Vector.make(xx.toInt, yy.toInt)
	}
	
	Point toPoint() {
		Point(x, y)
	}

	override This offset(Int x, Int y) {
		Vector.make(this.x + x, this.y + y)
	}
	
	override This translate(Coordinate t) { 
		Vector.make(x + t.x, y + t.y) 
	}
	
	static Vector fromPoint(Point point) {
		return Vector.make(point.x, point.y)
	}

	static Vector? fromStr(Str s, Bool checked := true) {
		try {
			comma := s.index(",")
			return Vector.make(
				s[0..<comma].trim.toInt, 
				s[comma+1..-1].trim.toInt
			)
		} catch {}
		if (checked) throw ParseErr("Invalid Vector: $s")
		return null
	}

	override Int hash() {
		x.xor(y.shiftl(16))
	}

	override Bool equals(Obj? obj) {
		that := obj as Point
	    if (that == null) return false
	    return this.x == that.x && this.y == that.y
	}

	override Str toStr() { "$x,$y" }
}
