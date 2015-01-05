
@Js
class HiScoreScreen : TitleScreen {
	
	protected HiScorePrefs	hiScores	:= HiScorePrefs.load
	
	override Void doStartUp() { 
		startUpTitleScreen
		
		menuOptions.add("Return to Main Menu", "", 20, |->| {Ioc.gameWindow.showScreen(MenuScreen())} )
	}

	override Void doDrawScreen(Gfx g) {
		drawTitleScreen(g)

		Str title := "GUNDAM Hi-Scores"
		Str under := "".padl(title.size, '-')
		g.drawFont16Centred(title, 2*20)
		g.drawFont16Centred(under, 3*20)
		
		hiScores.positions.each |hiScore, index| {
			text := hiScore.screenText(index)
			x := (size.w - (text.size * 16)) / 2
			y := (index+6)*20
			w := text.size * 16
			h := 16
			
			if (hiScore.isBeingEdited) {
				g.brush = gfx::Color.gray
				g.fillRoundRect(x-1, y-1, w+2, h+2, 4, 4)
			}
			
			g.drawFont16(text, x, y)
		}
	}	
}
