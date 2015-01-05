
@Js
class MenuScreen : TitleScreen {

	override Void doStartUp() { 
		startUpTitleScreen
		Ioc.sprites.add(GundamBig())
		Ioc.sprites.add(GunSight())
		
		menuOptions.add("Start Game", 	"", 15, |->| {Ioc.gameWindow.showScreen(PreLoadImagesScreen(ImageType.game, GameScreen()))	} )
		menuOptions.add("About", 		"", 16, |->| {Ioc.gameWindow.showScreen(AboutScreen())	} )
		menuOptions.add("Options", 		"", 17, |->| {Ioc.gameWindow.showScreen(OptionsScreen())} )
		menuOptions.add("Hi-Scores", 	"", 18, |->| {Ioc.gameWindow.showScreen(HiScoreScreen())} )
		
		if (!Runtime.isJs) {
			menuOptions.add("Quit", 	"", 20, |->| {Ioc.gameWindow.close} )
			menuOptions.escFunc = 				|->| {Ioc.gameWindow.close}
		}
	}
	
	override Void doDrawScreen(Gfx g) {
		drawTitleScreen(g)
		
		g.drawImage(Ioc.images.gundamTitle, ((size.w - 418)/2)-40, 20)
		g.drawFont8("$Runtime.version (Fantom)", 200, 100)

		Ioc.sprites.draw(g, SpriteType.player)
		Ioc.sprites.draw(g, SpriteType.alien)
	}
}
