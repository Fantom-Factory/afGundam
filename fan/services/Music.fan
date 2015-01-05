
@Js
class Music {	
	private MusicPlayer? m_musicPlayer
	
	private MusicPlayer? musicPlayer() {
		if (Runtime.isJs) return null

		m_musicPlayer = (m_musicPlayer == null) ? JavaOnlyMusicPlayer() : m_musicPlayer
		return m_musicPlayer		
	}

	Void playTitleTune() {
		musicPlayer?.playTitleTune
	}
	
	Void stop() {
		musicPlayer?.stop
	}
}

@Js
mixin MusicPlayer {
	abstract Void playTitleTune()
	abstract Void stop()
}
