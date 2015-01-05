using gfx
using fwt

** 
** Sticky Key Syndrome
** http://cancerberonia.blogspot.com/2010/01/problem-with-keyboard-event-handling-in.html
** http://stackoverflow.com/questions/7371142/why-isnt-key-released-event-sent-when-two-keys-are-pressed
** https://bugs.eclipse.org/bugs/show_bug.cgi?id=50020
** 
@Js
class PlayerInput {

	private Int rapidFireWait	:= 0

	Bool	enter
	Bool	escape

	Bool 	up
	Bool	down
	Bool	left
	Bool	right
	
	Bool	fire
	Bool	walk
	Bool	debug
	
	Void setup(Widget widget) {
		widget.onKeyDown.add |Event event| { onKeyDown(event) }
		widget.onKeyUp.add   |Event event| { onKeyUp(event)	  }		
	}
	
	private Void onKeyDown(Event event) {
		setField(event.key, true)
	}

	private Void onKeyUp(Event event) {
		setField(event.key, false)
	}
	
	private Void setField(Key key, Bool wibble) {
		switch (key) {
			
		case Key.enter:
		case Key.keypadEnter:
		    enter = wibble
		case Key.esc:
			escape = wibble
			
		case Key.up:
		case Key.w:
			up = wibble
		case Key.down:
		case Key.s:
			down = wibble
		case Key.left:
		case Key.a:
			left = wibble
		case Key.right:
		case Key.d:
			right = wibble
			
		case Key.z:
		case Key.slash:
		case Key.space:
		case Key.shift:
		case Key.ctrl:
			fire = wibble
		case Key.w:
			walk = wibble
		case Key.c:
			debug = wibble
		}
	}
	
	Bool moving() {
		up || down || left || right
	}

	Bool firing(Bool reset := false) {
		ret := fire && (rapidFireWait == 0)
		if (reset)
			rapidFire
		return ret
	}
		
	private Void rapidFire() {
		if (fire) {
			rapidFireWait ++
			if (rapidFireWait >= 10) 
				rapidFireWait = 0
		} else {
			// instant reload if you take your finger off
			rapidFireWait = 0
		}
	}
}
