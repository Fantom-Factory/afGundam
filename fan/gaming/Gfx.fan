using gfx

@Js @NoDoc
class Gfx {
	
			Graphics	g

	private Image		font8x8 	:= Ioc.images.font8x8
	private Image		font16x16	:= Ioc.images.font16x16
	private Int 		ox
	private Int 		oy
	
	new make(Graphics g) {
		this.g = g
	}

	Void offset(Int x, Int y) {
		ox += x
		oy += y
	}
	
	Brush brush {
		get { g.brush }
		set { g.brush = it }
	}
	
	This clip(Rect bounds) {
		g.clip(bounds)
		return this
	}

	This drawImage(Image image, Int x, Int y) {
		g.drawImage(image, ox+x, oy+y)
		return this
	}
	
	This copyImage(Image image, Rect src, Rect dest) {
		g.copyImage(image, src, Rect(ox+dest.x, oy+dest.y, dest.w, dest.h))
		return this
	}
	
	This drawRect(Int x, Int y, Int w, Int h) {
		g.drawRect(ox+x, oy+y, w, h)
		return this
	}
	
	This fillRect(Int x, Int y, Int w, Int h) {
		g.fillRect(ox+x, oy+y, w, h)
		return this		
	}
	
	This fillRoundRect(Int x, Int y, Int w, Int h, Int wArc, Int hArc) {
		g.fillRoundRect(ox+x, oy+y, w, h, wArc, hArc)
		return this
	}

	This drawFont8Centred(Str text, Int y) {
		x := (g.clipBounds.w - (text.size * 8)) / 2
		drawFont8(text, x, y)
		return this
	}

	This drawFont8(Str text, Int x, Int y) {
		drawFont(text, ox+x, oy+y, font8x8, 8)
		return this
	}

	This drawFont16Centred(Str text, Int y) {
		x := (g.clipBounds.w - (text.size * 16)) / 2
		drawFont16(text, x, y)
		return this
	}

	This drawFont16(Str text, Int x, Int y) {
		drawFont(text, ox+x, oy+y, font16x16, 16)
		return this
	}
	
	private Void drawFont(Str text, Int initX, Int initY, Image font, Int fontSize) {
		Int x := initX
		Int y := initY

		text.each |char| {   
			if (char == '\n') {
				x  = initX
				y += fontSize				
			} else {
				
				// work out how many chars along from [SPACE] our char is
				chrPos := char - ' '
	
				srcX := (chrPos % 8) * fontSize
				srcY := (chrPos / 8) * fontSize
	
				g.copyImage(font, Rect(srcX, srcY, fontSize, fontSize), Rect(x, y, fontSize, fontSize))
	
				x += fontSize
			}
		}
	}	
	
}
