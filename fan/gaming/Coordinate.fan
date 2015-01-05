
@Js
mixin Coordinate {

	abstract Int x()
	abstract Int y()

	abstract This offset(Int x, Int y)

	abstract This translate(Coordinate offset)
	
	override Str toStr() { "$x,$y" }

}
