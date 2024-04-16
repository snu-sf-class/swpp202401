class A { ... }

class B extends A { ... }

class C extends A { override ...}

------------------------------------

interface Tree {...}.
    
class Leaf implements Tree {
    ...
}
class Node implements Tree {
   chl : list Tree

   chl.get(0)....       
}

      Tree 
    /     \
   Node  Leaf

    Node -> Tree, Tree

--------------------------------
interface A { op0; op1; op2 }
interface B { op0; op3 }

interface AorB extends A, B {
    Boolean isA();
}

interface AandB extends A, B {
}

class AUB {
    Boolean isA() { throw ...; }
    op0() { throw ...; }
    op1() { throw ...; }
    op2() { throw ...; }
    op3() { throw ...; }
}

class A extends AUB {
    isA() { return true; }
    op0() { ... };
    op1() { ... };
    op2() { ... };
}

class B extends AUB {
    isA() { return false; }
    op0() { ... };
    op3() { ... };
}

----------------------

interface AUB {
    Boolean isA();
    op0();
    op1();
    op2();
    op3();
}

class A implements AUB {
    isA() { return true; }
    op0() { ... };
    op1() { ... };
    op2() { ... };
    op3() { throw ... };
}

class B implements AUB {
    isA() { return false; }
    op0() { ... };
    op1() { throw ... };
    op2() { throw ... };
    op3() { ... };
}

-------------------------

What is the problem with the above approaches?   

f(AUB u) {
    u.op0();
    u.op1();  // may trigger exception
}

f(AUB u) {
    u.op0();
    // but has to know op1, op2 are available when isA(); also op3 when not isA().
    if (u.isA()) { u.op1(); u.op2(); } 
    else { u.op3(); }
}

-----------------------
interface AB { op0; }
    
interface A extends AB { op1; op2 }
interface B extends AB { op3 }

interface AUB extends AB {
    A getA();
    B getB();
}

class Aimpl implements A, AUB {
    A getA() { return this; }
    B getB() { return null; }
    op0() { ... };
    op1() { ... };
    op2() { ... };
}

class Bimpl implements B, AUB {
    AI getA() { return null; }
    BI getB() { return this; }
    op0() { ... };
    op3() { ... };
}

f(AUB u) {
    A a;
    B b;
    u.op0();
    if ((a = u.getA()) != null) {
	a.op1(); a.op2();
    } else if ((b = u.getB()) != null) {
	b.op0(); b.op3();
    } else { throw ...; } // impossible case
}

----------------------------------

interface A {...}

class FileStream implements A {
    FileStream();
    read() { ... }
}
    
class ToUpper implements A {
    A base;
    F1(A a) {base = a}
    read() { s = base.read(); return (toUpper(s)); }
    ...
}
