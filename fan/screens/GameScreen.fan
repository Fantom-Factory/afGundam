using gfx
using fwt

@Js @NoDoc
class GameScreen : Screen {
	
	private HiScorePrefs hiScores	:= HiScorePrefs.load
	private JavaMappy 	javaMappy	:= Ioc.javamappy
	private Sprites 	sprites		:= Ioc.sprites
	private Images 		images		:= Ioc.images
	private PlayerInput playerInput	:= PlayerInput() 
	private HUD 		hud			:= Ioc.setHud(HUD())
	private GundamGame? player1 
	private Int			gameOverCountdown	:= 100 

	override Void doStartUp() {
		Ioc.music.stop
		Ioc.scoreSheet.reset
		
		javaMappy.reset
		
		playerInput.setup(this)
		player1 = GundamGame(playerInput)
		sprites.add(player1)
		hud.reset(player1)
		
		onKeyDown.add |Event event| {
			switch (event.key) {
			case Key.esc:
				if (!player1.dead)
					player1.explode(player1.speed)
				else
					endGame
				
			case Key.num1:
				powerUp(PowerUpType.speedUp)
				
			case Key.num2:
				powerUp(PowerUpType.tripleFire)
				
			case Key.num3:
				powerUp(PowerUpType.extraNrg)
				
			case Key.c:
				Ioc.gamePrefs.toggleDebugMode
				
			case Key.g:
				Ioc.gamePrefs.toggleGodMode
			}
		}	
	}
	
	override Void doDrawScreen(Gfx g) {
		clearScreen(g)
		
		// we don't use g.translate 'cos it's dead slow!
		offsetX := (size.w - javaMappy.gameSize.w) / 2
		offsetY := (size.h - javaMappy.gameSize.h) / 2
		g.offset(offsetX, offsetY)
		g.clip(Rect(offsetX, offsetY, javaMappy.gameSize.w, javaMappy.gameSize.h))
		
		g.drawImage(images.gameBackground, 0, 0)
		
		javaMappy.move		
		javaMappy.draw(g)		
		javaMappy.generateAliens
		
		// God Damn, its Gundam!

		// I like to move it, move it!
		sprites.move

		// Crash!
		sprites.spriteCollision
		sprites.removeDead
		sprites.mapCollision(javaMappy.layerViewer)

		// do some manual layering / depth sorting
		sprites.draw(g, SpriteType.bullet)
		sprites.draw(g, SpriteType.alien)
		sprites.draw(g, SpriteType.player)
		sprites.draw(g, SpriteType.powerUp)
		sprites.draw(g, SpriteType.explosion)
		sprites.draw(g, SpriteType.label)

		hud.draw(g)
		
		sprites.anim
		
		if (player1.dead) {
			gameOverCountdown--
			if (gameOver)
				endGame
		}		
	}
	
	private Bool gameOver() {
		gameOverCountdown < 0
	}
	
	private Void endGame() {
		// callLater else we get SWT disposed exceptions
		fwt::Desktop.callLater(1ms) |->| {
			score := Ioc.scoreSheet.score
			if (hiScores.isHighScore(score)) {
				Ioc.gameWindow.showScreen(HiScoreEntryScreen(score))
			} else
				Ioc.gameWindow.showScreen(MenuScreen())
		}
	}
	
	private Void powerUp(PowerUpType powerUpType) {
		rect	:= Rect2.make(player1.coor.x, player1.coor.y, 1, 1)
		powerUp := PowerUp.makeAt(rect.x, rect.y, powerUpType)
		player1.collided(powerUp, rect)
		powerUp.collided(player1, rect)

	}
}
