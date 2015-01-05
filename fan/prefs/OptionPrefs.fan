
@Js
@Serializable
class OptionPrefs {
	
	Duration 	jiffyFrequency		:= 30ms
	Bool 		musicOn				:= true
	Bool 		backgroudParallaxOn	:= true
	
	new make(|This|? f := null) { f?.call(this) }
	
	static OptionPrefs load() {
		Preferences.loadPrefs(OptionPrefs#, "options.fog")
	}

	Void save() {
		Preferences.savePrefs(this, "options.fog")
	}
}


