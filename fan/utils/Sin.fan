
@Js
const class Sin {
	
	private const static Sin instance := Sin()
	private const Float[] sinTable 
	private const Float[] cosTable

	private new make() {
		sinTable := [,] {capacity=360}
		cosTable := [,] {capacity=360}
		(0..<360).each |i| {
			sinTable.add( i.toFloat.toRadians.sin )
			cosTable.add( i.toFloat.toRadians.cos )
		}
		this.sinTable = sinTable.toImmutable
		this.cosTable = cosTable.toImmutable
	}

	static Float sin(Int angle) {
		while (angle <  0)		angle += 360
		while (angle >= 360)	angle -= 360
		return instance.sinTable[angle]
	}

	static Float cos(Int angle) {
		while (angle <  0)		angle += 360
		while (angle >= 360)	angle -= 360
		return instance.cosTable[angle]
	}
}
