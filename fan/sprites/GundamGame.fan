using gfx::Rect
using gfx::Size
using afFantomMappy::LayerViewer

@Js @NoDoc
class GundamGame : SpriteCollision, MapCollision {
	private static const Log log := Log.get("GundamSprite")
	
	private PlayerInput playerInput
	private GamePrefs	gamePrefs
	
	private Int powerUpCountdown	:= 0
			Int speedUpCountdown	:= 0
			Int tripleFireCountdown	:= 0
	private Int maxPowerUp			:= 100
	private Int maxNrg				:= 100
	
	private Int fireAnimIndex		:= 0
	private Int thrustAnimIndex		:= 0

	private	Point2[] mapColPoints	:= [Point2( 8,  6),
										Point2(27,  5),
										Point2( 3, 12),
										Point2(44, 16),
										Point2(30, 29),
										Point2( 6, 31),
										Point2(10, 41),
										Point2(24, 42)]

	
	new make(PlayerInput playerInput) : super.make(48, 44) {
		this.playerInput = playerInput
		this.gamePrefs	 = Ioc.gamePrefs
		
		image 			= Ioc.images.gundamGame
		coor.x 			= 50
		coor.y 			= (11*16)-22
		nrg				= maxNrg
		spriteTypes.addAll([SpriteType.player])
		coor.clipStrategy = CoorClipStrategy.insideScreen
		coor.clipFuncX = |->| { speed.x = 0 }
		coor.clipFuncY = |->| { speed.y = 0 }
		
		mass = 30
		addCollisionRect(2, Rect2( 9,  5, 16, 38))
		addCollisionRect(2, Rect2( 2, 14, 41, 10))
		addCollisionRect(2, Rect2( 5,  8, 26, 24))	
	}

	override Void anim() {
		super.anim
		
		spriteSheet.frameIndex = hit ? 16 : 2
		
		if (playerInput.moving) {
			thrustAnimIndex ++
			if (thrustAnimIndex >= 3)
				thrustAnimIndex = 0
		}
		
		if (drawMuzzleFlare) {
			fireAnimIndex ++
			// bigger anim for Triple Fire
			max := hasTripleFire ? 3 : 1
			if (fireAnimIndex >= max) 
				fireAnimIndex = 0
		}
		
		spriteTypes.clear
		if (gamePrefs.godMode)
			spriteTypes.addAll([SpriteType.label])
		else
			spriteTypes.addAll([SpriteType.player])
	}
	
	override Void move() {
		thrustPower  	:=  3
		speed.minSpeed 	 = -2 * Sprite2D.SPEED_COEFF
		speed.maxSpeed 	 =  2 * Sprite2D.SPEED_COEFF
		
		if (hasSpeedUp) {
			thrustPower  	= 7
			speed.minSpeed	= -4 * Sprite2D.SPEED_COEFF
			speed.maxSpeed	=  4 * Sprite2D.SPEED_COEFF
			speed.dampen	// EXTRA SPEED STOP!
			speed.dampen	// EXTRA SPEED STOP!
		}

		if (playerInput.up)		speed.thrustY(-thrustPower)
		if (playerInput.down)	speed.thrustY( thrustPower)
		if (playerInput.left)	speed.thrustX(-thrustPower)
		if (playerInput.right)	speed.thrustX( thrustPower)

		// POW! POW! POW! -----> OW!
		if (playerInput.firing(true)) {
			slugSpeed := Vector.make(Sprite2D.SPEED_COEFF * 8, 0)
			Ioc.sprites.add(LeadSlug.makeAt(coor.offset(44, 14), slugSpeed))
			speed.thrustX(-8)

			if (hasTripleFire) {
				newSpeed := slugSpeed.rotateBy(-15)
				Ioc.sprites.add(LeadSlug.makeAt(coor.offset(44, 14), newSpeed))
				speed.thrustX(-6)
				newSpeed = slugSpeed.rotateBy(15)
				Ioc.sprites.add(LeadSlug.makeAt(coor.offset(44, 14), newSpeed))
				speed.thrustX(-6)				
			}
			fireAnimIndex++
		}
		
		super.move
		
		// decrement power ups
		powerUpCountdown--
		if (powerUpCountdown < 0) {
			powerUpCountdown = 20
			if (speedUpCountdown > 0)
				speedUpCountdown--
			if (tripleFireCountdown > 0)
				tripleFireCountdown--
		}		
	}
	
	override Void draw(Gfx g) {
		
		if (drawThrusters) {
			if (playerInput.up) {
				w	 := size.w / 2
				h	 := size.h
				dstX := coor.x - 5
				dstY := coor.y + 11
				srcX := (thrustAnimIndex * w)
				srcY := size.h
				g.copyImage(image, Rect(srcX, srcY, w, h), Rect(dstX, dstY, w, h))
			}

			if (playerInput.down) {
				w	 := size.w / 2
				h	 := size.h
				dstX := coor.x - 5
				dstY := coor.y - 18
				srcX := (thrustAnimIndex * w) + size.w
				srcY := size.h
				g.copyImage(image, Rect(srcX, srcY, w, h), Rect(dstX, dstY, w, h))
			}

			if (playerInput.right) {
				w	 := size.w
				h	 := size.h / 2
				dstX := coor.x - 23
				dstY := coor.y + 10
				srcX := size.w * 2
				srcY := (thrustAnimIndex * h) + size.h
				g.copyImage(image, Rect(srcX, srcY, w, h), Rect(dstX, dstY, w, h))
			}
		}
		
		if (drawMuzzleFlare) {
			w	 := (fireAnimIndex == 2) ? size.w : size.w / 2
			h	 := size.h
			dstX := coor.x + 42
			dstY := coor.y - 0
			srcX := (fireAnimIndex * (size.w/2)) + (size.w * 3)
			srcY := size.h
			g.copyImage(image, Rect(srcX, srcY, w, h), Rect(dstX, dstY, w, h))
		}		

		super.draw(g)
		
		if (gamePrefs.godMode)
			Label8.makeWith(coor.offset(24, -10), "God Mode").draw(g)
	}
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {
		if (gamePrefs.godMode)
			return
		
		// hey hey, what do we have here?
		if (sprHit.isAnyOf([SpriteType.extraNrg])) {
			log.debug("Gundam picked up a '$SpriteType.extraNrg' PowerUp")
			nrg += 40
			if (nrg > maxNrg) 
				nrg = maxNrg
		}
		
		if (sprHit.isAnyOf([SpriteType.speedUp])) {
			log.debug("Gundam picked up a '$SpriteType.speedUp' PowerUp")
			speedUpCountdown = maxPowerUp
		}
		
		if (sprHit.isAnyOf([SpriteType.tripleFire])) {
			log.debug("Gundam picked up a '$SpriteType.tripleFire' PowerUp")
			tripleFireCountdown = maxPowerUp
		}

		if (sprHit.isAnyOf([SpriteType.alien, SpriteType.badBullet])) {
			exploCoor 	:= rctCollision.centre
			exploSpeed 	:= arghImHit(sprHit, rctCollision)
			
			hitMe(rctCollision, exploSpeed)
		}
	}
	
	override Void mapCollisionDetection(LayerViewer layerViewer) {
		if (gamePrefs.godMode)
			return

		Coordinate? hitCoors := mapColPoints.eachWhile |pt| {
			pt = pt.translate(coor)
			return isCollisionAt(layerViewer, pt) ? pt : null
		}

		if (hitCoors != null) {
			origSpeedX := -speed.x 
			origSpeedY := -speed.y 

			// Va = (2Vb - Va) assuming infinate mass for the walls
			speedX := (2 * -Sprite2D.SPEED_COEFF) - speed.x
			speedY := - speed.y

			speed.thrustX(origSpeedX + speedX)
			speed.thrustY(origSpeedY + speedY)

			coor.move(speed)
			hitMe(Rect2(hitCoors.x, hitCoors.y, 1, 1), speed)
		}
	}
	
	private Void hitMe(Rect2 rctCollision, Speed exploSpeed) {
		Ioc.sprites.add(Explosion16.makeAt(rctCollision.centre, exploSpeed))
		
		hitCountdown = 10
		nrg -= 10
	
		if (nrg < 0) 
			explode(exploSpeed)
	}	
		
	Void explode(Speed exploSpeed) {
		initCoors 	:= Vector.make(0, -24)
		initSpeed1 	:= Vector.make(0, (Sprite2D.SPEED_COEFF * -3.0f).toInt)
		initSpeed2 	:= Vector.make(0, (Sprite2D.SPEED_COEFF * -1.5f).toInt)
		(0..<8).each |i| {
			angle 	:= i * 45
			coors 	:= initCoors .rotateBy(angle).translate(coor.centre)
			speeds1	:= initSpeed1.rotateBy(angle).translate(exploSpeed)
			speeds2	:= initSpeed2.rotateBy(angle).translate(exploSpeed)
			Ioc.sprites.add(Explosion16.makeAt(coors, speeds1))
			Ioc.sprites.add(Explosion40.makeAt(coors, speeds2))
		}

		Ioc.sprites.add(Label8.makeWith(coor.centre, "Game Over"))
		dead = true		
	}
	
	
	private Bool hasSpeedUp() {
		speedUpCountdown > 0
	}

	private Bool hasTripleFire() {
		tripleFireCountdown > 0
	}

	private Bool drawThrusters() {
		(thrustAnimIndex == 0) || (thrustAnimIndex == 1)
	}

	private Bool drawMuzzleFlare() {
		fireAnimIndex > 0
	}
}
