# pragma version 0.4.0

@external
@pure

def for_loop() -> DynArray[uint256, 10]:
    arr: DynArray[uint256, 10] = []

    for i: uint256 in range(9):
        arr.append(i)

    return arr

@external
@pure

def for_loop_start_end() -> DynArray[uint256, 10]:
    arr: DynArray[uint256, 10] = []

    for i: uint256 in range(0, 9):
        arr.append(i)

    return arr