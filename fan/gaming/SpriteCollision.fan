using gfx::Color
using gfx::Size

@Js
class SpriteCollision : Sprite2D {
	
				Int 		nrg
	protected	Int 		mass
	protected	Int 		hitCountdown
	
	private 	Int:Rect2[]	rects		:= [:] { def = [,].toImmutable }
	private 	Int:Rect2 	union		:= [:] { def = [,].toImmutable }
	private 	Speed?		newSpeed
	private 	GamePrefs	gamePrefs	:= Ioc.gamePrefs
	

	
	new make(Int w, Int h) : super(w, h) {}
	
	override Void anim() {
		if (spriteSheet.hasMask)
			spriteSheet.showMask = hit
		if (hit)
			hitCountdown--
		
		super.anim
	}
	
	override Void move() {
		if (newSpeed != null) {
			// keep the exiting speed.defaultX & speed.defaultY
			speed.x = newSpeed.x
			speed.y = newSpeed.y
			newSpeed = null
		}
		
		super.move
	}
	
	override Void draw(Gfx g) {
		super.draw(g)
		drawDebug(g)
	}
	
	Void hasCollidedWith(SpriteCollision sprite, |Rect2 collisionRectangle| f) {
		// give the sprite a chance to recover!
		if (hit)
			return
		
		theirUnion 	:= sprite.unionMappedToScreen
		myUnion 	:= unionMappedToScreen
		
		if (myUnion.intersects(theirUnion)) {
			rctCollision := (sprite.rectsMappedToScreen.eachWhile |rect1| {
				rectsMappedToScreen.eachWhile |rect2| {
					return rect1.intersects(rect2) ? rect1.intersection(rect2) : null
				}
			})
			
			if (rctCollision != null)
				f(rctCollision)
		}
	}	
	
	virtual Void collided(SpriteCollision sprHit, Rect2 rctCollision) {	}
	
	// note for this to work properly, both sprites need to have the same SPEED_COEFFS, for it is 
	// this that determines how speed is portrayed on the screen.
	protected Speed deferCollisionSpeed(SpriteCollision sprHit) {

		// The collision uses the following formula to calculate the
		// resultant velocities / speeds :
		//   Va = (2MbVb + Va(Ma-Mb)) / (Ma+Mb)

		// get a couple constants
		massDiff 	:= mass - sprHit.mass
		massAdd		:= mass + sprHit.mass

		// calculate the new X speed
		colSpeedX	:= 2 * sprHit.mass * sprHit.speed.x
		colSpeedX 	+= speed.x * massDiff
		colSpeedX	/= massAdd

		// calculate the new Y speed
		colSpeedY	:= 2 * sprHit.mass * sprHit.speed.y
		colSpeedY	+= speed.y * massDiff
		colSpeedY	/= massAdd

		newSpeed	= Speed.makeWith(colSpeedX, colSpeedY)
		return newSpeed
	}	
		
	protected Void addCollisionRect(Int animIndex, Rect2 rect) {
		rects.getOrAdd(animIndex, |->Rect2[]| { [,]  }).add(rect)
		union[animIndex] = union.containsKey(animIndex) ? union[animIndex].union(rect) : rect
	}
	
	protected Void drawDebug(Gfx g) {
		if (gamePrefs.debugMode) {
			g.brush = Color.blue
			b := unionMappedToScreen
			g.drawRect(b.x, b.y, b.w, b.h)
			
			g.brush = Color.green
			rectsMappedToScreen.each |r| {
				g.drawRect(r.x, r.y, r.w, r.h)
			}
		}		
	}
	
	protected Bool hit() {
		hitCountdown > 0
	}		
	
	protected Speed arghImHit(SpriteCollision sprHit, Rect2 rctCollision) {
		
		// bounce!
		exploSpeed := deferCollisionSpeed(sprHit)
		
		exploCoor := rctCollision.centre
		if (nrg > 0)	// else we may have a BIGGER explosion!
			Ioc.sprites.add(Explosion16.makeAt(exploCoor, exploSpeed))
		
		// generate some space dust
		massDiff	:= sprHit.mass - mass
		massAdd		:= sprHit.mass + mass

		speedX  	:= 2 * mass * speed.x
		speedX 		+= sprHit.speed.x * massDiff
		speedX 		/= massAdd * 3

		speedY  	:= 2 * mass * speed.y
		speedY 		+= sprHit.speed.y * massDiff
		speedY 		/= massAdd * 3

		dustSpeed	:= Vector.make(speedX, speedY)
		Ioc.sprites.add(AsteroidDust.makeAt(exploCoor, dustSpeed))
		angle 		:= Int.random(20..50)
		newSpeed	:= dustSpeed.rotateBy(angle)
		Ioc.sprites.add(AsteroidDust.makeAt(exploCoor, newSpeed))
		newSpeed	= dustSpeed.rotateBy(-angle)
		Ioc.sprites.add(AsteroidDust.makeAt(exploCoor, newSpeed))
		
		return exploSpeed
	}
	
	// TODO: cache once per move - may not need to as we have union
	private Rect2[] rectsMappedToScreen() {
		rects[spriteSheet.frameIndex].map |rect| {
			rect.translate(coor)
		}
	}

	// TODO: cache once per move - may not need to as we have union
	private Rect2 unionMappedToScreen() {
		if (union.containsKey(spriteSheet.frameIndex))
			return union[spriteSheet.frameIndex].translate(coor)
		else
			return Rect2.defVal
	}
}
