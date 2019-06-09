class Rectangle(object):
    def __init__(self, e):
        self.pos = PVector(e.position.x, e.position.y)
        self.size = PVector(e.size.x, e.size.y)
        
    def collides(self, r):
        return (
            self.pos.x < r.pos.x+r.size.x and
            self.pos.x+self.size.x > r.pos.x and
            self.pos.y < r.pos.y+r.size.y and
            self.pos.y+self.size.y > r.pos.y
            )
