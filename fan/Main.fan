using util
using gfx
using web
using webmod
using wisp

**
** Gundam :: A horizontally scrolling shoot'em'up
** 
class Main : AbstractMain {
	
	@Opt { help = "Start Web Service"; aliases = ["ws"] }
	Bool webService := false

	@Opt { help = "HTTP port of web service" }
	Int port := 8080
	
	
	override Int run() {
		usage
		
		if (!webService) {
			Gundam().main
			return 0
		}

		if (webService) {
			wisp := WispService {
				it.port = this.port
				it.root = WindowMod(Gundam.windowTitle, Gundam.windowSize, "sys, concurrent, gfx, fwt, afFantomMappy, afGundam", Gundam#)
			}
			return runServices([wisp])			
		}
		
		return 1
	}
}


