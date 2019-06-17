abstract class Entity{ //abstrakcyjna klasa obiektu. Abstrakcyjna więc nie można zrobić z niej bezpośrednio obiektu
//ale inne obiekty które się poruszają (Player, Enemy, Particle, ..) po niej dziedziczą
  
  int health = 10; //zdrowie obiektu
  
  PVector position = new PVector(); //pozycja obiektu
  PVector size = new PVector(); //rozmiar obiektu
  
  public void damage(int amount){ //funkcja wywoływana kiedy zadajemy obrażenia obiektowi
    this.health -= amount; //odejmij obrażenia od zdrowia
    if(health < 0){health = 0;} //jeżeli zdrowie jest mniejsze od 0 to ustaw je na zero
  }
  
  public abstract void update(); //metoda abstrakcyjna - musi istnieć w klasie obiektu
  public abstract void draw(); //metoda abstrakcyjna - musi istnieć w klasie obiektu
  
  public boolean shouldDisposeWrapper(){ //czy pozbyć się obiektu z gry
    if(health == 0){ //jeżeli zdrowie wynosi 0 to tak
      onDeath();
      return true;
    }
    //a jak zdrowie nie wynosi zero to zapytaj o to obiekt metodą "shouldDispose()"
    return shouldDispose();
  }
  
  protected void onDeath(){} //co ma się stać po śmierci obiektu
  
  public abstract boolean shouldDispose(); //metoda abstrakcyjna - musi istnieć w klasie obiektu
  public abstract EntityType getType(); //metoda abstrakcyjna - musi istnieć w klasie obiektu
}
