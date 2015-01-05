using gfx::Color
using gfx::Font
using gfx::Graphics
using gfx::Size

@Js @NoDoc
mixin ScreenTextWriter {
	
	Void titleText(Gfx g) {
		fillScreen(g, Color.makeRgb(0, 0, 16))

		drawFont8Centred (g, "Alien-Factory",			(16 *  6))
		drawFont8Centred (g, "presents", 				(16 *  6)+8)
		drawFont16Centred(g, "\"G U N D A M\"",			(16 *  9))
	}
	
	protected Void drawFont8Centred(Gfx g, Str text, Int y) {
		if (Runtime.isJs && Ioc.images.font8x8.size == Size.defVal) {
			drawFont8CentredJs(g.g, text, y)
		} else {
			g.drawFont8Centred(text, y)
		}
	}

	protected Void drawFont16Centred(Gfx g, Str text, Int y) {
		if (Runtime.isJs && Ioc.images.font16x16.size == Size.defVal) {
			drawFont16CentredJs(g.g, text, y)
		} else {
			g.drawFont16Centred(text, y)
		}
	}
	
	private Void drawFont8CentredJs(Graphics g, Str text, Int y) {
		x := (g.clipBounds.w - (text.size * 8)) / 2
		font8 := Font.fromStr("12pt Monospace")
		g.brush = Color.white 
		g.font = font8
		g.drawText(text, x, y)
		font8.dispose
	}	

	private Void drawFont16CentredJs(Graphics g, Str text, Int y) {
		x := (g.clipBounds.w - (text.size * 16)) / 2
		font8 := Font.fromStr("24pt Monospace")
		g.brush = Color.white 
		g.font = font8
		g.drawText(text, x, y)
		font8.dispose
	}		

	protected abstract Void fillScreen(Gfx g, Color colour)
}
