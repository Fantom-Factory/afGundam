using gfx

@Js
class Coor : Coordinate {
	
	private Size spriteSize 
	private Size windowSize 
	|->|?		clipFuncX	:= |->| { clipFunc?.call  }
	|->|?		clipFuncYMin:= |->| { clipFuncY?.call }
	|->|?		clipFuncYMax:= |->| { clipFuncY?.call }
	|->|?		clipFuncY	:= |->| { clipFunc?.call  }
	|->|?		clipFunc
	
	CoorClipStrategy clipStrategy := CoorClipStrategy.outsideScreen
	
	override Int x := 0 {
		set { setX(it) }
	}
	
	override Int y := 0 {
		set { setY(it) }
	}

	new makeWithSpriteSize(Size spriteSize) { 
		this.spriteSize = spriteSize
		this.windowSize = Ioc.javamappy.gameSize 
	}

	new makeAt(Size spriteSize, Int x, Int y) { 
		this.spriteSize = spriteSize 
		this.windowSize = Ioc.javamappy.gameSize
		this.x = x
		this.y = y
	}
	
	private Int speedLeftOverX := 0
	private Int speedLeftOverY := 0
	
	Void move(Speed speed) {
		// TODO: kill speedLeftOver
		speedLeftOverX += speed.x
		x += speedLeftOverX / Sprite2D.SPEED_COEFF
		speedLeftOverX %= Sprite2D.SPEED_COEFF
		if (speed.x == 0)
			speedLeftOverX = 0

		speedLeftOverY += speed.y
		y += speedLeftOverY / Sprite2D.SPEED_COEFF
		speedLeftOverY %= Sprite2D.SPEED_COEFF
		if (speed.y == 0)
			speedLeftOverY = 0
	}
	
	Point2 centre() {
		Point2(x+(spriteSize.w/2), y+(spriteSize.h/2))
	}
	
	override This offset(Int x, Int y) {
		Coor.makeAt(spriteSize, this.x + x, this.y + y)
	}
	
	override This translate(Coordinate t) { 
		Coor.makeAt(spriteSize, this.x + t.x, this.y + t.y) 
	}
	
	private Void setX(Int val) {
		&x = val
		clipped := false
		if (clipStrategy == CoorClipStrategy.insideScreen) {
			if (val < 0) {
				&x = 0
				clipped = true
			}
			if (val > (windowSize.w - spriteSize.w)) { 
				&x = (windowSize.w - spriteSize.w)
				clipped = true
			}
		}
		if (clipStrategy == CoorClipStrategy.outsideScreen) {
			if (val < -spriteSize.w) {
				&x = -spriteSize.w
				clipped = true					
			}
			if (val > (windowSize.w + spriteSize.w)) {
				&x = (windowSize.w + spriteSize.w)
				clipped = true
			}
		}
		if (clipped)
			clipFuncX?.call
	}
	
	private Void setY(Int val) {
		&y = val
		if (clipStrategy == CoorClipStrategy.insideScreen) {
			if (val < 0) {
				&y = 0
				clipFuncYMin?.call
			}
			if (val > (windowSize.h - spriteSize.h)) {
				&y = (windowSize.h - spriteSize.h)
				clipFuncYMax?.call
			}
		}
		if (clipStrategy == CoorClipStrategy.outsideScreen) {
			if (val < -spriteSize.h) {
				&y = -spriteSize.h
				clipFuncYMin?.call
			}
			if (val > (windowSize.h + spriteSize.h)) {
				&y = (windowSize.h + spriteSize.h)
				clipFuncYMax?.call
			}
		}		
	}
}

@Js
enum class CoorClipStrategy {
//	none,
	insideScreen,
	outsideScreen
}