using gfx

**
** Gundam :: A horizontally scrolling shoot'em'up
** 
@Js @NoDoc
const class Gundam {
	
	static const Str 	windowTitle	:= "Alien-Factory :: Gundam"
	static const Size 	windowSize 	:= Size(640, 480)
	
	Void main() {
		gameWindow := GameWindow(windowTitle, windowSize)
		Ioc.setGameWindow(gameWindow)		
		Ioc.gameWindow.open(LoadingScreen())
	}
	
}
