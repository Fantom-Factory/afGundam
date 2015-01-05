using build

class Build : BuildPod {
	
	new make() {
		podName = "afGundam"
		summary = "A horizontally scrolling shoot'em'up"
		version = Version("2.0.3")

		meta = [
			"proj.name"			: "Gundam",
			"tags"				: "misc",
			"repo.private"		: "true"
		]

		depends = [
			"sys          1.0.63 - 1.0", 
			"concurrent   1.0.63 - 1.0",
			"gfx          1.0.63 - 1.0",
			"fwt          1.0.63 - 1.0",
			"util         1.0.63 - 1.0",

			// ---- Game Libs ----
			"afFantomMappy 1.0.4 - 1.0",
			"afMicromod    1.0.4 - 1.0",

			// ---- Web Server ----
			"web    1.0",
			"webmod 1.0",
			"wisp   1.0"
		]

		srcDirs = [`fan/`, `fan/web/`, `fan/utils/`, `fan/sprites/`, `fan/services/`, `fan/screens/`, `fan/prefs/`, `fan/misc/`, `fan/gaming/`]
		resDirs = [`res/icons/`, `res/images/`, `res/levels/`, `res/music/`, `res/sounds/`]
		javaDirs= [`java/`]
		jsDirs 	= [`js/`]
	}
	
	override Void compile() {
		super.docApi = false		
		super.compile
	}
}
