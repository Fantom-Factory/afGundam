
@Js @NoDoc
const class Runtime {
	
	// FIXME: see Fantom Topic XXXX
	static const Str defVer	:= "2.0.4 (JS)"
	
	static Str version() {
		return isJs ? defVer : Runtime#.pod.version.toStr
	}

	static Bool isJs() {
		Env.cur.runtime == "js"
	}

	static Bool isJava() {
		Env.cur.runtime == "java"
	}

	static Bool isDotNet() {
		Env.cur.runtime == "dotnet"
	}
}
