
fan.afGundam.PulsarLoop = fan.sys.Obj.$extend(fan.sys.Obj);
fan.afGundam.PulsarLoop.prototype.$ctor = function() {}
fan.afGundam.PulsarLoop.prototype.$typeof = function() { return fan.afGundam.PulsarLoop.$type; }

fan.afGundam.PulsarLoop.make = function() {
	var self = new fan.afGundam.PulsarLoop();
	fan.afGundam.PulsarLoop.make$(self);
	return self;
}
fan.afGundam.PulsarLoop.make$ = function(self) {
	return;
}

fan.afGundam.PulsarLoop.prototype.pulseIn = function(ms, func) {
	window.setTimeout( function() {
		func.call();
	}, ms.toMillis());
}
