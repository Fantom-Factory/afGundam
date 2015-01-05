using gfx
using fwt

@Js @NoDoc
abstract class Screen : Canvas {
	private const static Log 	log 		:= Log.get(Screen#.name)
	
	new make() {
		doubleBuffered = true
	}
	
	virtual Void startUp() {
		Ioc.jiffy.addListener |->| { 
			Desktop.callAsync |->| {
				Ioc.gameWindow.repaint
			}
		}
		doStartUp
	}

	virtual Void shutDown() { 
		doShutDown
		Ioc.jiffy.clearListeners
		Ioc.sprites.clear
	}
	
	override Void onPaint(Graphics g) {
		doDrawScreen(Gfx(g))
	}
	
	protected virtual Void doStartUp()    		{ }
	protected virtual Void doShutDown()   		{ }
	protected virtual Void doDrawScreen(Gfx g)	{ }
	
	protected Void clearScreen(Gfx g) {
		fillScreen(g, Color.black )
	}

	protected Void fillScreen(Gfx g, Color colour) {
		g.brush = colour
		g.fillRect(0, 0, size.w, size.h)
	}

}
