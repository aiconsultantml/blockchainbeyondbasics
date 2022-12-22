// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

// import the template for the ERC20 Token creation. 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Initiate a contract that inherits the ERC20 Token creation.
// please note that this is just a sample code, please do not use this code for a 
// production version of your Token. 
contract BBBToken is ERC20 {

    //define the max total supply. This value gets override from the main ERC20.sol
    uint256  _totalSupply = 11000000000 * 10 ** 18;
    mapping(address => uint) public _balances;    

    //Override the total supply. Please note the override keyword
    function totalSupply() public view override returns (uint256) {   
        return _totalSupply;
    }

    //Override the balanceOf. Please note the override keyword
    function balanceOf(address owner) public view override returns (uint256) {
        return _balances[owner];
    }

    // Define the constructor, please note that as soon as the contractor is initiated, 
    // the entire supply will be transferred to the owner of the contract.
    constructor() ERC20("BlockchainBeyondBasics", "BBB") {
         _balances[msg.sender] = _totalSupply;
    }
    
    //Override the transfer. Please note the override keyword. 
    //This function call will transfer the ERC-20 token from the msg.sender to any wallet addr
    //The code is self explanatory.
    function transfer(address to, uint value) public override returns(bool) {
        require(balanceOf(msg.sender) >= value, 'balance too low');
        _balances[to] += value;
        _balances[msg.sender] -= value;
       emit Transfer(msg.sender, to, value);
        return true;
    }
    
    //Override the transfer. Please note the override keyword. 
    //This function call will transfer the ERC-20 token from a wallet addr to any wallet addr
    //The code is self explanatory.    
    function transferFrom(address from, address to, uint value) public override returns(bool)  {
        require(balanceOf(from) >= value, 'balance too low');
        _balances[to] += value;
        _balances[from] -= value;
        emit Transfer(from, to, value);
        return true;   
    }

}