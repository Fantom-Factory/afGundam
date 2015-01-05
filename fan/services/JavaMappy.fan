using gfx::Image
using gfx::Point
using gfx::Rect
using gfx::Size
using afFantomMappy

@Js @NoDoc
class JavaMappy : MapController {
	private static const Int SCROLL_SPEED	:= 1
	
			Size?		gameSize
	private Sprites?	sprites
	private OptionPrefs? prefs
	private MappyMap?	map
	private MapViewer? 	mapViewer

	private Int			blockX			:= 0
	private Bool		scrollMap		:= true
	private Bool		scrollParallax	:= true

	Void load() {
		// you can't initialise these in the constructor, ThreadBlock
		sprites		= Ioc.sprites

		fmaStream	:= GundamFma.fmaStream
		map 		= MapLoader.loadMap(fmaStream)

		gameWin		:= Ioc.gameWindow.size
		mapWin		:= map.mapHeader.mapSizeInPixels
		gameSize 	= Size(gameWin.w.min(mapWin.w) , gameWin.h.min(mapWin.h))
		
		renderer	:= FmaRenderer(map.mapHeader, Image.make(`fan://${typeof.pod}/res/levels/GundamLevel.png`))
		mapViewer	= MapViewer(map, renderer, Rect.make(0, 0, gameSize.w, gameSize.h))
	}

	Void reset() {
		mapViewer.coorInPixels = Point(0, 0)
		blockX			= 0
		scrollMap		= true
		scrollParallax	= true
		prefs 			= OptionPrefs.load
	}
	
	Void move() {
		if (!scrollMap) 
			return
		
		scrollParallax = !scrollParallax
		if (scrollParallax)
			scrollLayer(mapViewer.layerViewers[0])
		
		scrollLayer(mapViewer.layerViewers[1])
	}
	
	Void draw(Gfx g) {
		// only draw the Background if we have to...
		if (prefs.backgroudParallaxOn)
			mapViewer.layerViewers[0].draw(g, [BlockLayer.background])

		mapViewer.layerViewers[1].draw(g, [BlockLayer.background])
	}
	
	Void generateAliens() {
		layerViewer := mapViewer.layerViewers[1]
		
		// check if we've moved on to a new block
		if (blockX != layerViewer.coorInBlocks.x) {
			blockX  = layerViewer.coorInBlocks.x
			generateAliensFromMap(layerViewer.layer)
		}
	}

	private Void generateAliensFromMap(Layer layer) {
		blockSize	:= map.mapHeader.blockSizeInPixels
		screenSize	:= Size(gameSize.w / blockSize.w, gameSize.h / blockSize.h) 

		// check map for bad guys
		(0..<screenSize.h).each |blockY| {   
			mappyBlock := layer.blockAt(blockX + screenSize.w, blockY)
			x := gameSize.w
			y := blockY * blockSize.h
			
			// is it a power up?
			if (mappyBlock.userData[1] == 2) {
				// it seems we only ever define speed up!!!
				PowerUpType? type
				switch (mappyBlock.userData[2]) {
					case 1:
						type = PowerUpType.speedUp
					default:
						type = PowerUpType.speedUp
				}
				sprites.add(PowerUp.makeAt(x, y, type))
			}

			// is it an alien?
			if (mappyBlock.userData[1] == 1) {
				switch (mappyBlock.userData[2]) {
					case 1: // astroid32
					sprites.add(Asteroid32.makeAt(x, y))
	
					case 2:	// astroid64
					sprites.add(Asteroid64.makeAt(x, y))
	
					case 3:	// astroid96
					sprites.add(Asteroid96.makeAt(x, y))
					
					case 7:	// drone
					sprites.add(Drone.makeAt(x, y))
					
					case 8:	// spiky pod
					sprites.add(SpikyPod.makeAt(x, y))
					
					case 9:	// fat pod
					sprites.add(FatPod.makeAt(x, y, this))
				}
			}
		}
	}
	
	LayerViewer layerViewer() {
		mapViewer.layerViewers[1]
	}
	
	private Void scrollLayer(LayerViewer layerViewer) {
		layerViewer.translatePixels(SCROLL_SPEED, 0)
		if (layerViewer.coorInPixels.x >= (layerViewer.layer.sizeInPixels.w - gameSize.w))
			mapViewer.coorInPixels = Point(0, 0)
	}
	
	override Void startScrolling() {
		scrollMap = true
	}
	
	override Void stopScrolling() {
		scrollMap = false
	}

}

@Js @NoDoc
mixin MapController {
	abstract Void startScrolling()
	abstract Void stopScrolling()
}
