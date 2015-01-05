
@Js
@Serializable{collection=true}
class HiScorePrefs {
	
	internal static const Int maxNameSize := 12
	
	@Transient
	HiScorePosition[] positions		:= [,] 
	
	new make(|This|? f := null) { f?.call(this) }
	
	static HiScorePrefs load() {
		HiScorePrefs prefs := Preferences.loadPrefs(HiScorePrefs#, "hiScores.fog")
		return prefs.setDefaults
	}

	Void save() {
		Preferences.savePrefs(this, "hiScores.fog")
	}
	
	Bool isHighScore(Int score) {
		return score > positions[-1].score
	}

	HiScorePosition newHiScore(Int score) {
//		position := HiScorePosition("".padl(maxNameSize, '_'), score)
		position := HiScorePosition("", score)
		positions = positions.add(position).sort.getRange(0..<10)
		return position.edit
	}
	
	private This setDefaults() {
		if (positions.isEmpty) {
			add(HiScorePosition("Slimer", 500000))
			add(HiScorePosition("Slimer", 400000))
			add(HiScorePosition("Slimer", 300000))
			add(HiScorePosition("Slimer", 200000))
			add(HiScorePosition("Slimer", 100000))
			add(HiScorePosition("Slimer",  80000))
			add(HiScorePosition("Slimer",  60000))
			add(HiScorePosition("Slimer",  40000))
			add(HiScorePosition("Slimer",  20000))
			add(HiScorePosition("Slimer",  10000))
		}
		return this
	}
	
	// ---- serialization -----------------------------------------------

	Void add(HiScorePosition position) {
		positions.add(position)
	}
	
	Void each(|HiScorePosition| f) {
		positions.each { f(it) }
	}
}

@Js
@Serializable{simple=true}
class HiScorePosition {
	
	Str name
	Int score
	private Bool editing
	
	new make(Str name, Int score) {
		this.name = name
		this.score = score
	}
	
	Str screenText(Int index) {
		(index+1).toStr.justr(2) + ") " + score.toStr.padl(8, ' ') + ".." + name.padl(HiScorePrefs.maxNameSize, '.')
	}

	Void addChar(Str char) {
		name += char
		if (name.size > HiScorePrefs.maxNameSize)
			name = name.getRange(-HiScorePrefs.maxNameSize..-1)
	}	
	
	This edit() {
		editing = true
		return this
	}

	This editDone() {
		editing = false
		return this
	}
	
	Bool isBeingEdited() {
		editing
	}
	
	override Int compare(Obj obj) {
		(obj as HiScorePosition).score <=> score
	}
	
	// ---- serialization -----------------------------------------------
	
	override Str toStr() {
		return "$name = $score"
	}

	static HiScorePosition fromStr(Str inStr) {
		s := inStr.split('=')
		if (s.size != 2)
			throw ParseErr("Invalid HiScorePosition : $inStr")
		return HiScorePosition(s[0].trim, s[1].trim.toInt)
	}
}
