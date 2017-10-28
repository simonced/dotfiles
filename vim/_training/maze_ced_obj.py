# -*- coding: utf-8 -*-
import random

#up, right, down, left
directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

WALL = 'XX'
START = 's '
END = 'e '
HOLE = '  '

#Maze object...
class Maze:

    def __init__(self, size):
        self.map = []
        self.size = size    #square sizes only
        self.start = (0, 0)
        self.exit = (0, 0)
        
        for x in range(self.size):
            self.map.append( range(self.size) )
            for y in range(self.size):
                self.map[x][y] = WALL

    #simple display of the maze in text format
    def display(self):
        for x in range(self.size):
            print ''.join(self.map[x])
            
    
    #Can we dig here?
    def diggable(self, loc_, from_):    
        #already digged?
        if self.map[loc_[0]][loc_[1]] != WALL:
            return False
        
        #let's check all 8 directions
        dig_direcs = [(0, 1), (1, 1), (1, 0), (1, -1), (0, -1), (-1, -1), (-1, 0), (-1, 1)]
        no_check_dir = (loc_[0]-from_[0], loc_[1]-from_[1])
        
        #neighboors
        for direc in dig_direcs:
            #we skip where we come from
            if no_check_dir[0]!=0 and direc[0]==-no_check_dir[0]: continue
            if no_check_dir[1]!=0 and direc[1]==-no_check_dir[1]: continue
            
            test_x = loc_[0]+direc[0]
            test_y = loc_[1]+direc[1]
            if self.map[test_x][test_y]!=WALL and (test_x, test_y)!=from_:
                return False
        return True

    
    #From where we start digging x_, y_ (already digged tile)
    def dig(self, x_, y_):

        #we should choose a direction from the ones available only
        randdirs = directions[:]
        random.shuffle(randdirs)
        
        avail = []
        for direc in randdirs:
            test_x = x_+direc[0]
            test_y = y_+direc[1]
            if inside((test_x, test_y), (self.size, self.size)) and \
                self.diggable((test_x, test_y), (x_, y_)):
                avail.append(direc)
                
        #dead end?
        if len(avail)==0:
            return
        
        #then we'll do each one
        for direc in avail:
            
            #dig in next direction
            new_x = x_+direc[0]
            new_y = y_+direc[1]
            
            #we need to check the diggable state for each since we recurse it
            if self.diggable((new_x, new_y), (x_, y_)):
                self.map[new_x][new_y] = HOLE
                #then we dig from our new location
                self.dig(new_x, new_y)
                
            else:
                #but if we are in a good portion and we don't have an exit yet
                #it's time to add one
                if x_>self.size/3 and y_>self.size/3 and self.exit==(0,0):
                    self.map[x_][y_] = END
                    self.exit = (x_, y_)

                
    #base of maze generation
    def generate(self):
        #random start
        x = random.randint(1, self.size/3)
        y = random.randint(1, self.size/3)
        self.start = (x, y)
        self.map[x][y] = START
        self.dig(x, y)


#helpers
########

#inside the limits given?
def inside(loc_, bounds_):
    if loc_[0]>0 and loc_[0]<bounds_[0]-1 and loc_[1]>0 and loc_[1]<bounds_[1]-1:
        return True
        
    return False
    
    
if (__name__=="__main__"):
    #init the thing (space container)
    maze = Maze(30)
    
    #build up the maze
    maze.generate()

    #display the maze
    maze.display()
