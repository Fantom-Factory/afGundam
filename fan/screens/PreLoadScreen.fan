using gfx::Image
using gfx::Size

@Js @NoDoc
class PreLoadImagesScreen : Screen, ScreenTextWriter {
	private ImageType 	imagesToPreload 
	private Screen 		nextScreen
	
	new make(ImageType imagesToPreload, Screen nextScreen) {
		this.imagesToPreload = imagesToPreload
		this.nextScreen 	 = nextScreen
	}
	
	override Void doDrawScreen(Gfx g) {
		titleText(g)
		if (imagesPreloaded(g, imagesToPreload))
			Ioc.gameWindow.showScreen(nextScreen)
	}
	
	private Bool imagesPreloaded(Gfx g, ImageType imageType) {
		images := Ioc.images.preloadImages(imageType)
		noOfImages := images.size
		
		unloadedNames := images.findAll |image| {
			image.size == Size.defVal
		}.map |Image image->Str| {
			image.uri.name
		}

		if (unloadedNames.isEmpty)
			return true
		
		percent := ((noOfImages - unloadedNames.size) * 100) / noOfImages 
		drawFont8Centred (g, "loading ${imageType} images - ${percent.toStr.justr(3)}%", 	(16 * 12))
		return false
	}
}

