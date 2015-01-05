
@Js @NoDoc
class SpikyPod : SpriteCollision {

	private	Int initY

	new makeAt(Int x, Int y) : super.make(64, 64) {
		image 			= Ioc.images.spikyPod
		coor.x 			= x
		coor.y 			= y
		initY			= y
		speed.x			= Sprite2D.SPEED_COEFF * -2
		speed.y			= Sprite2D.SPEED_COEFF *  5
		speed.frictionY	= false
		speed.defaultX	= speed.x
		nrg				= 30
		mass 			= 40
		spriteSheet 	= SpriteSheet(this, true)	
		spriteTypes.addAll([SpriteType.alien, SpriteType.spikeyPod])
		
		coor.clipFuncYMin 	= |->| {
			dead = true
		}
		
		(0..<16).each |i| {
			addCollisionRect(i, Rect2(15, 15, 32, 32))
			addCollisionRect(i, Rect2(23, 11, 19, 41))
			addCollisionRect(i, Rect2(11, 25, 43, 13))
		}		
	}
	
	override Void move() {
		if (coor.y > initY)
			speed.thrustY(-4)
		if (coor.y < initY)
			speed.thrustY(4)
		
		super.move
	}
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {		
		explo := false
		
		if (sprHit.isAnyOf([SpriteType.goodBullet])) {
			explo			= true
			nrg				-= 5
			hitCountdown	= 4
		}

		if (sprHit.isAnyOf([SpriteType.player])) {
			explo			= true
			nrg				-= 6
			hitCountdown	= 10
		}

		if (sprHit.isAnyOf([SpriteType.asteroid])) {
			explo			= true
			nrg				-= 4
			hitCountdown	= 10
		}

		// explode where it hurts!
		if (explo) {
			exploSpeed := arghImHit(sprHit, rctCollision)
			
			score 		:= ScoreSheet.spikyPodHit
			Ioc.scoreSheet.add(score)
			
			if (nrg < 0) {
				score = ScoreSheet.spikyPodDestroyed
				Ioc.scoreSheet.add(score)
				Ioc.sprites.add(Label8.makeAt(coor.centre, score))
				Ioc.sprites.add(Explosion64.makeAt(coor.centre, exploSpeed))
				
				// let there be spikes! we ain't going out without a fight!
				initCoors 	:= Vector.make(0, -24)
				initSpeed 	:= Vector.make(0, -6 * Sprite2D.SPEED_COEFF)
				(0..<8).each |i| {
					angle 	:= i * 45
					coors 	:= initCoors.rotateBy(angle).translate(coor.centre)
					speeds	:= initSpeed.rotateBy(angle).translate(exploSpeed)
					Ioc.sprites.add(PodSpike.makeAt(coors, speeds, i))
				}
	
				// now lets give the nice player a power up
				Ioc.sprites.add(PowerUp.makeFromPod(coor.centre, exploSpeed, PowerUpType.speedUp))
				
				// but we are dead
				dead = true
			}	
		}
		
	}
}
