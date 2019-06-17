import java.util.*; //import biblioteki "uti" javy do programu (w tej bibliotece jest funkcja map)
// pozwala ona na wyliczenie proporcji liczby z jednego zakresu na liczbę z innego zakresu, przykład:
// chcę przeliczyć liczbę 100 która jest z zakresu 0 do 200 na nowy zakres 0 do 400.
// wynikiem funkcji będzie liczba 200 bo 100 jest równo w połowie zakresu 0-100 i liczba z połowy zakresu 0-400 to 200.

final int SPACE = 32;//kod klawisza spacji
final int VNUM = 10; //liczba przeciwników poziomo (ile ma być kolumn przeciwników)
final int HNUM = 4; //liczba przeciwników pionowo (ile ma być rzędów przeciwników)


/*
Cała gra działa na dwóch listach obiektów - liście obiektów które są wyświetlane (zmienna entities) i liście obiektów które właśnie w tej klatce zostały dodane do gry (zmienna entitiesBuffer).
Obiektem jest gracz, przeciwnik, pocisk albo cząsteczka wybuchu
Jeżeli przykładowo w czasie gry gracz naciśnie spację to do gry zostaje dodany nowy obiekt - pocisk. I ten obiekt zostaje dodany do listy nowych obiektów (zmienna entitiesBuffer).
Przed narysowaniem kolejnej klatki gry, gra sprawdza czy w liście nowych obiektów (entitiesBuffer) coś jest. Jeżeli tak to przepisuje wszystkie obiekty z entitiesBuffer to entities.

Potem gra idzie w pętli po każdym obiekcie w zmiennej entities i wykonuje na nim metodę (funkcję) update. Ta funkcja aktualizuje pozycję i inne rzeczy związane z obiektem.
Potem gra znowu idzie od nowa po tej samej zmiennej w pętli i wykonuje na każdym obiekcie metodę draw. Ta metoda rusuje każdy obiekt na ekranie.
I wszystko idzie od początku.


*/

ArrayList<Entity> entities = new ArrayList(); //lista obiektów głównych
ArrayList<Entity> entitiesBuffer = new ArrayList(); //lista nowych obiektów (obiektów do dodania do listy głównej)
HashMap<Integer, Boolean> keys = new HashMap(); //lista przycisków klawiatury i ich stan (naciśnięty/nie naciśnięty)

GameState state = GameState.RUNNING; //Zmienna przechowująca stan gry - odpowiada za to co jest wyświetlane
//Jeżeli zawiera wartość GameState.RUNNING  to jest wyświetlana gra - przeciwnicy,gracz itp
//jeżeli GameState.WIN to czarny ekran i tekst "WYGRAŁEŚ!"
//jeżeli GameState.GAMEOVER to czarny ekran i tekst "KONIEC GRY"

Player player; //zmienna przechowująca obiekt gracza
void setup() { //funkcja setup - kod w niej działa tylko raz na początku programu
  size(800, 600);//ustawienie rozmiaru okienka gry - 800 pikseli na 600 pikseli
  player = new Player();//utwórz nowego gracza za pomocą klasy "Player"
  entities.add(player);//dodaj gracza do listy obiektów 
  

  //Cały ten kod odpowiada za stworzenie przeciwników na górze ekranu
  int vSpace = (width/VNUM)-20;
  for(int x = 1; x <= VNUM; x++){
    for(int y = 1; y <= HNUM; y++){
      Enemy e = new Enemy(x*vSpace,y*30);
      addEntity(e);
    }
  }
  
}

void draw() { //funkcja draw - kod w niej działa przy rysowaniu każdej klatki na ekranie - 60 razy na sekundę
  background(0);//narysowanie czarnego tła
  
  if(state.equals(GameState.RUNNING)){ //jeżeli stan gry to GameState.RUNNING
  
    for(Entity e: entitiesBuffer){//dla każdego nowego obiektu
      entities.add(e);//dodanie obiekt do listy głównych obiektów
    }
    entitiesBuffer.clear(); //wyczyszczenie listy nowych obiektów do dodania
   
    int enemyCount = 0;
    for(Iterator<Entity> it = entities.iterator(); it.hasNext();){ //dla każdego obiektu na liście głównej (użyty iterator do usuwania obiektów przy iteracji)
      Entity e = it.next(); //pobierz aktualny obiekt z iteratora
      e.update();//zaaktualizuj jego pozycję,życie itp
      if(e.shouldDisposeWrapper()){//czy trzeba się go pozbyć
        it.remove();//usuń obiekt z listy głównej (za pomocą iteratora)
      }else if(e.getType().equals(EntityType.ENEMY)){
        enemyCount++;
      }
    }
    for(Entity e: entities){//dla każdego obiektu na liście głównej
      e.draw();//narysuj obiekt
    }
    if(enemyCount == 0){ //jeżeli wszyscy przeciwnicy zostali pokonani to ustaw stan gry na GameState.WIN - wygrana
      state = GameState.WIN;
    }
  }
  
  if(state.equals(GameState.GAMEOVER)){ //jeżeli stan gry to GameState.GAMEOVER - przegrana
    fill(255,255,255); //kolor tekstu - biały
    textSize(30); //ustaw rozmiar tekstu na 30 pikseli
    text("KONIEC GRY", width/2-180, height/2); //narysuj tekst "KONIEC GRY" na ekranie
  }
  
  if(state.equals(GameState.WIN)){//jeżeli stan gry to GameState.WIN - wygrana
    fill(255,255,255); //kolor tekstu - biały
    textSize(30); //ustaw rozmiar tekstu na 30 pikseli
    text("WYGRAŁEŚ!", width/2-170, height/2); //narysuj tekst "WYGRAŁEŚ!" na ekranie
  }
  
}

void addEntity(Entity e){ //funkcja do dodawania nowego obiektu (przeciwnika albo cząsteczek wybuchu)
  entitiesBuffer.add(e);//dodaj obiekt e do listy nowych obiektów
}

boolean isKeyDown(int k){ //funkcja do sprawdzenia czy dany przycisk jest naciśnięty
  if(keys.containsKey(k)){//jeżeli przycisk o danym kodzie jest na liście przycisków
     return keys.get(k); //zwróć stan przycisku z listy
  }
  return false; //przycisku nie ma na liście - nie był naciśnięty
}

void keyPressed(){//funkcja wywoływana kiedy jakiś przycisk został naciśnięty
  keys.put(keyCode,true);//dodaj jego kod do listy przycisków ze stanem true
}
void keyReleased(){//funkcja wywoływana kiedy jakiś przycisk został zwolniony
  keys.put(keyCode,false);//dodaj jego kod do listy przycisków ze stanem false
}
