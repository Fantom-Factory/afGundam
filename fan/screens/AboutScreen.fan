
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
		
		g.drawFont16Centred("If it moves, shoot it. If it", 	 5*20)
		g.drawFont16Centred("doesn't move, shoot it anyway!",	 6*20)

		g.drawFont16Centred("Use the cursor keys for control",	 8*20)
		g.drawFont16Centred("and CTRL to fire.", 				 9*20)

		g.drawFont16Centred("Shoot Power-Ups for different", 	11*20)
		g.drawFont16Centred("weapons.", 						12*20)

		g.drawFont16Centred("For GUNDAM updates visit", 		14*20)
		g.drawFont16Centred("http://www.alienfactory.co.uk/",	15*20)
	}	
}
