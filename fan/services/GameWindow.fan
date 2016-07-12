using gfx
using fwt

@Js @NoDoc
class GameWindow {
	private static const Log log := Log.get("GameWindow")
	
			Size 	size
	private Window	window

	new make(Str title, Size size) {
		this.size 	= size

		window = Window(null) {
			it.showTrim 	= true
			it.resizable 	= false
			it.size			= size
			it.title 		= title
			it.icon			= Images.icoAlienFactory
		}
				
		window.onClose.add |->| {
			log.info("Bye!")
			
			(window.content as Screen)?.shutDown
	
			Ioc.music.stop
			Ioc.images.disposeAll
			Ioc.sounds.disposeAll
		}
	}

	Void close() {
		window.close
	}
	
	Void onActive(|->| callback) {
		window.onActive.add(callback)
	}
	
	Void repaint() {		
		// required, else we have to click in the screen each time it changes!
		window.children.each |w| { w.repaint; w.focus }
	}

	Void open(Screen startScreen) {
		
		Bool initialised := false
		startFunc := |->| {
			if (!initialised) {
				initialised = true
				startScreen.startUp
			}
		}
		
		window.onOpen.add(startFunc) 
		window.content = startScreen
		window.open
	}

	Void showScreen(Screen newScreen) {
		(window.content as Screen)?.shutDown
		newScreen.startUp
		
		window.content = newScreen
		window.relayout
	}
}
