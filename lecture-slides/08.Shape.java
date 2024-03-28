interface ShapeI {
  getArea()
}

interface RectangleI extends ShapeI{
   setWidth(width)
   setHeight(height)
}

class Rectangle implements RectangleI {
   // ...
}

interface SquareI extends ShapeI{
   setSide(side)
}

class Square implements SquareI {
   Rectangle rect
   Square() { new Rectangle }
   setSide(side) { rect.setWidth(side); base.setHeight(side) }
   getArea() { return rect.getArea() }
}
