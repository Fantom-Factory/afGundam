
@Js
class FatPod : SpriteCollision {

	private Coordinate finalCoor
	private FatPodHead fatPodHead
	private MapController mapController
	
	new makeAt(Int x, Int y, MapController mapController) : super.make(96, 96) {
		image 			= Ioc.images.fatPod
		coor.x 			= x
		coor.y 			= y
		speed.x			= (Sprite2D.SPEED_COEFF * -0.5f).toInt
		speed.y			= (Sprite2D.SPEED_COEFF *  3.0f).toInt
		speed.defaultX	= speed.x
		speed.frictionY	= false
		nrg				= 100
		mass 			= 120
		spriteTypes.addAll([SpriteType.alien, SpriteType.fatPod])

		spriteSheet 	= SpriteSheet(this, true)
		spriteSheet.maxAnimWait = 4
		
		coor.clipFunc 	= |->| {
			dead = true
		}
		
		finalCoor = Point2(400, y)
		
		(0..<24).each |i| {
			addCollisionRect(i, Rect2(26, 32, 48, 55))
			addCollisionRect(i, Rect2(15, 34, 70, 41))
		}
		
		fatPodHead = FatPodHead(this)
		Ioc.sprites.add(fatPodHead)
		
		this.mapController = mapController
		mapController.stopScrolling
		
		// who's ya Daddy? Who Hah!
		Ioc.hud.addBaddy(this, "FatPod", 0)
	}
	
	override Void move() {
		// occilate pod left and right
		thrustX := (nrg <= 50) ? 3 : 0
		if (coor.x > finalCoor.x)
			speed.thrustX(-thrustX)
		if (coor.x < finalCoor.x)
			speed.thrustX(thrustX)
		
		// occilate pod up and down
		thrustY := (nrg <= 30) ? 6 : 3
		if (coor.y > finalCoor.y)
			speed.thrustY(-thrustY)
		if (coor.y < finalCoor.y)
			speed.thrustY(thrustY)
		
		// stop pod in the middle of the screen
		if (coor.x < finalCoor.x) 
			speed.defaultX = 0
		
		super.move
	}	
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {		
		if (sprHit.isAnyOf([SpriteType.player, SpriteType.goodBullet])) {
			exploCoor 	:= rctCollision.centre
			exploSpeed 	:= arghImHit(sprHit, rctCollision)
			Ioc.sprites.add(Explosion32.makeAt(exploCoor, exploSpeed))
			
			angle := Int.random(0..45)
			sporeSpeed := Vector.make(exploSpeed.x, exploSpeed.y).offset(Sprite2D.SPEED_COEFF * -2, 0)
			Ioc.sprites.add(FatPodSpore.makeAt(exploCoor, sporeSpeed.rotateBy(-angle)))			
			Ioc.sprites.add(FatPodSpore.makeAt(exploCoor, sporeSpeed.rotateBy( angle)))			
		}
	}
	
	Void collidedWithHead(SpriteCollision sprHit, Rect2 rctCollision) {
		if (sprHit.isAnyOf([SpriteType.goodBullet])) {
			score := ScoreSheet.fatPodHit
			Ioc.scoreSheet.add(score)
			
			nrg -= 5
			hitCountdown = 3
			
			collided(sprHit, rctCollision)
			
			if (nrg < 0) {
				exploSpeed 	:= arghImHit(sprHit, rctCollision)
				
				score = ScoreSheet.fatPodDestroyed
				Ioc.scoreSheet.add(score)
				Ioc.sprites.add(Label8.makeAt(coor.centre, score))
				Ioc.sprites.add(Explosion64.makeAt(coor.centre, exploSpeed))
	
				// Boom!
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
	
				// now lets give the nice player a power up
				Ioc.sprites.add(PowerUp.makeFromPod(coor.centre, exploSpeed, PowerUpType.speedUp))
	
				// but we are dead
				dead = true
				fatPodHead.dead = true
				
				mapController.startScrolling

				Ioc.hud.removeBaddy(this)
			}			
		}
	}
}
