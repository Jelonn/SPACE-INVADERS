from entity_type import EntityType
from entity import Entity
class Particle(Entity):
    def __init__(self, e):
        self.color = PVector(200, 100, 0)
        self.dir = PVector(random(-1, 1), random(-1, 1))
        self.position = PVector(e.x, e.y)
        self.health = int(random(40, 70))
        self.size.x = int(random(3,8))
        
    def update(self):
        self.damage(1)
        self.position.x += self.dir.x
        self.position.y += self.dir.y
        
    def draw(self):
        fill(self.color.x, self.color.y, self.color.z)
        ellipse(self.position.x, self.position.y, self.size.x, self.size.x)
        
    def shouldDispose(self):
        return 0
    
    def getType(self):
        return EntityType.PARTICLE
