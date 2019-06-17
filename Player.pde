class Player extends Entity{ //klasa gracza
  final int maxHealth = 20; //pełne zdrowie - 20 punktów
  final int speed = 8; //prędkość ruchu
  int shootCooldown = 0; //zmienna pomocnicza do blokowania możliwości strzelania
  final int maxShootCooldown = 6; //czas po którym można oddać kolejny strzał
  
  public Player(){ //konstruktor gracza - wywoływany przy tworzeniu gracza
    this.health = maxHealth; //ustaw zdrowie na max (20)
    this.size = new PVector(30, 50); //rozmiar gracza 30x50 pikseli
    this.position.x = width/2-size.x/2; //pozycja gracza na środku ekranu w poziomie
    this.position.y = height-size.y-100; //pozycja 100 pikseli od dołu ekranu
  }
  
  public void update(){ 
    
    //kod do ustawienia czasu pomiędzy strzałami (żeby nie dało się spamować pociskami)
    if(this.shootCooldown > 0){
      this.shootCooldown--;
    }
    
    //po naciśnięciu klawisza w lewo
    if(isKeyDown(LEFT)){
      //rusz się w lewo chyba że ściana
      if(this.position.x <= 0){return;}
      this.position.x -= speed;
    }
    
    //po naciśnięciu klawisza w prawo
    if(isKeyDown(RIGHT)){
      //rusz się w prawo chyba że ściana
      if(this.position.x >= width-size.x){return;}
      this.position.x += speed;
    }
    
    //po naciśnięciu spacji i jeżeli można strzelać
    if(isKeyDown(SPACE) && shootCooldown == 0){
      //utwórz nowy pocisk
      Bullet b = new Bullet(this);
      b.direction = -1; //kierunek pocisku (-1 - w górę)
      addEntity(b); //dodaj pocisk do gry
      shootCooldown = maxShootCooldown; //ustaw czas pomiędzy strzałami
    }
  }
  
  public void draw(){//narysowanie gracza i paska życia
    fill(0, 180,0);//kolor gracza
    rect(this.position.x, this.position.y, size.x, size.y); //prostokąt w pozycji gracza
    fill(30, 30,30);//kolor tła pod paskiem życia
    rect(40, height-40, 100, 10); //prostokąt pod paskiem życia
    int w = (int)map(health, 0, maxHealth, 0, 100);//obliczenie szerokości paska życia
    // (z proporcji - 100 pikseli to max życia 0 to martwy)
    fill(0, 255,0); //kolor paska życia - zielony
    rect(40, height-40, w, 10); //prostokąt paska życia 
    
  }
  
  protected void onDeath(){ //po śmierci gracza ustaw stan gry na GAMEOVER
    state = GameState.GAMEOVER;
  }
  
  public boolean shouldDispose(){return false;}
  public EntityType getType(){
    return EntityType.PLAYER;
  }
}
