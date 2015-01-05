using gfx::Image
using gfx::Size

@Js @NoDoc
abstract class Sprite2D {
	public static const Int SPEED_COEFF 	:= 20

	Coor 	coor
	Size	size
	Image? 	image
	Speed	speed				:= Speed()
	Bool 	dead 				:= false
	SpriteType[] spriteTypes	:= [SpriteType.all]
	
	protected SpriteSheet spriteSheet

	new make(Int w, Int h) {
		this.size = Size(w, h)
		this.coor = Coor.makeWithSpriteSize(size)	// yes, SIZE is correct!
		this.spriteSheet = SpriteSheet(this)
	}
	
	Bool isAnyOf(SpriteType[] types) {
		spriteTypes.containsAny(types)
	}
	
	virtual Void draw(Gfx g) {
		spriteSheet.draw(g)
	}
	
	virtual Void anim() {
		spriteSheet.anim
	}

	virtual Void move() {
		coor.move(speed)
		speed.dampen
	}
}


@Js @NoDoc
enum class SpriteType {
	all,
	
	// ---- main types ----------------
	player,
	bullet,
	powerUp,
	alien,
	explosion,
	label,
	
	// ---- alien sub-types -----------
	asteroid,
	spikeyPod,
	podSpike,
	drone,
	fatPod,
	fatPodHead,
	fatPodSpore,
	
	// ---- bullet sub-types ----------
	goodBullet,
	badBullet,
	leadSlug,

	// ---- power up sub-types --------
	extraNrg,
	speedUp,
	tripleFire
}