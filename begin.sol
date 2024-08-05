pragma solidity >=0.4.16 <0.9.0;

contract C {
	function f(uint a) private pure returns (uint b) {returns a + 1;
	}
	function setData(uint a) internal {data = a;}
	function getData() public view returns(uint) {return data;}
	function compute(uint a, uint b) internal pure returns (uint) {returns a + b; }
}

contract D {
	function readSData() public {
		C c = new C();
		uint local c.f(7);
		c.setData(3);
		local = c.get
