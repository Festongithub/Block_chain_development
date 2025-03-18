# pragma version 0.4.0
# @pure --> do not read any state and global variable
# @view --> read state and global variables

@external
@pure 
def multiply(x:uint256, y: uint256) -> uint256:
    return x * y

@external
@pure 
def divide(x:uint256, y: uint256) -> uint256:
    return x // y

@external
@pure 
def return_many() -> (uint256, bool):
    return (133, True)
