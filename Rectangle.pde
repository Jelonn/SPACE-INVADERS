class Rectangle{ //klasa prostokąta - do łatwego sprawdzania czy dwa prostokąty się na siebie nakładają.
//Tak sprawdzamy kolizję między pociskiem a graczem/przeciwnikiem
//Tworzymi prostokąt dla każdego przeciwnika, gracza i dla pocisku
//jeżeli prostokąt pocisku nakłada się na prostokąt któregoś przeciwnika albo gracza to pocisk w niego trafił
  public PVector pos; //pozycja prostokąta
  public PVector size;//rozmiar prostokąta
  
  public Rectangle(){} //pusty konstruktor
  
  public Rectangle(Entity e){ //konstruktor który tworzy prostokąt na bazie jakiegoś obiektu
    this.pos = new PVector(e.position.x, e.position.y); //pozycja taka jak obiektu
    this.size = new PVector(e.size.x, e.size.y); //rozmiar taki jak obiektu
  }
  
  public boolean collides(Rectangle r){ //czy ten prostokąt nakłada się na inny prostokąt r przekazany w argumencie
    if(pos.x < r.pos.x+r.size.x && pos.x+size.x > r.pos.x && pos.y < r.pos.y+r.size.y && pos.y+size.y > r.pos.y){ //liczenie nakładania
      return true; //zwróc prawdę
    }
    //jeżeli się nie nakłada to zwróć fałsz
    return false;
  }
}
