interface Shape {
    getArea();
}

interface Rectangle extends Shape {
    setWidth(width);
    setHeight(height);
}

class RectangleImpl implements Rectangle {
   // ...
}

interface Square extends Shape {
    setSide(side);
}

class SquareImpl implements Square {
    Rectangle rect;
    SquareImpl() { rect = new Rectangle; }
    setSide(side) { rect.setWidth(side); rect.setHeight(side); }
    getArea() { return rect.getArea(); }
}
