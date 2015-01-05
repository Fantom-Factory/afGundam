
fan.afGundam.StaticMap = fan.sys.Obj.$extend(fan.sys.Obj);
fan.afGundam.StaticMap.prototype.$ctor = function() {}
fan.afGundam.StaticMap.prototype.$typeof = function() { return fan.afGundam.StaticMap.$type; }

fan.afGundam.StaticMap.$staticMap = null;
fan.afGundam.StaticMap.staticMap = function() {
	if (fan.afGundam.StaticMap.$staticMap == null) {
		var k = fan.sys.Obj.$type;
		var v = fan.sys.Obj.$type.toNullable();
		fan.afGundam.StaticMap.$staticMap = fan.sys.Map.make(k, v);
	}
	return fan.afGundam.StaticMap.$staticMap;
}

fan.afGundam.StaticMap.get = function(key) {
	return fan.afGundam.StaticMap.staticMap().get(key);
}

fan.afGundam.StaticMap.set = function(key, value) {
	fan.afGundam.StaticMap.staticMap().set(key, value);
}
