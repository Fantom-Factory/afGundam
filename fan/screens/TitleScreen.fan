using gfx 
using fwt

@Js
abstract class TitleScreen : Screen {
	
	protected MenuOptions 	menuOptions := MenuOptions()
	protected Random 		random 		:= Random()
	
	StarField3D? starField

	protected Void startUpTitleScreen() {
		Ioc.music.playTitleTune
		onKeyDown.add |Event event| {
			menuOptions.onKeyDown(event)
		}
		menuOptions.escFunc = |->| {Ioc.gameWindow.showScreen(MenuScreen())}		
		starField = StarField3D(Ioc.gameWindow.size)
	}
	
	protected Void drawMenuOption(Gfx g, MenuOption menuOption) {
		if (menuOption.text == "") return

		w := menuOption.text.size * 16
		h := 16
		x := (size.w - w) / 2
		y := menuOption.line * 20

		if (menuOption.selected) {
			g.brush = Color.gray
			g.fillRoundRect(x-1, y-1, w+2, h+2, 4, 4)
			g.drawFont8(menuOption.desc, x, y + 16 + 2)
		}
		
		g.drawFont16(menuOption.text, x, y)
	}
	
	protected Void drawTitleScreen(Gfx g) {
		g.drawImage(Ioc.images.titleBackground, 0, 0)

		if (random.nextBool(30)) {
			Int x := random.nextInt(0..Ioc.gameWindow.size.w - 64 - 50) + 25;
			Int y := random.nextInt(0..Ioc.gameWindow.size.w - 64 - 50) + 25;
			Ioc.sprites.add(Explosion64.make(x, y))
		}
		
		starField.move
		starField.draw(g)
		
		Ioc.sprites.move
		Ioc.sprites.anim
		Ioc.sprites.removeDead
		Ioc.sprites.draw(g, SpriteType.explosion)

		menuOptions.each |menuOption| {
			drawMenuOption(g, menuOption)
		}
		
		// wish I knew what copyright was!
		g.drawFont8Centred("(c)2001,2012 Alien-Factory", size.h - 10)	
		
		g.drawImage(Ioc.images.gundamTech, 10, size.h - 169 - 10)		
	}	
	
}
