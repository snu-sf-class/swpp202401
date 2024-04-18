//
// Car - Wheel, Engine, Body
// User - (1) Wheel -> ...
//        (2) Engine -> ...


// Visitor
interface Visitor {
    void visit(Wheel wheel);
    void visit(Engine engine);
}

// Element or Elements
interface Elements {
    void accept(Visitor visitor); // CarElements have to provide accept().
}



class Wheel implements Elements {
    private String name;

    public Wheel(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void accept(Visitor visitor) {
	/* ... do something ... */
	
        visitor.visit(this);
    }
}

class Engine implements Elements {
    /* ... some implementation ... */
    
    public void accept(Visitor visitor) {
	/* ... do something ... */
	
        visitor.visit(this);
    }
}

class Body implements Elements {
    /* ... some implementation ... */

    public void accept(Visitor visitor) {
	/* do nothing */
    }
}

class Car implements Elements {
    private Wheel[] wheels;
    private Engine engine;
    private Body body;

    public Car() {
	wheels = new Wheel[] {
	    new Wheel("front left"), new Wheel("front right"),
            new Wheel("back left") , new Wheel("back right") };
	engine = new Engine();
	body = new Body();
    }

    public void accept(Visitor visitor) {
	engine.accept(visitor);
	body.accept(visitor);
        for(Wheel element : this.wheels) {
            element.accept(visitor);
        }
    }
}

class DumbVisitor1 implements Visitor {
    public void visit(Wheel wheel) {
        System.out.println("Visiting "+ wheel.getName() + " wheel");
    }

    public void visit(Engine engine) {
        System.out.println("Visiting engine");
    }
}

class DumbVisitor2 implements Visitor {
    public void visit(Wheel wheel) {
        System.out.println("Kicking my "+ wheel.getName() + " wheel");
    }

    public void visit(Engine engine) {
        System.out.println("Starting my engine");
    }
}

class Main {
    static public void main(String[] args){
        Car car = new Car();
        car.accept(new DumbVisitor1());
        car.accept(new DumbVisitor2());
    }
}
