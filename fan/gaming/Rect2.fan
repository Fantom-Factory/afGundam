using gfx::Rect

@Js
const class Rect2 : Coordinate {

	** Default instance is 0, 0, 0, 0.
	const static Rect2 defVal := Rect2(0, 0, 0, 0)
	
	const override Int x
	const override Int y
	const Int w
	const Int h
	
	new make(Int x, Int y, Int w, Int h) {
		this.x = x; this.y = y; this.w = w; this.h = h		
	}

	new makeFromRect(Rect r) : this.make(r.x, r.y, r.w, r.h) {}
	
	** Return true if x,y is inside the bounds of this rectangle.
	Bool contains(Int x, Int y) {
		return x >= this.x && x <= this.x+w && y >= this.y && y <= this.y+h
    }

    ** Return true if this rectangle intersects any portion of that rectangle
    Bool intersects(Rect2 that) {
		ax1 := this.x; ay1 := this.y; ax2 := ax1 + this.w; ay2 := ay1 + this.h
		bx1 := that.x; by1 := that.y; bx2 := bx1 + that.w; by2 := by1 + that.h
		return !(ax2 <= bx1 || bx2 <= ax1 || ay2 <= by1 || by2 <= ay1)
	}

	** Compute the intersection between this rectangle and that rectangle.
	** If there is no intersection, then return `null`.
	Rect2? intersection(Rect2 that) {
		ax1 := this.x; ay1 := this.y; ax2 := ax1 + this.w; ay2 := ay1 + this.h
		bx1 := that.x; by1 := that.y; bx2 := bx1 + that.w; by2 := by1 + that.h
		rx1 := ax1.max(bx1); rx2 := ax2.min(bx2)
		ry1 := ay1.max(by1); ry2 := ay2.min(by2)
		rw := rx2 - rx1
		rh := ry2 - ry1
		return (rw <= 0 || rh <= 0) ? null : Rect2(rx1, ry1, rw, rh)
	}

	** Compute the union between this rectangle and that rectangle,
	** which is the bounding box that exactly contains both rectangles.
	Rect2 union(Rect2 that) {
		ax1 := this.x; ay1 := this.y; ax2 := ax1 + this.w; ay2 := ay1 + this.h
		bx1 := that.x; by1 := that.y; bx2 := bx1 + that.w; by2 := by1 + that.h
		rx1 := ax1.min(bx1); rx2 := ax2.max(bx2)
		ry1 := ay1.min(by1); ry2 := ay2.max(by2)
		rw := rx2 - rx1
		rh := ry2 - ry1
		return Rect2(rx1, ry1, rw, rh)
	}

	override Int hash() {
		x.xor(y.shiftl(8)).xor(w.shiftl(16)).xor(w.shiftl(24))
	}

	override Bool equals(Obj? obj) {
	    that := obj as Rect
	    if (that == null) return false
	    return this.x == that.x && this.y == that.y && this.w == that.w && this.h == that.h
    }

	override Str toStr() {
		return "$x,$y,$w,$h"
	}

	
	
	// ---- My Methods --------------------------------------------------------
	
	override This translate(Coordinate coor) {
		Rect2(x + coor.x, y + coor.y, w, h)
	}

	override This offset(Int x, Int y) {
		Rect2(this.x + x, this.y + y, w, h)
	}
	
	Point2 centre() {
		Point2(x + w/2, y + h/2)
	}
	
}
