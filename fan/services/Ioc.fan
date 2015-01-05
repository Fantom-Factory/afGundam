using afUtils::Pulsar
using afUtils::StaticData

@Js
const class Ioc {
	private static const StaticData staticData := StaticData(Ioc#) 
	
	static GameWindow gameWindow() {
		get(GameWindow#) |->Obj| {
			throw NullErr("GameWindow has not been set")
		}
	}

	static HUD hud() {
		get(HUD#) |->Obj| {
			throw NullErr("HUD has not been set")
		}
	}

	static ScoreSheet scoreSheet() {
		get(ScoreSheet#)
	}

	static GamePrefs gamePrefs() {
		get(GamePrefs#)
	}

	static JavaMappy javamappy() {
		get(JavaMappy#)
	}

	static Sounds sounds() {
		get(Sounds#)
	}

	static Images images() {
		get(Images#)
	}

	static Sprites sprites() {
		get(Sprites#)
	}

	static Music music() {
		get(Music#)
	}

	static Pulsar jiffy() {
		get(Pulsar#)
	}

	static GameWindow setGameWindow(GameWindow gameWindow) {
		set(gameWindow)
		return gameWindow
	}

	static HUD setHud(HUD hud) {
		set(hud)
		return hud
	}
	
	private static Obj? get(Type serviceType, |->Obj|? factory := null) {
		staticData.getOrAdd(serviceType) {
			(factory == null) ? serviceType.make :  factory()			
		}
	}

	private static Void set(Obj service, Type serviceType := service.typeof) {
		staticData.set(serviceType, service)
	}
}

