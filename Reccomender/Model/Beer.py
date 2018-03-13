"""
This class is used to model a beer and rapresent its features
"""

class Beer:
    # Constructor
    def __init__(self, id, name, color, aroma, flavor):
        self.id = id
        self.name = name
        self.color = color
        self.aroma = aroma
        self.flavor = flavor

    # Methods
    def getId(self):
        return self.id
    def setId(self, newId):
        self.id = newId

    def getName(self):
        return self.name
    def setName(self, newName):
        self.name = newName

    def getColor(self):
        return self.color
    def setColor(self, newColor):
        self.color = newColor

    def getAroma(self):
        return self.aroma
    def setAroma(self, newAroma):
        self.aroma = newAroma

    def getFlavor(self):
        return self.flavor
    def setFlavor(self, newFlavor):
        self.flavor = newFlavor