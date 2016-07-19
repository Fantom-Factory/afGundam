using build

class Build : BuildPod {
	
	new make() {
		podName = "afGundam"
		summary = "A pure Fantom horizontally scrolling shoot'em'up"
		version = Version("2.1.3")

		meta = [
			"proj.name"			: "Gundam",
			"repo.tags"			: "app",
			"repo.public"		: "false"
		]

		depends = [
			// ---- Core ---------------
			"sys          1.0.68 - 1.0", 
			"concurrent   1.0.68 - 1.0",
			"gfx          1.0.68 - 1.0",
			"fwt          1.0.68 - 1.0",
			"util         1.0.68 - 1.0",
			"afConcurrent 1.0.14 - 1.0",
			
			// ---- Game Libs ----------
			"afFantomMappy 1.0.5 - 1.0",
			"afMicromod    1.0.4 - 1.0",

			// ---- Web Server ---------
			"web    1.0.68 - 1.0",
			"webmod 1.0.68 - 1.0",
			"wisp   1.0.68 - 1.0",
		]

		srcDirs = [`fan/`, `fan/gaming/`, `fan/misc/`, `fan/prefs/`, `fan/screens/`, `fan/services/`, `fan/sprites/`, `fan/utils/`, `fan/web/`]
		resDirs = [`doc/`, `res/icons/`, `res/images/`, `res/levels/`, `res/music/`, `res/sounds/`, `res/web/`]
		
		meta["afBuild.docApi"] = "false"
	}
	
	@Target { help = "Null target for heroku" }
	Void herokuCompile() {
		echo("> herokuCompile() --> null")
	}
}
