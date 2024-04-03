interface BuilderFactory {
    Builder makeBuilder();
}

interface Builder {
    Builder host(String host);
    Builder port(int port);
    Builder ssl(bool ssl);
    Builder timeout(int port);
    Socket build();
}

interface SocketRestricted {
    f();
    g();
}
interface Socket extends SocketRestricted {
    open();
    close();
}

foo (BuilderFactory factory) {
    Socket s1 = factory.makeBuilder().port(80).build();
    Scoket s2 = factory.makeBuilder().hostname("me").build();
}

class SocketImpl implements Socket, SocketRestricted {
    SocketImpl();
    finalize();
    open();
    close();
    f();
    g();
}
