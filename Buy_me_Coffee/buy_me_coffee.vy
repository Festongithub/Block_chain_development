# pragma version 0.4.0
# @license: MIT
# @author: Festus 


# Get funds from users
# Withdraw funds
# set a minimum funding value in USD

interface AggregatorV3Interface:
    def decimals() -> uint8: view
    def description() -> String[1000]:view
    def version() -> uint256: view
    def latestAnswer() -> int256: view

minimum_usd: uint256
price_feed: AggregatorV3Interface

@deploy
def __init__(price_feed_address: address):
    self.minimum_usd = as_wei_value(5, "ether")
    self.price_feed = AggregatorV3Interface(price_feed_address)


@external
@payable
def fund():
    """
    allows users to send money to the application
    """
    usd_value_to_eth: uint256 = self._get_eth_to_usd_rate(msg.value)
    assert usd_value_to_eth > self.minimum_usd, "You must spend more ETH!"

@external
def withdraw():
    pass

@internal
@view
def _get_eth_to_usd_rate(ethe_amount: uint256) -> uint256:
    # Address:  0x694AA1769357215DE4FAC081bf1f309aDC325306
    # ABI:
    price: int256 = staticcall self.price_feed.latestAnswer()
    eth_prie: uint256 = convert(price, uint256) * (10 ** 10)

    eth_amount_usd:uint256 =  (ethe_amount * eth_prie) // (1 * (10 ** 18))

    return eth_amount_usd

@external
@view
def get_eth_to_usd_rate(eth_amount: uint256) -> uint256:
    return self._get_eth_to_usd_rate(eth_amount)
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