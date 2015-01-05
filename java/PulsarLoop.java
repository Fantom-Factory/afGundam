package fan.afGundam;

import fan.sys.Duration;
import fan.sys.Func;
import fan.sys.Type;
import fan.sys.Unsafe;
import fan.concurrent.Actor;
import fan.concurrent.ActorPool;
import java.util.Map;
import java.util.HashMap;

public class PulsarLoop extends Actor {

	// ---- Construction ------------------------------------------------------

	// constructor factory called by Foo.make
	public static PulsarLoop make() {
		PulsarLoop self = new PulsarLoop();
		make$(self);
		return self;
	}

	// constructor implementation called by subclasses
	public static void make$(PulsarLoop self) {
		Actor.make$(self, ActorPool.make());
	}

	// ---- Obj ---------------------------------------------------------------

	private static Type type;

	public Type typeof() {
		if (type == null)
			type = Type.find("afUtils::PulsarLoop");
		return type;
	}
	
	// ---- PulsarLoop --------------------------------------------------------

	public void pulseIn(Duration ms, Func f) {
		super.sendLater(ms, new Unsafe(f));
	}
	
	public Object receive(Object msg) {
		Func f = (Func) (((Unsafe) msg).val());
		return f.call();
	}
}
