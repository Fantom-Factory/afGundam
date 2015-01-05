using fwt

@Js
class HiScoreEntryScreen : HiScoreScreen {
	
	private HiScorePosition hiScorePosition
	
	new make(Int score) {
		this.hiScorePosition = hiScores.newHiScore(score)
	}
	
	override Void doStartUp() { 
		startUpTitleScreen
		
		onKeyDown.add |Event event| {
			if (event.key == Key.enter ||
				event.key == Key.esc) {
					hiScorePosition.editDone
//					hiScores.save
					Ioc.gameWindow.showScreen(HiScoreScreen())
			} else {
				chr := event.key.primary.toStr.lower
				if (chr.isAlphaNum || chr.isSpace) {
					if (event.key.isShift)
						chr = chr.upper
					hiScorePosition.addChar(chr)
				}
			}
		}
	}

	override Void doDrawScreen(Gfx g) {
		super.doDrawScreen(g)
		
		g.drawFont16Centred("Enter Your Name", 20*20)
	}	
}
