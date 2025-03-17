# version 0.4.0
# @license MIT

# adding the public wrapper around the variable generates the getter method 
# on the variable

my_favorite_number: public(uint256)
prod_number: public(uint256)
tin_number: public(uint256)

list_of_numbers: public(uint256[5])
index: public(uint256)

@deploy
def __init__():
    self.my_favorite_number = 7
    self.prod_number = 90
    self.tin_number = 10
    self.index = 0
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
def add_numbers(favorite_number:uint256):
    self.list_of_numbers[self.index] = favorite_number
    self.index = self.index + 1