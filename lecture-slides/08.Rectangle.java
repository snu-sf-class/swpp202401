interface SquareFactory {
    Square makeSquare(Double side);
}

interface FreeRatioRectangleFactory {
    FreeRatioRectangle makeRectangle(Double width, Double height);
}

interface RectangleFactory extends SquareFactory, FreeRatioRectangleFactory {
}

interface FreeRatioRectangle extends Rectangle {
    setWidth();
    setHeight();
}

interface RescalableRectangle extends Rectangle {
    setScale(Double scale);
}

interface Square extends Rectangle {
    setSide(Double side);
}

interface GoodRectangle extends RescalableRectangle, Square {
}

interface Rectangle {
    Double getArea();
    Double getPeri();
    ...
}


f(FreeRatioRectangle r) {
    
}

---------------------------------

interface Rectangle {
    Double getArea();
}

public class Square implements Rectangle {
    RectangleImpl r;
    Square(int side) {
	r = new RectangleImpl(side, side);
    }
    public int getArea() { return r.getArea(); }
}

---

public class Square extends RectangleImpl {
    Square(int side) {
	super(side, side);
    }
}

=============
abstract class AbsIterator {
    type T;
    def hasNext: Boolean;
    def next: T;
}
trait RichIterator extends AbsIterator {
    def foreach(f: T => Unit) {
	while (hasNext) {
	    f(next);
	}
    }
}
=============
interface AbsIterator {
    type T;
    def hasNext: Boolean;
    def next: T;
}
interface RichIteractor extends AbsIterator {
    def foreach(f: T => Unit): Unit;
}

class RichIteratorImpl {
    AbsIterator itr;
    RichIteratorImpl(AbsIterator _itr) { itr = _itr; }
    
    def foreach(f: T => Unit) {
	while (itr.hasNext) {
	    f(itr.next);
	}
    }
}
    
    
