package fan.afGundam;

import fan.sys.*;
import java.util.Map;
import java.util.HashMap;

public class StaticMap extends FanObj {

	// ---- Construction ------------------------------------------------------

	// constructor factory called by Foo.make
	public static StaticMap make() {
		StaticMap self = new StaticMap();
		make$(self);
		return self;
	}

	// constructor implementation called by subclasses
	public static void make$(StaticMap self) {
		// nuffin'
	}

	// ---- Obj ---------------------------------------------------------------

	private static Type type;

	public Type typeof() {
		if (type == null)
			type = Type.find("afGundam::StaticMap");
		return type;
	}
	
	// ---- Static Data -------------------------------------------------------

	private static Map<Object, Object> staticMap = new HashMap<Object, Object>();
	
	public static Object get(Object key) {
		return staticMap.containsKey(key) ? staticMap.get(key) : null;
	}
	
	public static void set(Object key, Object value) {
		staticMap.put(key, value);
	}
}
