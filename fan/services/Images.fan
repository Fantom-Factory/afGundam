using gfx
using fwt

@Js
// TODO: Create own ImageWrapper for preloading, defining type, etc
class Images {
	private static const Log log := Log.get("Images")
	
	private [Str:Image] images := [:]
	
	static const Image icoAlienFactory := Image.make(`fan://${Images#.pod.name}/res/icons/icoAlienFactory.png`)

	Image? font8x8(ImageType? loadIf := null) 			{ load(ImageType.title, loadIf, "XenonFont8x8.png") }
	Image? font16x16(ImageType? loadIf := null)			{ load(ImageType.title, loadIf, "XenonFont16x16.png") }

	Image? titleBackground(ImageType? loadIf := null)	{ load(ImageType.title, loadIf, "TitleBackground.jpg") }
	Image? gameBackground(ImageType? loadIf := null)	{ load(ImageType.game,  loadIf, "GameBackground.jpg") }
	
	// ---- Title Images ------------------------------------------------------
	
	Image? gundamBig(ImageType? loadIf := null)			{ load(ImageType.title, loadIf, "GundamBig.png") }
	Image? gundamTech(ImageType? loadIf := null)		{ load(ImageType.title, loadIf, "GundamTech.png") }
	Image? gundamTitle(ImageType? loadIf := null)		{ load(ImageType.title, loadIf, "GundamTitle.png") }
	Image? gunSight(ImageType? loadIf := null)			{ load(ImageType.title, loadIf, "GunSight.png") }
	
	// ---- Game Images -------------------------------------------------------
	
	Image? explosion16(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "Explosion16.png") }
	Image? explosion20(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "Explosion20.png") }
	Image? explosion32(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "Explosion32.png") }
	Image? explosion40(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "Explosion40.png") }
	Image? explosion64(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "Explosion64.png") }
	
	Image? asteroidDust(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "AsteroidDust.png") }
	Image? asteroid32(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "Asteroid32.png") }
	Image? asteroid64(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "Asteroid64.png") }
	Image? asteroid96(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "Asteroid96.png") }
	
	Image? drone(ImageType? loadIf := null)				{ load(ImageType.game, loadIf, "Drone.png") }
	Image? spikyPod(ImageType? loadIf := null)			{ load(ImageType.game, loadIf, "SpikyPod.png") }
	Image? podSpikes(ImageType? loadIf := null)			{ load(ImageType.game, loadIf, "PodSpikes.png") }
	Image? fatPod(ImageType? loadIf := null)			{ load(ImageType.game, loadIf, "FatPod.png") }
	Image? fatPodSpore(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "FatPodSpore.png") }
	Image? powerUps(ImageType? loadIf := null)			{ load(ImageType.game, loadIf, "PowerUps.png") }

	Image? hud(ImageType? loadIf := null)				{ load(ImageType.game, loadIf, "HUD.png") }
	Image? gundamSmall(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "GundamSmall.png") }
	
	Image? gundamGame(ImageType? loadIf := null)		{ load(ImageType.game, loadIf, "GundamWalk.png") }

	
	** returns a list of images of type - they may or may not have loaded 
	Image[] preloadImages(ImageType loadType) {
		this.typeof.methods.findAll |method| {
			(method.returns == Image?#) && (method.isPublic) && (!method.isStatic) && (method.params.size == 1) && (method.params[0].type == ImageType?#)
		}.map |Method method->Image?| {
			method.callOn(this, [loadType])
		}.exclude |Image? image->Bool| { 
			image == null  
		}
	}
	
	Void disposeAll() {
		images.each |image, imageName| {
			log.info("Disposing Image $imageName")
			image.dispose
		}
	}

	private Image? load(ImageType imageType, ImageType? loadIf, Str imageName) {
		// only load image if we're supposed to...
		if (loadIf != null)
			if (loadIf != imageType)
				return null
		
		return images.getOrAdd(imageName) |->Image| {
			log.info("Loading Image $imageName")
			return Image.make(`fan://${typeof.pod}/res/images/${imageName}`)
		}
	}
}

@Js
enum class ImageType {
	title,
	game
}