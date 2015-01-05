using gfx::Rect
using afFantomMappy::LayerViewer

@Js @NoDoc
class LeadSlug : SpriteCollision, MapCollision {
	
	new makeAt(Coordinate coors, Coordinate speeds) : super.make(9, 6) {
		image 	= Ioc.images.gundamGame
		coor.x 	= coors.x
		coor.y 	= coors.y
		speed.x	= speeds.x
		speed.y	= speeds.y
		speed.friction = false
		spriteTypes.addAll([SpriteType.bullet, SpriteType.goodBullet, SpriteType.leadSlug])		
		
		coor.clipFunc = |->| {
			dead = true
		}
		
		mass = 4
		addCollisionRect(0, Rect2( 0, 0, 8, 6))
	}
	
	override Void anim() {
		// stop the spriteSheet anim 
		spriteSheet.frameIndex = 0
	}
	
	override Void draw(Gfx g) {
		g.copyImage(image, Rect(48 * 5, 44, size.w, size.h), Rect(coor.x, coor.y, size.w, size.h))
		drawDebug(g)
	}
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {
		if (sprHit.isAnyOf([SpriteType.player, SpriteType.goodBullet]))
			return
		
		exploSpeed := deferCollisionSpeed(sprHit)
		Ioc.sprites.add(Explosion16.makeAt(rctCollision.centre, exploSpeed))
		dead = true
	}
	
	override Void mapCollisionDetection(LayerViewer layerViewer) {
		hitCoor := Point2.make(7, 3).translate(coor)
		
		if (isCollisionAt(layerViewer, hitCoor)) {
			
			// Va = (2Vb - Va) assuming infinate mass for the walls
			speedX := (2 * -Sprite2D.SPEED_COEFF) - speed.x
			speedY := - speed.y
			
			Ioc.sprites.add(Explosion16.makeAt(hitCoor, Point2(speedX, speedY)))
			
			dead = true
		}
	}
}
