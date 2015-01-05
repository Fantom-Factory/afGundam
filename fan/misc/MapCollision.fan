using afFantomMappy::Layer
using afFantomMappy::LayerViewer

@Js
mixin MapCollision {
	
	abstract Bool hit()
	
	abstract Void mapCollisionDetection(LayerViewer layerViewer)
	
	** Can't use Coordinate, 'cos it encourages you to use a Coor, which clips the offsets!
	protected Bool isCollisionAt(LayerViewer layerViewer, Point2 colPoint) {

		// compensate for current map scrolling
		colPoint = colPoint.offset(layerViewer.coorInPixels.x, 0)

		// sometimes sprites can get bounced out of the map
		layer := layerViewer.layer
		if ((colPoint.x < 0) || (colPoint.x >= layer.sizeInPixels.w))
			return false
		if ((colPoint.y < 0) || (colPoint.y >= layer.sizeInPixels.h))
			return false

		// do collision test
		return layer.isCollisionAt(colPoint.x, colPoint.y)
	}

}
