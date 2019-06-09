class Entity(object):
    health = 0
    position = PVector()
    size = PVector()
    
    def __init__(self):
        self.health = 10;
        self.position = PVector()
        self.size = PVector()
    
    def damage(self, amount):
        self.health -= amount;
        if self.health < 0:
            self.health = 0
            
    def shouldDispose(self):
        return 0
    
    def onDeath(self):
        return 0
    
    def shouldDisposeWrapper(self):
        if self.health == 0:
            self.onDeath()
            return 1
        else:
            return self.shouldDispose()
    
    def getType(self):
        return "null"
