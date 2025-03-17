# pragma version ^0.4.0

# Referenced data types
# Fixed sized lists

num: public(uint256[5])
# Dynamic arrays
# Mappings
myMap: public(HashMap[address, uint256])

# Structs
struct Person: 
    name: String[5]
    age: uint256

person: public(Person)

@deploy
def __init__():
    self.num[0] = 12
    self.num[1] = 34

    self.myMap[msg.sender] = 1
    self.myMap[msg.sender] = 11

    self.person.name ="Vyper"
    self.person.age = 33

    # copy into memory
    p: Person = self.person
    p.name = "solid"
    p.age = 22
