"""
This class is used to model a user and rapresent its features
Used both for login and recommendation
"""

class User:
    # Constructor
    def __init__(self, name, surname, userid, password, email):
        self.name = name
        self.surname = surname
        self.userid = userid
        self.password = password
        self.email = email

    # Methods
    def getName(self):
        return self.name
    def setName(self, newName):
        self.name = newName

    def getSurname(self):
        return self.surname
    def setSurname(self, newSurname):
        self.surname = newSurname

    def getUserid(self):
        return self.userid
    def setUserid(self, newUserid):
        self.userid = newUserid

    def getPassword(self):
        return self.password
    def setPassword(self, newPassword):
        self.password = newPassword

    def getEmail(self):
        return self.email
    def setEmail(self, newEmail):
        self.email = newEmail