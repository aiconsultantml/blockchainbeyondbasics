//SPDX-License-Identifier: MIT

pragma solidity 0.8.8;
import "./FirstSolidity.sol";

contract ThirdSolidity{

    FirstSolidity[] public FirstSolidityList;

    function createFirstSolidityList() public {
        FirstSolidity InstanceFirstSolidity = new FirstSolidity();
        FirstSolidityList.push(InstanceFirstSolidity);
    }

    function addTransactionsExecute(uint256 _toIndexNumber, string memory _fromName, uint256 _Amount) public {
        FirstSolidity InstanceFirstSolidity = FirstSolidityList[_toIndexNumber];
        InstanceFirstSolidity.addTransactions(_fromName, _Amount);
    }
    
    function getTransactionsListExecute(uint256 _toIndexNumber, uint256 _TransactionIndex) public view returns(FirstSolidity.Transaction memory) {
        FirstSolidity InstanceFirstSolidity = FirstSolidityList[_toIndexNumber];
        return InstanceFirstSolidity.getTransactionsList(_TransactionIndex);
    }
    
}