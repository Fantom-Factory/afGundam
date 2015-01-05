
@Js @NoDoc
abstract class AbsAsteroid : SpriteCollision {

	new makeAt(Int x, Int y, Int w, Int h) : super.make(w, h) {
		coor.x 	= x
		coor.y 	= y
		spriteSheet = SpriteSheet(this, true)
		spriteTypes.addAll([SpriteType.alien, SpriteType.asteroid])
		
		coor.clipFunc = |->| {
			dead = true
		}
		coor.clipFuncYMax = null	// allow sprite to be blasted off the screen and return
	}
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {
		explo := false
		
		if (sprHit.isAnyOf([SpriteType.bullet])) {
			explo			= true
			nrg				-= 5
			hitCountdown 	= 4
		}

		if (sprHit.isAnyOf([SpriteType.player])) {
			explo			= true
			nrg				-= 6
			hitCountdown	= 20
		}

		if (sprHit.isAnyOf([SpriteType.asteroid, SpriteType.spikeyPod])) {
			explo			= true
			nrg				-= 4
			hitCountdown	= 20
		}
		
		// explode where it hurts!
		if (explo) {
			exploSpeed := arghImHit(sprHit, rctCollision)
			explode(exploSpeed)
			
			if (nrg <= 0) {
				destroyed(exploSpeed)
				dead = true
			}		
		}
	}
	
	abstract Void explode(Speed exploSpeed)
	abstract Void destroyed(Speed exploSpeed)
}
