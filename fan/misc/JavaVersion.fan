
@Js @NoDoc
class JavaVersion {
	private static const Log log := Log.get("JavaVersion")
	
	static Void assertIsValid() {
		if (!Runtime.isJava) {
			log.info("Not running java - runtime is $Env.cur.runtime")
			return
		}
		
		if (javaVersionNotValid) {
			log.err("Full Screen Mode can not be initialised")
			log.err("Full Screen Mode requires Java2 v1.4 or higher")
			log.err("You are currently using Java version : " + javaVersion)
			log.err("Please update your Java Runtime Environment (JRE)")
			Env.cur.exit(10)
		}
		
		log.info("Java Version OK : $javaVersion")
	}
	
	private static Bool javaVersionNotValid() {
		return (javaVersion == "1.1" ||
				javaVersion == "1.2" ||
				javaVersion == "1.3")
	}

	private static Str javaVersion() {
		Env.cur.vars["java.version"]
	}
}
