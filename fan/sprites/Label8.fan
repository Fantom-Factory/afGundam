
@Js @NoDoc
class Label8 : Sprite2D {
	
	private Str text
	private	Int deathCount	:= 40

	new makeAt(Coordinate xy, Int score) : this.makeWith(xy, score.toStr) {	}
	
	// TODO: interesting - this doesn't use a SpriteSheet
	new makeWith(Coordinate xy, Str texty) : super.make(0, 0) {
		image 	= Ioc.images.font8x8
		text 	= texty
		coor.x 	= xy.x - (text.size * 8 / 2)
		coor.y	= xy.y - 4
		speed.y = (Sprite2D.SPEED_COEFF * -1.5f).toInt
		spriteTypes.add(SpriteType.label)
	}
	
	override Void anim() {
		deathCount--
		if (deathCount < 0)
			dead = true
	}
	
	override Void draw(Gfx g) {
		g.drawFont8(text, coor.x, coor.y)
	}
}
