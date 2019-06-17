class Bullet extends Entity{ //bullet - klasa pocisków
  
  public int direction = 1; //kierunek lotu - (1 albo -1) 
  public int damage = 2; //obrażenia jakie zadaje pocisk
  public EntityType parent; //obiekt który wystrzelił ten pocisk (żeby ten obiekt sam się nie postrzelił...)
  public int speed = 5; //prędkość pocisku
  
  public Bullet(Entity e){ //konstruktor - wywołuje się za każdym razem jak tworzymy nowy pocisk
    this.parent = e.getType(); //ustaw obiekt który wystrzelił pocisk
    this.position = new PVector(e.position.x+e.size.x/2, e.position.y); //ustaw pozycję pocisku na pozycję obiektu który go wystrzelił
    this.size = new PVector(2, 10); //rozmiar pocisku - 2 piksele na 10 pikseli
  }
  
  private void particlesAtHit(Entity e){
    int num = int(random(40, 70));
    for(int i = 0; i < num; i++){
      Particle p = new Particle(e.position);
      addEntity(p);
    }
  }
  
  public void update(){ //funkcja wywoływana przy aktualizacji pozycji pocisku
    this.position.y += direction*speed; //aktualizacja pozycji - nowa pozycja to stara pozycja + kierunek * prędkość
    Rectangle r1 = new Rectangle(this);
    
    /*
    Cały kod poniżej służy do sprawdzenia czy pocisk się z czymś zderzył. 
    Ale jeżeli zderzył się ze strzelającym, innym pociskiem albo cząsteczką to nic się
    nie dzieje
    */
    
    for(Entity e: entities){
      if(e.getType().equals(EntityType.BULLET) || e.getType().equals(parent) || e.getType().equals(EntityType.PARTICLE)){
        continue;
      }
      Rectangle r2 = new Rectangle(e);
      if(r1.collides(r2)){ //jeżeli pocisk się zderzył
        this.health = 0;// "zabij" pocisk
        e.damage(this.damage); //zadaj obrażenia obiektowi z którym pocisk się zderzył
        particlesAtHit(e);
      }
    }
    
  }
  public void draw(){ //funkcja wywoływana przy rysowaniu pocisku
    fill(255, 0,0); // ustaw czerwony kolor wypełnienia
    rect(this.position.x, this.position.y, size.x, size.y); //narysuj prostokąt w pozycji pocisku
  }
  
  public boolean shouldDispose(){return this.position.y > height || this.position.y < 0;} //funkcja mówiąca grze czy pozbyć się pocisku z gry - jeżeli pocisk jest poza oknem to tak
  public EntityType getType(){  //funkcja zwracająca typ obiektu
    return EntityType.BULLET; //zwróć typ obiektu - BULLET - pocisk
  }
}
