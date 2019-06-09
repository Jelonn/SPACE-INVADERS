# Importowanie modułów (klas) z innych plików
from game import Game
from entity import Entity
from bullet import Bullet
from player import Player
from enemy import Enemy
from game_state import GameState
from entity_type import EntityType

def keyPressed():
    Game.keyStates[keyCode] = 1
def keyReleased():
    Game.keyStates[keyCode] = 0
    
def setup():
    size(800, 600, P2D)
    
    Game.player = Player()
    Game.addEntity(Game.player)
    
    vSpace = (width/Game.VNUM)-20
    for x in range(1, Game.VNUM):
        for y in range(1, Game.HNUM):
            e = Enemy(x*vSpace, y*30)
            Game.addEntity(e)
            
    
def draw():
    background(0)
    if Game.state == GameState.RUNNING:
        enemyCount = 0
        for e in Game.entities:
            e.update()
            if e.shouldDisposeWrapper():
                Game.entities.remove(e)
            else:
                if e.getType() == EntityType.ENEMY:
                    enemyCount += 1
                
        for e in Game.entities:
            e.draw()
        
        if enemyCount == 0:
            Game.state = GameState.WIN
    if Game.state == GameState.GAMEOVER:
        fill(255,255,255) #kolor tekstu - biały
        textSize(30) #ustaw rozmiar tekstu na 30 pikseli
        text("KONIEC GRY", width/2-180, height/2) #narysuj tekst "KONIEC GRY" na ekranie
    if Game.state == GameState.WIN:
        fill(255,255,255) #kolor tekstu - biały
        textSize(30) #ustaw rozmiar tekstu na 30 pikseli
        text("WYGRALES!", width/2-170, height/2) #narysuj tekst "WYGRAŁEŚ!" na ekranie
            
