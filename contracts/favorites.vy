# version 0.4.0
# @license MIT

# adding the public wrapper around the variable generates the getter method 
# on the variable

my_favorite_number: public(uint256)
prod_number: public(uint256)
tin_number: public(uint256)

list_of_numbers: public(uint256[5])
index: public(uint256)

struct Person:
   favorite_number: uint256
   name: String[100]

my_name: public(String[100])
my_number: public(uint256)


list_of_people: public(Person[5])

name_to_favoritr_number: public(HashMap[String[100], uint256])



@deploy
def __init__():
    self.my_favorite_number = 7
    self.prod_number = 90
    self.tin_number = 10
    self.index = 0
    self.my_name = "Patrick"

@external
def store(new_number: uint256):
    self.my_favorite_number = new_number * new_number 

@external
def add_two_numbers(new_number: uint256):
    self.tin_number = new_number + new_number

@external
def sub_two_numbers(new_number: uint256, next_number: uint256):
    self.prod_number = new_number - next_number

@external
@view
def retrieve() -> uint256:
    return self.my_favorite_number

@external
def add_persons(name: String[100], favorite_number:uint256):
    # Add favorite number to a list
    self.list_of_numbers[self.index] = favorite_number

    new_person: Person =  Person(favorite_number=favorite_number, name=name)
    self.list_of_people[self.index] = new_person

    self.name_to_favoritr_number[name] = favorite_number
    self.index = self.index + 1