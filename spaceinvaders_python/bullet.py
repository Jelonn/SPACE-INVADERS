from entity_type import EntityType
from entity import Entity
from game import Game
from particle import Particle
from rectangle import Rectangle
class Bullet(Entity):
    parent = ''
    def __init__(self, entity):
        self.direction = 1
        self.health = 1
        self.damageP = 2
        self.parent = entity
        self.speed = 5
        self.position = PVector(entity.position.x+entity.size.x/2, entity.position.y)
        self.size = PVector(2,10)
        
    def particlesAtHit(self, entity):
        num = int(random(40, 70))
        for i in range(0, num):
            p = Particle(entity.position)
            Game.addEntity(p)
            
    def update(self):
        self.position.y += self.direction*self.speed
        r1 = Rectangle(self)
        for e in Game.entities:
            if e.getType() in [EntityType.BULLET, EntityType.PARTICLE, self.parent.getType()]:
                continue
            r2 = Rectangle(e)
            if r1.collides(r2):
                self.health = 0
                e.damage(self.damageP)
                self.particlesAtHit(e)
                
    def shouldDispose(self):
        if self.position.y < 0 or self.position.y > height:
            return 1
        return 0
        
    def draw(self):
        fill(255, 0,0)
        rect(self.position.x, self.position.y, self.size.x, self.size.y)
        
    def getType(self):
        return EntityType.BULLET
        
    
