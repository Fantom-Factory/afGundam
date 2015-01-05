using gfx::Color
using gfx::Font
using gfx::Graphics
using gfx::Image
using gfx::Size

@Js
class LoadingScreen : Screen, ScreenTextWriter {
	private static const Log log := Log.get("LoadingScreen")

	override Void doStartUp() {
		logVersion
		JavaVersion.assertIsValid

		// do it now 'cos the loading screen looks cool!
		Ioc.javamappy.load
		
		freq := OptionPrefs.load.jiffyFrequency
		Ioc.jiffy.frequency = freq
		Ioc.jiffy.start
		
		Ioc.gameWindow.showScreen(PreLoadImagesScreen(ImageType.title, MenuScreen()))
	}
	
	override Void doDrawScreen(Gfx g) {
		titleText(g)
		
		drawFont8Centred (g, "please click to begin", 	(16 * 12))
	}
	
	private Void logVersion() {
		title := "GUNDAM $Runtime.version"
		under := "".padr(title.size, '=')
		log.info("")
		log.info(title)
		log.info(under)
		log.info("")
	}
}
