
@Js @NoDoc
class AboutScreen : TitleScreen {
	
	override Void doStartUp() {
		startUpTitleScreen

		menuOptions.add("Return to Main Menu", "", 20, |->| {Ioc.gameWindow.showScreen(MenuScreen())} )
	}
	
	override Void doDrawScreen(Gfx g) {
		drawTitleScreen(g)

		Str title := "GUNDAM $Runtime.version (Fantom)"
		Str under := "".padl(title.size, '-')
		g.drawFont16Centred(title, 2*20)
		g.drawFont16Centred(under, 3*20)
		g.drawFont16Centred("A retro style shoot'em'up!",			 4*20)

		g.drawFont16Centred("Originally written in Java in 2001",	 6*20)
		g.drawFont16Centred("Gundam caught the attention of Sun",	 7*20)
		g.drawFont16Centred("for being the worlds first full   ",	 8*20)
		g.drawFont16Centred("screen Java game.                 ",	 9*20)

		g.drawFont16Centred("Re-written in Fantom in 2013,     ",	11*20)
		g.drawFont16Centred("Gundam now also runs in browsers  ",	12*20)
		g.drawFont16Centred("as pure Javascript!               ",	13*20)

		g.drawFont16Centred("Have fun! - Steve Eynon",				17*20)
		g.drawFont16Centred("www.alienfactory.co.uk",				18*20)
	}	
}
