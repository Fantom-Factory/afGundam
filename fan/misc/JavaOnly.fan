using [java] fanx.interop::Interop
using [java] javax.sound.sampled::AudioSystem
using [java] javax.sound.sampled::AudioFormat
using [java] javax.sound.sampled::Clip
using [java] javax.sound.sampled::DataLine$Info as Info
using afMicromod
using concurrent

@NoDoc
class JavaOnlyMusicPlayer : MusicPlayer {
	private const File titleTuneMod := `fan://${typeof.pod}/res/music/DuranDuran.mod`.get  
	
	private Micromod? modPlayer

	override Void playTitleTune() {
		if (modPlayer != null && modPlayer.modFile != titleTuneMod)
			stop
		
		if (OptionPrefs.load.musicOn && modPlayer == null) {
			modPlayer = Micromod(ActorPool(), titleTuneMod)
			modPlayer.play(Channels.mono)
		}
	}
	
	override Void stop() {
		if (modPlayer != null) {
			modPlayer.stop
			modPlayer = null
		}
	}
}

@NoDoc
class JavaOnlySound : Sound {

	private Clip clip
	
	internal new make(Str fileName) {
		soundFile			:= `fan://${typeof.pod}/res/sounds/${fileName}`.get as File
		soundStream 		:= Interop.toJava(soundFile.in)
	    audioInputStream	:= AudioSystem.getAudioInputStream(soundStream)
   	 	audioFormat			:= audioInputStream.getFormat
    	dataLineInfo		:= Info(Clip#->toClass, audioFormat)
        clip 				:= AudioSystem.getLine(dataLineInfo) as Clip
        clip.open(audioInputStream)
		
		this.clip = clip
	}
	
	override Void play() {
		stop
		clip.setFramePosition(0)
		clip.start
	}
	
	override Void stop() {
		if (clip.isRunning) {
			clip.stop
			clip.flush
		}
	}
}