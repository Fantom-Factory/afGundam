
@Js
class GamePrefs {
	
	Bool godMode
	Bool debugMode

	Void toggleDebugMode() {
		debugMode = !debugMode
	}

	Void toggleGodMode() {
		godMode = !godMode
	}
}
