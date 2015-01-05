
@Js
class SpriteSheet {

	private Sprite2D	sprite
	private Int 		animWait

			Int[]?		frames
			Int[]?		maskFrames
			Int 		frameIndex
			|->|?		frameLoopFunc
	const	Bool		hasMask
			Bool		showMask
			Int			maxAnimWait	:= 2
	
	new make(Sprite2D sprite, Bool hasMask := false) {
		this.sprite = sprite
		this.hasMask = hasMask
	}
	
	virtual Void anim() {
		if (!loaded) return
		setDefaultFrames
		
		animWait++
		if (animWait > maxAnimWait) {
			animWait = 0

			frameIndex++
			if (frameIndex >= frames.size) {
				frameIndex = 0
				frameLoopFunc?.call
			}
		}
	}
	
	Void draw(Gfx g) {
		if (!loaded) return
		setDefaultFrames
		
		index := showMask ? maskFrames[frameIndex] : frames[frameIndex] 
		srcX := (index % cols) * sprite.size.w
		srcY := (index / cols) * sprite.size.h		
		g.copyImage(sprite.image, gfx::Rect(srcX, srcY, sprite.size.w, sprite.size.h), gfx::Rect(sprite.coor.x, sprite.coor.y, sprite.size.w, sprite.size.h))
	}

	Void setRandomFrameIndex() {
		if (!loaded) return
		setDefaultFrames
		
		frameIndex = Int.random(0..<frames.size)
	}
	
	private once Int cols() {
		return sprite.image.size.w / sprite.size.w
	}

	private once Int rows() {
		sprite.image.size.h / sprite.size.h
	}

	private Bool loaded() {
		return sprite.image.size != gfx::Size.defVal
	}

	// fudge as we usually don't yet have an image to calc maxAnimIndex in the ctor
	private Void setDefaultFrames() {
		if (!loaded) return
		
		if (frames == null) {
			maxAnimIndex := (cols * rows) / (hasMask ? 2 : 1)
			frames	= (0..<maxAnimIndex).toList
		}
		
		if (hasMask && maskFrames == null) {
			minAnimIndex := (cols * rows) / 2
			maxAnimIndex := (cols * rows)
			maskFrames = (minAnimIndex..<maxAnimIndex).toList
		}
	}
}
