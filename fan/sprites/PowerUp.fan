
@Js
class PowerUp : SpriteCollision {
	
	private PowerUpType type

	new makeFromPod(Coordinate centreCoor, Coordinate speeds, PowerUpType powerUpType) : this.makeAt(0, 0, powerUpType) {
		coor.x 			= centreCoor.x - (size.w / 2)
		coor.y 			= centreCoor.y - (size.h / 2)
		speed.x 		= speeds.x
		speed.y 		= speeds.y		
	}

	new makeAt(Int x, Int y, PowerUpType powerUpType) : super.make(32, 32) {
		image 			= Ioc.images.powerUps
		coor.x 			= x
		coor.y 			= y
		speed.x			= (Sprite2D.SPEED_COEFF * -0.5f).toInt
		speed.defaultX	= speed.x
		mass 			= 100
		spriteSheet 	= SpriteSheet(this, true)	
		coor.clipFunc 	= |->| {
			dead = true
		}
		coor.clipFuncYMax = null	// allow sprite to be blasted off the screen and return
		
		type = powerUpType
		setType(powerUpType)
		
		spriteSheet.maskFrames = (6..<72).toList
		
		(0..<64).each |i| {
			addCollisionRect(i, Rect2(11,  1, 10, 30))
			addCollisionRect(i, Rect2( 3,  7, 26, 18))
		}		
	}

	private Void setType(PowerUpType powerUpType) {
		nrg	= 20
		type = powerUpType
		spriteSheet.frames = powerUpType.frames
		spriteTypes.clear
		spriteTypes.addAll(powerUpType.types)
	}
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {

		// bitten by a bullet!
		if (sprHit.isAnyOf([SpriteType.bullet])) {
			exploSpeed := arghImHit(sprHit, rctCollision)
			nrg -= 5
			
			score := ScoreSheet.powerUpHit
			Ioc.scoreSheet.add(score)
			
			// if dead, re-incarnate ourselves as a new power up
			if (nrg < 0) {
				switch (type) {
				case PowerUpType.speedUp:
				    setType(PowerUpType.tripleFire)
				case PowerUpType.tripleFire:
				    setType(PowerUpType.extraNrg)
				case PowerUpType.extraNrg:
				    setType(PowerUpType.speedUp)				    
				}
			}
		}

		// we've been collected by the player
		if (sprHit.isAnyOf([SpriteType.player])) {
			exploSpeed := arghImHit(sprHit, rctCollision)
			nrg -= 5
			
			score := ScoreSheet.powerUpCollected
			Ioc.scoreSheet.add(score)
			Ioc.sprites.add(Label8.makeWith(coor.centre, type.text))
			Ioc.sprites.add(Explosion40.makeAt(coor.centre, exploSpeed))
			dead = true
		}
	}
}

@Js
enum class PowerUpType {
	speedUp		( 0..< 8, "Speed Up", 	 SpriteType.speedUp),
	tripleFire	( 8..<16, "Triple Fire", SpriteType.tripleFire),
	extraNrg	(48..<56, "Energy",		 SpriteType.extraNrg)
	
	const Str text
	const Int[] frames
	const SpriteType[] types
	
	private new make(Range frames, Str text, SpriteType type) {
		this.text 	= text
		this.frames = frames.toList
		this.types	= [SpriteType.powerUp, type]
	}
}