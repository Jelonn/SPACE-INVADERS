from game_state import GameState
class Game():
    SPACE = 32
    VNUM = 10
    HNUM = 4
    keyStates = {}
    state = GameState.RUNNING
    player = ''
    
    entities = []
    
    @staticmethod
    def addEntity(e):
        Game.entities.append(e);
       
    @staticmethod 
    def isKeyDown(keyC):
        if Game.keyStates.has_key(keyC):
            return Game.keyStates[keyC]
        return 0
