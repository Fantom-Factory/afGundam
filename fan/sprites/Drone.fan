
@Js
class Drone : SpriteCollision {

	private	Bool spin

	new makeAt(Int x, Int y) : super.make(32, 32) {
		image 			= Ioc.images.drone
		coor.x 			= x
		coor.y 			= y
		speed.x			= Sprite2D.SPEED_COEFF * -3
		speed.defaultX	= Sprite2D.SPEED_COEFF * -3
		nrg				= 12
		mass 			= 30
		
		spriteSheet 	= SpriteSheet(this, true)
		spriteSheet.frames = [12, 13, 12, 11]
		spriteSheet.maxAnimWait = 3
		spriteSheet.setRandomFrameIndex
		
		spriteTypes.addAll([SpriteType.alien, SpriteType.drone])
		
		coor.clipFunc 	= |->| {
			dead = true
		}			
		coor.clipFuncYMax = null	// allow sprite to be blasted off the screen and return
		
		(0..<16).each |i| {
			addCollisionRect(i, Rect2(10,  4, 12, 25))
			addCollisionRect(i, Rect2( 3, 11, 26, 12))
		}
	}
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {
		if (!sprHit.isAnyOf([SpriteType.player, SpriteType.bullet]))
			return
		
		spin					= true
		spriteSheet.frameIndex 	= spriteSheet.frames[spriteSheet.frameIndex] 
		spriteSheet.frames 		= (0..<16).toList 
		spriteSheet.maxAnimWait = 1
		
		maxY			:= Sprite2D.SPEED_COEFF * 3
		speed.y			= Int.random(-maxY..maxY)
		speed.defaultY	= speed.y

		score 			:= ScoreSheet.droneHit
		Ioc.scoreSheet.add(score)
		nrg 			-= 5
		hitCountdown 	= 4
		
		exploSpeed := arghImHit(sprHit, rctCollision)
		
		if (nrg < 0) {
			score = ScoreSheet.droneDestroyed
			Ioc.scoreSheet.add(score)
			Ioc.sprites.add(Label8.makeAt(coor.centre, score))
			Ioc.sprites.add(Explosion20.makeAt(coor.centre, exploSpeed))
			dead = true
		}
	}	
}
