using afFantomMappy::LayerViewer

@Js
class Sprites {
	
	private Sprite2D[] sprites := [,]
	
	Void add(Sprite2D sprite) {
		sprites.add(sprite)
	}
	
	Void move() {
		sprites.each |sprite| {
			sprite.move
		}
	}

	Void anim() {
		sprites.each |sprite| {
			sprite.anim
		}
	}

	Void draw(Gfx g, SpriteType type := SpriteType.all) {
		sprites.each |sprite| {
			if (sprite.spriteTypes.contains(type))
				sprite.draw(g)
		}
	}
	
	
	Void spriteCollision() {
		collisionSprites := sprites.findType(SpriteCollision#)
		collisionSprites.each |SpriteCollision sprite1| {
			collisionSprites.each |SpriteCollision sprite2| {   
				if (sprite1 == sprite2)
					return
				sprite1.hasCollidedWith(sprite2) |rctCollision| {
					sprite1.collided(sprite2, rctCollision)					
				}
			}
		}
	}
	
	Void mapCollision(LayerViewer layerViewer) {
		sprites.findType(MapCollision#).each |sprite| {
			if ((sprite as MapCollision).hit)
				return
			(sprite as MapCollision).mapCollisionDetection(layerViewer)
		}
	}
	
	Void removeDead() {
		sprites = sprites.exclude |sprite -> Bool| {
			return sprite.dead
		}
	}

	Void clear() {
		sprites.clear
	}
}

