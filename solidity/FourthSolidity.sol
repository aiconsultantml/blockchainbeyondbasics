//SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

import "./FirstSolidity.sol";

contract FourthSolidity is FirstSolidity{

    function newBalance (uint256 _Amount) public override {

        if(_Amount > 10){
           _Amount = _Amount - 1; 
           return FirstSolidity.newBalance(_Amount);
        }

        else if(_Amount == 10){
            _Amount = _Amount + 1; 
            return FirstSolidity.newBalance(_Amount);
        }

        else { 
            return FirstSolidity.newBalance(_Amount);
        }

    }

}