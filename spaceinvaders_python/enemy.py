from entity_type import EntityType
from entity import Entity
from bullet import Bullet
from game import Game
class Enemy(Entity):
    def __init__(self, x, y):
        self.maxHealth = 10
        self.health = self.maxHealth
        self.maxVD = 100
        self.VDSpeed = 1
        self.horizontalHop = 5
        self.vd = 0
        self.vdMode = 0
        self.position = PVector(x, y)
        self.size = PVector(20, 20)
        
    def newHorizontalSpeed(self):
        self.VDSpeed = int(random(1,3))
        
    def update(self):
        if self.position.y > Game.player.position.y-Game.player.size.y:
            Game.state = GameState.GAMEOVER
            
        if self.vdMode == 1:
            if self.vd < self.maxVD:
                self.vd += self.VDSpeed
                self.position.x += self.VDSpeed
            else:
                self.vdMode = 0
                self.position.y += self.horizontalHop
                self.newHorizontalSpeed()
        else:
            if self.vd > 0:
                self.vd -= self.VDSpeed
                self.position.x -= self.VDSpeed
            else:
                self.vdMode = 1
                self.position.x += self.horizontalHop
                self.newHorizontalSpeed()
        
        i  = int(random(500))
        if i == 0:
            b = Bullet(self)
            b.direction = 1
            b.speed = 2
            Game.addEntity(b)
            
    def draw(self):
        fill(255, 0, 0)
        rect(self.position.x, self.position.y, self.size.x, self.size.y)
        fill(0, 200, 100)
        w = map(self.health, 0 ,self.maxHealth, 0, self.size.x)
        rect(self.position.x, self.position.y+self.size.y+2, w, 2)
        
    def shouldDispose(self):
        return 0
    
    def getType(self):
        return EntityType.ENEMY
