class Aimpl implements A {
  // data 
    int ..;
    ..;
      
  // functions (methods)
    f();    
    g();      
}

------------------------------

interface Afactory {
    A mkA();
}

interface A {
    int f(int x);
    int g(int x);
}

interface MyJobFactory {
    Myjob mkMyjob(Afactory af);
}
    
interface MyJob {
    myjob();
}
    
class MyjobImpl implements Myjob {
    Afactory afac;
    Myjob(Afactory af) {
	afac = af;
    }
    myjob() {
	A a = afac.mkA();
	a.f(30);
	a.g(40);
    }
}

====================
    
interface WorkerFactory {
  Worker getWorker();
    void yeildWorker(Worker w);
}

interface Worker {
  ...
}

class WorkerFacotry1 implements WorkerFacotry {
    private int numWorkers = 0;
    private Set<Worker> availableWorkers = new HashSet<Worker>();
    public Worker getWorker() {
	if (numWorkers < MAX_WORKERS) {
	    numWorkers++;
	    return new Worker();
	}
	else if (availableWorkers.size() > 0) {
	    Worker worker = availableWorkers.iterator().next();
	    availableWorkers.remove(worker);
	    return worker;
	} else {
	    throw new NoWorkersAvailable();
	}
    }
    public void yieldWorker (Worker worker) {
	//...
    }
}

==============
    
public interface PrinterFactory {
    Printer getPrinter();
}

public interface Printer {
    public void debug (String message); // write out a debug message
    public void error (String message); // write out an error message
}

class Work {
    Printer printer
    Work(PrinterFactory pfac) {
	printer = pfac.getPrinter();
    }
    ...
    doWork() {
	Printer log = printer;
	....
    }
}

Work w1 = new Work(new ConsolePrinter());
Work w2 = new Work(new FilePrinter());
    
-------

interface ComplexFactory {
    Complex fromCartesian();
    Complex fromPolar();
}
