
@Js
class FatPodHead : SpriteCollision {

	private FatPod fatPod
	
	new make(FatPod fatPod) : super.make(16, 16) {
		this.fatPod = fatPod
		spriteTypes.addAll([SpriteType.alien, SpriteType.fatPodHead])
	
		addCollisionRect(0, Rect2(26,  7, 48, 26))
		addCollisionRect(0, Rect2(40,  1, 24, 32))
	}
	
	override Void anim() {
		// stop the animation
	}

	override Void move() {
		coor.x = fatPod.coor.x
		coor.y = fatPod.coor.y
	}
	
	override Void draw(Gfx g) {
		drawDebug(g)
	}
	
	override Void collided(SpriteCollision sprHit, Rect2 rctCollision) {
		fatPod.collidedWithHead(sprHit, rctCollision)
	}
}
