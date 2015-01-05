
@Js
public const class Random {
	
	public Int nextInt(Range minMax) {
		return Int.random(minMax)
	}

	public Float nextFloat(Range minMax) {
		return (Float.random * diff(minMax)) + minMax.min
	}

	public Bool nextBool(Int chance) {
		if (chance < 2)
			throw ArgErr("Chance $chance is too small")
		return nextInt(0..<chance) == 0
	}
	
	private static Float diff(Range minMax) {
		return (minMax.max - minMax.min).toFloat
	}
}
