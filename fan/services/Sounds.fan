
@Js
class Sounds {
	private static const Log log := Log.get("Sounds")

	private Str:Sound sounds := [:]

	Sound menuMove() 		{ loadSound("MenuMove.wav") }
	Sound menuSelect() 		{ loadSound("MenuSelect.wav") }
	
	Void disposeAll() {
		sounds.each |sound, soundName| {
			log.info("Disposing Sound $soundName")
			sound.stop
		}
	}
	
	private Sound loadSound(Str soundName) {
		if (Runtime.isJs) return SoundJs()
		
		return sounds.getOrAdd(soundName) |->Sound| {
			log.info("Loading Sound $soundName")
			return JavaOnlySound(soundName)
		}
	}
}

@Js
mixin Sound {
	abstract Void play()
	abstract Void stop()
}

@Js
class SoundJs : Sound {
	override Void play() {}
	override Void stop() {}
}
