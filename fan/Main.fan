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
	
	@NoDoc
	override Int run() {
		usage
		
		if (!webService) {
			Gundam().main
			return 0
		}

		if (webService) {
			wisp := WispService {
				it.httpPort = this.port
				it.root = GundamMod()
			}
			return runServices([wisp])			
		}
		
		return 1
	}
}


