using gfx

@Js @NoDoc
class HUD {
	
	private GundamGame?	player1
	private GundamSmall gundamSmall
	private Size		gameSize		:= Ioc.javamappy.gameSize
	private Images		images 			:= Ioc.images
	private ScoreSheet	scoreSheet		:= Ioc.scoreSheet
	private HiScorePrefs hiScores		:= HiScorePrefs.load
	private Baddy[] 	baddies			:= [,]
	
	new make() {
		x := 5
		y := gameSize.h - 5 - 14 - 37
		gundamSmall = GundamSmall.makeAt(x, y)
	}
	
	Void reset(GundamGame player1) {
		this.player1 = player1
		this.baddies.clear
	}
	
	Void addBaddy(SpriteCollision baddy, Str name, Int iconIndex) {
		baddies.add(Baddy(baddy, name, iconIndex))
	}
	
	Void removeBaddy(SpriteCollision spr) {
		baddies = baddies.exclude |baddy| {
			return baddy.baddy == spr
		}
	}
	
	Void draw(Gfx g) {
		// draw Gundam
		gundamSmall.anim
		gundamSmall.draw(g)
		
		// draw lives
		dstX := gundamSmall.coor.x + 30
		dstY := gundamSmall.coor.y + 17 + 8
		g.drawFont8("x", dstX, dstY)
		dstX +=  8
		dstY += -8
		g.drawFont16("1", dstX, dstY)
		
		// draw Score
		g.drawFont8("Gundam Score", 3, 3)
		g.drawFont16(scoreSheet.score.toStr, 3, 3+8)

		// draw HiScore
		text := "Hi-Score"
		x := (gameSize.w - (text.size * 8)) / 2
		g.drawFont8(text, x, 3)
		text = hiScores.positions[0].score.toStr
		x = (gameSize.w - (text.size * 16)) / 2
		g.drawFont16(text, x, 3+8)

		// draw NRG
		drawHudIcon(g, 0, 0, 6, player1.nrg)

		// draw speed up
		drawHudIcon(g, 1, 0, 0, player1.speedUpCountdown)

		// triple fire
		drawHudIcon(g, 2, 0, 1, player1.tripleFireCountdown)

		// draw baddy NRG levels
		baddies.each |baddy, i| {
			drawHudIcon(g, 4, i, baddy.iconIndex, baddy.nrg)
			dstX = (4 * 128) + 5
			dstY = (i *  32) + gameSize.h - 14 - 5
			dstY -= 10
			g.drawFont8(baddy.name, dstX, dstY)
		}		
	}	
	
	
	private Void drawHudIcon(Gfx g, Int offsetX, Int offsetY, Int iconIndex, Int nrg) {

		// draw icon
		dstX 		:= (offsetX * 128) + 5
		dstY 		:= (offsetY *  32) + gameSize.h - 14 - 5
		srcX 		:= 0
		iconWidth	:= 16
		iconHeight	:= 16
		srcY 		:= (4 * iconHeight)
		srcX		+= (iconIndex % 8) * iconWidth
		srcY		+= (iconIndex / 8) * iconHeight
		g.copyImage(images.hud, Rect(srcX, srcY, iconWidth, iconHeight), Rect(dstX, dstY, iconWidth, iconHeight))

		// draw box
		dstX 		+= 18
		srcX 		 = 0
		srcY 		 = 0
		width		:= 112
		g.copyImage(images.hud, Rect(srcX, srcY, width, iconHeight), Rect(dstX, dstY, width, iconHeight))

		// draw nrg
		srcY = 16
		if (nrg <= 50) {
			srcY += 16
			if (nrg <= 20) {
				srcY += 16
				if (nrg < 0) {
					nrg = 0
				}
			}
		}
		width = nrg + 2
		g.copyImage(images.hud, Rect(srcX, srcY, width, iconHeight), Rect(dstX, dstY, width, iconHeight))
	}	
	
}


@Js @NoDoc
internal class GundamSmall : Sprite2D {
	new makeAt(Int x, Int y) : super.make(36, 33) {
		image 	= Ioc.images.gundamSmall
		coor.x 	= x
		coor.y 	= y
		spriteSheet.maxAnimWait = 6
	}
	
	override Void anim() {
		super.anim
		if (spriteSheet.frameIndex == 2)
			spriteSheet.frameIndex++
	}
}


@Js @NoDoc
internal class Baddy {
	SpriteCollision	baddy
	Int				iconIndex
	Str				name

	new make(SpriteCollision baddy, Str name, Int iconIndex) {
		this.baddy 		= baddy
		this.name		= name
		this.iconIndex 	= iconIndex + 8;		// add 8 'cos the baddy icons start on the next row
	}

	Int nrg() {
		baddy.nrg
	}
}