# -*- coding: utf-8 -*-
from game import Game
from entity import Entity
from bullet import Bullet
from entity_type import EntityType
from game_state import GameState
class Player(Entity):
    def __init__(self):
        self.maxHealth = 20
        self.speed = 8
        self.shootCooldown = 0
        self.maxShootCooldown = 6
        self.health = self.maxHealth
        self.size = PVector(30, 50)
        self.position = PVector(width/2-self.size.x/2, height-self.size.y-100)
        
    def update(self):
        if self.shootCooldown > 0:
            self.shootCooldown -= 1
            
        if Game.isKeyDown(LEFT):
            if self.position.x <= 0:
                return
            self.position.x -= self.speed
        
        if Game.isKeyDown(RIGHT):
            if self.position.x >= width-self.size.x:
                return
            self.position.x += self.speed
            
        if Game.isKeyDown(Game.SPACE) and self.shootCooldown == 0:
            b = Bullet(self)
            b.direction = -1
            Game.addEntity(b)
            self.shootCooldown = self.maxShootCooldown

    def draw(self):
        fill(0, 180, 0)
        rect(self.position.x, self.position.y, self.size.x, self.size.y); #prostokąt w pozycji gracza
        fill(30, 30,30); #kolor tła pod paskiem życia
        rect(40, height-40, 100, 10); #prostokąt pod paskiem życia
        w = map(self.health, 0, self.maxHealth, 0, 100); #obliczenie szerokości paska życia
        # (z proporcji - 100 pikseli to max życia 0 to martwy)
        fill(0, 255,0); #kolor paska życia - zielony
        rect(40, height-40, w, 10); #prostokąt paska życia 
        
    def onDeath(self):
        Game.state = GameState.GAMEOVER
        
    def shouldDispose(self):
        return 0
    
    def getType(self):
        return EntityType.PLAYER
