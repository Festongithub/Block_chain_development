# pragma version 0.4.0
"""
@license MIT
@title Buy Me A Coffee!
@author Festus
@notice This contract is for creating a sample funding contract
"""


# Get funds from users
# Withdraw funds
# set a minimum funding value in USD

interface AggregatorV3Interface:
    def decimals() -> uint8: view
    def description() -> String[1000]:view
    def version() -> uint256: view
    def latestAnswer() -> int256: view

MINIMUM_USD: public(constant(uint256)) = as_wei_value(5, "ether")
PRICE_FEED: public(immutable(AggregatorV3Interface))
OWNER: public(immutable(address))

funders: public(DynArray[address, 1000])
PRECISION : constant(uint256) = (1 * (10 ** 18))
# How much is funded
fund_to_amount_funded: public(HashMap[address, uint256])

@deploy
def __init__(price_feed_address: address):
    PRICE_FEED = AggregatorV3Interface(price_feed_address)
    OWNER = msg.sender

@external
@payable
def fund():
    self._fund()

@internal
@payable
def _fund():
    """
    allows users to send money to the application
    """
    usd_value_to_eth: uint256 = self._get_eth_to_usd_rate(msg.value)
    assert usd_value_to_eth > MINIMUM_USD, "You must spend more ETH!"
    self.funders.append(msg.sender)
    self.fund_to_amount_funded[msg.sender] += msg.value


@external
def withdraw():
    """
    Take the money out of the contract, that people send via the fund function
    """
    assert msg.sender == OWNER, "Not the contract owner"
    # send(OWNER, self.balance)
    raw_call(OWNER, b"", value = self.balance)
    for funder: address in self.funders:
        self.fund_to_amount_funded[funder] = 0   
    self.funders = []

@internal
@view
def _get_eth_to_usd_rate(ethe_amount: uint256) -> uint256:
    # Address:  0x694AA1769357215DE4FAC081bf1f309aDC325306
    # ABI:
    price: int256 = staticcall PRICE_FEED.latestAnswer()
    eth_prie: uint256 = convert(price, uint256) * (10 ** 10)

    eth_amount_usd:uint256 =  (ethe_amount * eth_prie) // PRECISION

    return eth_amount_usd

@external
@view
def get_eth_to_usd_rate(eth_amount: uint256) -> uint256:
    return self._get_eth_to_usd_rate(eth_amount)

@external
@payable
def __default__():
    pass

# @external
# @view
# def get_price()-> int256:
#     price_feed: AggregatorV3Interface = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
#     return staticcall price_feed.latestAnswer()

# @external
# @view

# def get_version() -> uint256:
#     eth_version: AggregatorV3Interface = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
#     return staticcall eth_version.version()