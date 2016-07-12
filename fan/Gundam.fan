using gfx

**
** Gundam :: A horizontally scrolling shoot'em'up
** 
@Js @NoDoc
const class Gundam {
	
	static const Str 	windowTitle	:= "Gundam :: by :: Alien-Factory"
	static const Size 	windowSize 	:= Size(640, 480)
	
	Void main() {
		gameWindow := GameWindow(windowTitle, windowSize)
		Ioc.setGameWindow(gameWindow)		
		Ioc.gameWindow.open(LoadingScreen())
	}
	
}
