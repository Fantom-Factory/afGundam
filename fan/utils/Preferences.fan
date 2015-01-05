
**
** This beats the 'Flux#loadOptions' cos this cache works from any Thread! And theirs is goosed with NPEs!
**  
** WARN: You need to set the following environment variables
** 
**     FAN_ENV=util::PathEnv
**     FAN_ENV_PATH=C:/Projects-Fantom/ArtificialLife
** 
** See http://fantom.org/doc/docLang/Env.html#boot
@Js @NoDoc
const class Preferences {
	private static const Log log := Log.get(Preferences#.name)
	
	private const StaticData prefsCache := StaticData(Preferences#)
	
	private static const Preferences instance := Preferences()

	static Obj loadPrefs(Type prefsType, Str name := prefsType.name) {
		instance.loadPrefsInternal(prefsType, name)
	}
	
	static Void savePrefs(Obj prefs, Str name := prefs.typeof.name) {
		if (Runtime.isJs) {
			log.info("Cannot save $name in JS")
			return 
		}
		file := toFile(prefs.typeof, name)
		file.writeObj(prefs, ["indent":2])
	}
	
	static File? toFile(Type prefsType, Str name := prefsType.name) {
		pathUri := `etc/${prefsType.pod.name}/${name}`
		if (Runtime.isJs) {
			log.info("File $pathUri does not exist in JS")
			return null
		}
		
		envFile := Env.cur.findFile(pathUri, false) ?: File(pathUri)
		return envFile.normalize	// normalize gives the full absolute path
	}
	
	static Bool updated(Type prefsType) {
		if (instance.prefsCache.containsKey(prefsType)) {
			CachedPrefs cached := instance.prefsCache[prefsType]
			return cached.modified
		}
		return true
	}
	
	private Obj loadPrefsInternal(Type prefsType, Str name := prefsType.name) {
		if (prefsCache.containsKey(prefsType)) {
			CachedPrefs cached := prefsCache[prefsType] 
			if (!cached.modified) {
				log.debug("Returning cached $prefsType.name $cached.prefs")
				return cached.prefs
			}
		}
		
		// not cached or modified since we loaded cache
		File? file := toFile(prefsType, name)
		Obj? value := null
		try {
			if (file != null && file.exists) {
				log.info("Loading preferences: $file")
				value = file.readObj
			}
		} catch (Err e) {
			log.err("Cannot load options: $file", e)
		}
		
		if (value == null) {
			log.info("Making preferences: $prefsType.name")
			value = prefsType.make				
		}

		prefsCache[prefsType] = CachedPrefs(file, value)
		
		return value
	}
	
}

@Js @NoDoc
internal class CachedPrefs {
  	private File? 		file
  	private DateTime? 	modied
  			Obj 		prefs

	new make(File? f, Obj prefs) {
		this.file 	= f
		this.modied	= f?.modified
		this.prefs 	= prefs
  	}
	
	Bool modified() {
		if (file == null)
			return false
		return file.modified != modied
	}
}