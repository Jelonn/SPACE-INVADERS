class Enemy extends Entity{ //klasa przeciwnika
  
  final int maxHealth = 10; //pełne zdrowie - 10 punktów
  final int maxVD = 100; //maksymalny ruch w poziomie - 100 pikseli na boki
  int VDSpeed = 1; //prędkość w poziomie
  final int HorizontalHop = 5; //liczba pikseli o jaką przeciwnik ma się obniżać
  int vd = 0; //zmienna pomocnicza do ruchu
  boolean vdMode = true; //kierunek ruchu w poziomie - true w lewo, false w prawo
  
  public Enemy(int x, int y){ //konstruktor przeciwnika - wywoływany przy tworzeniu nowego przeciwnika
    this.position = new PVector(x,y); //ustawienie pozycji
    this.size = new PVector(20, 20); //ustawienie rozmiaru (20 na 20 pikseli)
  }
  
  private void newHorizontalSpeed(){ //ustawienie nowej losowej prędkości w poziomie
    this.VDSpeed = int(random(1,3));
  }
  
  public void update(){
    if(this.position.y > (player.position.y-player.size.y)){ //jeżeli przeciwnik jest poniżej gracza to koniec gry
      state = GameState.GAMEOVER; //ustaw stan gry na GAMEOVER
    }
    
    //Cały kod poniżej odpowiada za ruch przeciwnika - lewo prawo - obniżanie 
    if(vdMode){
      if(vd < maxVD){
        vd += VDSpeed;
        this.position.x += VDSpeed;
      }else{
        vdMode = false;
        this.position.y += HorizontalHop;
        newHorizontalSpeed();
      }
    }else{
      if(vd > 0){
        vd -= VDSpeed;
        this.position.x -= VDSpeed;
      }else{
        vdMode = true;
        this.position.y += HorizontalHop;
        newHorizontalSpeed();
      }
    }
    
    //strzelanie - najpierw losujemy liczbę od 0 do 500
    int i = int(random(500));
    //jeżeli liczba to 0 to strzelamy 
    if(i == 0){
      //generowanie nowego pocisku (Bullet)
      Bullet b = new Bullet(this);
      //kierunek pocisku = 1 - w dół
      b.direction = 1;
      b.speed = 2;//prędkość 2 - nie za szybko
      addEntity(b);//dodanie pocisku do gry
    }
    
  }
  public void draw(){ //rysowanie przeciwnika
    fill(255, 0, 0); //kolor wypełnienia - czerwony
    rect(this.position.x, this.position.y, size.x, size.y); //narysuj kwadrat w miejscu przeciwnika
    fill(0, 200, 100); //kolor paska zdrowia
    int w = (int)map(health, 0, maxHealth, 0, size.x); //szerokość paska zdrowia
    rect(this.position.x, this.position.y+size.y+2, w, 2); //narysuj pasek zdrowia
  }
  
  public boolean shouldDispose(){return false;} //czy pozbyć się przeciwnika z innego powodu niż śmierć - nie
  public EntityType getType(){
    return EntityType.ENEMY; //zwraca typ obiektu ENEMY - przeciwnik
  }
}
