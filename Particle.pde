class Particle extends Entity{ //klasa cząsteczki wybuchu
  
  final PVector[] colors = new PVector[]{ //kolory jakie mogą być przyjęte przez cząsteczki 
    new PVector(255,0,0),
    new PVector(200, 100, 0),
    new PVector(220, 10, 0),
    new PVector(170, 30, 0),
    new PVector(184, 10, 0),
  };
  
  private PVector c; //kolor cząsteczki
  private PVector dir; //kierunek ruchu cząsteczki
  
  public Particle(PVector v){ //konstruktor - wywoływany przy tworzeniu nowej cząsteczki
    this.position = new PVector(v.x, v.y); //ustawienie pozycji  
    this.health = int(random(40, 70)); //ustawienie zdrowia - cząsteczki znikają po krótkim czasie same
    this.c = colors[int(random(0,4))]; //ustawienie losowego koloru z puli
    this.size.x = int(random(3, 8)); //ustawienie losowego rozmiaru (od 3 do 8 pikseli)
    dir = new PVector(random(-1, 1), random(-1, 1)); //ustawienie losowego kierunku ruchu
  }
  
  
  public void update(){ //przy aktualizacji pozycji cząsteczki
    this.damage(1); //zadaj cząstecze 1 obrażeń
    //aktualizacja pozycji cząsteczki
    this.position.x += dir.x;
    this.position.y += dir.y;
  }
  public void draw(){ //przy rysowaniu cząsteczki
    fill(c.x, c.y, c.z); //ustaw kolor wypełnienia
    //narysuj koło w miejscu cząsteczki
    ellipse(position.x, position.y, size.x, size.x);
  }
  
  public boolean shouldDispose(){return false;}
  public EntityType getType(){
    return EntityType.PARTICLE;
  }
}
