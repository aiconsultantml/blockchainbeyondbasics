//SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

contract  FirstSolidity {

    uint256 public BankBalance=50;
    bool  OverDraftFlag = true;
    string  AccountName = "Elon Musk";
    int  NumberOfTransactions = 10;
    address  MetamaskWallet ;
    bytes32  AccountEmail = "Elon@tesla.com";


    function newBalance (uint256 _Amount) public virtual {
      //  _Amount = _Amount - 1;
        BankBalance = BankBalance + _Amount;
    }

    function getNewBalance() public view returns(uint256) {
        return BankBalance;
    }

    struct Transaction {
        string FromName;
        uint256 Amount;
    }

    Transaction public TransactionStruct = Transaction({FromName: "Jeff Bezos", Amount: 25});
    Transaction  TransactionStruct2 = Transaction({FromName: "Bill Gates", Amount: 50});
    Transaction  TransactionStruct3 = Transaction({FromName: "Tim Cook", Amount: 75});

    //This is a Dynamic Array as the [] is empty. 
    //We could have provided [10], whereas the number 10 means array of 10 elements 
   
    Transaction[] public TransactionsList;

    //CallData, Memory, Storage
    
    function addTransactions(string memory _fromName, uint256 _Amount) public { 
        //_fromName = "Blockchain";
        TransactionsList.push(Transaction(_fromName, _Amount));
    }  

    mapping(string => uint256) public TransactionMap;
    function addTransactionsMapping(string memory _fromName, uint256 _Amount) public {
        TransactionMap[_fromName] = _Amount;
    }

    function getTransactionsList(uint256 _Index) external view returns(Transaction memory) {
        return TransactionsList[_Index];
    }

    function getTransactionsListAll() external view returns(Transaction[] memory) {
        return TransactionsList;
    }

}