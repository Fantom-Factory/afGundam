
** Sometimes static data is just too easy to ignore!
@Js @NoDoc
const class StaticData {

	private const Str mapKey
	
	new make(Type namespace) {
		mapKey = namespace.qname
	}

	Bool isEmpty() {
		getMap.isEmpty
	}

	Int size() {
		getMap.size
	}

	@Operator 
	Obj? get(Obj key) {
		getMap.get(key)
	}

	Obj getOrThrow(Obj key) {
		getMap.getOrThrow(key)
	}

	Bool containsKey(Obj key)	{
		getMap.containsKey(key)
	}
	
	Obj[] keys() {
		getMap.keys
	}

	Obj[] vals() {
		getMap.vals
	}

	@Operator 
	This set(Obj key, Obj? val) {
		getMap.set(key, val)
		return this
	}

	This add(Obj key, Obj? val) {
		getMap.add(key, val)
		return this
	}

	Obj getOrAdd(Obj key, |Obj->Obj?| valFunc) {
		getMap.getOrAdd(key, valFunc)
	}
	
	private Obj:Obj? getMap() {
		val := StaticMap.get(mapKey)
		if (val == null) {
			val = [:]
			StaticMap.set(mapKey, val)
		}
		return val
	}
	
}


@Js @NoDoc
native internal class StaticMap {
	
	static Obj? get(Obj key)

	static Void set(Obj key, Obj value)
	
}
