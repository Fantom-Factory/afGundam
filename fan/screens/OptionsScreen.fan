using gfx
using fwt

@Js
class OptionsScreen : TitleScreen {

	private OptionPrefs prefs := OptionPrefs.load

	override Void doStartUp() { 
		startUpTitleScreen
		
		desc := "Turn Music On and Off\nNot available in JS"
		menuOptions.add(musicText, 		desc,   6, |MenuOption option| {onChangeMusic(option)} ) 		

		desc = "Turns the non-interactive parallax background On and Off.\nA value of 'Off' is recommended for slower machines."
		menuOptions.add(bgParallaxText, desc, 8, |MenuOption option| {onChangeBgParallax(option)} ) 		

		menuOptions.add("Return to Main Menu", "", 20,  |->| {Ioc.gameWindow.showScreen(MenuScreen())} )
	}

	override Void doDrawScreen(Gfx g) {
		drawTitleScreen(g)
		
		Str title := "GUNDAM Options"
		Str under := "".padl(title.size, '-')
		g.drawFont16Centred(title, 2*20)
		g.drawFont16Centred(under, 3*20)
	}
	
	Void onChangeMusic(MenuOption option) {
		prefs.musicOn = !prefs.musicOn
		prefs.save
		option.text = musicText

		if (prefs.musicOn)
			Ioc.music.playTitleTune
		else
			Ioc.music.stop
	}

	Void onChangeBgParallax(MenuOption option) {
		prefs.backgroudParallaxOn = !prefs.backgroudParallaxOn
		prefs.save
		option.text = bgParallaxText
	}
	
	private Str bgParallaxText() {
		"Background Parallax : " + (prefs.backgroudParallaxOn ? "ON " : "OFF")
	}

	private Str musicText() {
		"Music : " + (prefs.musicOn ? "ON " : "OFF")
	}
	
}
