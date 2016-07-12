
@Js @NoDoc
class KeysScreen : TitleScreen {
	
	override Void doStartUp() {
		startUpTitleScreen

		menuOptions.add("Return to Main Menu", "", 20, |->| {Ioc.gameWindow.showScreen(MenuScreen())} )
	}
	
	override Void doDrawScreen(Gfx g) {
		drawTitleScreen(g)

		g.drawFont16Centred("KEYS",								 2*20)
		g.drawFont16Centred("----",								 3*20)
		g.drawFont16Centred("Cursor Keys, WASD ...... Move", 	 5*20)
		g.drawFont16Centred("Z, /, CTRL, Space ...... Fire", 	 6*20)
		g.drawFont16Centred("ESC .................... Quit",	 7*20)

		g.drawFont16Centred("CHEAT KEYS",	 					10*20)
		g.drawFont16Centred("----------",	 					11*20)
		g.drawFont16Centred("1 ............ Speed Power Up", 	13*20)
		g.drawFont16Centred("2 ...... Triple Fire Power Up", 	14*20)
		g.drawFont16Centred("3 ........... Energy Power Up", 	15*20)
		g.drawFont16Centred("G .................. God Mode", 	16*20)
		g.drawFont16Centred("C ...... Show Collision Boxes", 	17*20)
	}	
}
