
@Js @NoDoc
class FatPodSpore : SpriteCollision {

	new makeAt(Coordinate centreCoor, Coordinate speeds) : super.make(16, 16) {
		image 			= Ioc.images.fatPodSpore
		coor.x 			= centreCoor.x - (size.w / 2)
		coor.y 			= centreCoor.y - (size.h / 2)
		speed.x			= speeds.x
		speed.y			= speeds.y
		speed.friction	= false
		nrg				= 1
		mass 			= 10
		hitCountdown	= 10	// give the spike a couple of frames to get clear of the explosion!
		spriteTypes.addAll([SpriteType.bullet, SpriteType.badBullet, SpriteType.fatPodSpore])
	
		coor.clipFunc 	= |->| {
			dead = true
		}
		
		(0..<8).each |i| {
			addCollisionRect(i, Rect2( 3,  1,  9, 10))
		}
	}
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {		
		if (sprHit.isAnyOf([SpriteType.player, SpriteType.goodBullet])) {
			nrg			= -1
			exploSpeed 	:= arghImHit(sprHit, rctCollision)
			exploCoor 	:= rctCollision.centre
			
			score 		:= ScoreSheet.fatPodSporeDestroyed
			Ioc.scoreSheet.add(score)

			Ioc.sprites.add(Explosion16.makeAt(exploCoor, exploSpeed))
			Ioc.sprites.add(Label8.makeAt(coor.centre, score))
							
			dead = true
		}
	}
}
