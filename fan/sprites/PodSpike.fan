
@Js @NoDoc
class PodSpike : SpriteCollision {

	private Int frameIndex
	
	new makeAt(Coordinate centreCoor, Coordinate speeds, Int frameIndex) : super.make(16, 16) {
		image 			= Ioc.images.podSpikes
		coor.x 			= centreCoor.x - (size.w / 2)
		coor.y 			= centreCoor.y - (size.h / 2)
		speed.x			= speeds.x
		speed.y			= speeds.y
		speed.friction	= false
		nrg				= 1
		mass 			= 5
		hitCountdown	= 3	// give the spike a couple of frames to get clear of the explosion!
		spriteTypes.addAll([SpriteType.bullet, SpriteType.badBullet, SpriteType.podSpike])
	
		this.frameIndex	= frameIndex
		coor.clipFunc 	= |->| {
			dead = true
		}
		
		spriteSheet.frameIndex = frameIndex
		addCollisionRect(0, Rect2(6, 2,  4, 13))
		addCollisionRect(1, Rect2(2, 8,  7,  5))
		addCollisionRect(1, Rect2(8, 4,  4,  4))
		addCollisionRect(2, Rect2(1, 6, 13,  4))
		addCollisionRect(3, Rect2(8, 9,  4,  4))
		addCollisionRect(3, Rect2(4, 2,  7,  5))
		addCollisionRect(4, Rect2(6, 0,  4, 13))
		addCollisionRect(5, Rect2(4, 8,  4,  4))
		addCollisionRect(5, Rect2(8, 3,  6,  5))
		addCollisionRect(6, Rect2(3, 5, 13,  4))
		addCollisionRect(7, Rect2(4, 3,  4,  4))
		addCollisionRect(7, Rect2(8, 7,  6,  6))		
	}
	
	override Void anim() {
		super.anim
		// stop the animation
		spriteSheet.frameIndex = frameIndex
	}
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {		
		if (sprHit.isAnyOf([SpriteType.player, SpriteType.alien, SpriteType.goodBullet])) {
			nrg			= -1
			exploSpeed 	:= arghImHit(sprHit, rctCollision)
			exploCoor 	:= rctCollision.centre
			
			score 		:= ScoreSheet.podSpikeDestroyed
			Ioc.scoreSheet.add(score)

			Ioc.sprites.add(Explosion16.makeAt(exploCoor, exploSpeed))
			Ioc.sprites.add(Label8.makeAt(coor.centre, score))
							
			dead = true
		}
	}
}
