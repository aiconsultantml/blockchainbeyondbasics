// SPDX-License-Identifier: MIT

pragma solidity 0.8.8;

contract FifthPayableContracts {
        uint256 public constant MinEth=100 gwei;
        
        address[] public FromAddressList;
        mapping(address => uint256) public FromAddrAmtMap;

        address public immutable ContractOwner;   

        constructor (){
            ContractOwner = msg.sender;
        }    

        //Function to deposit Cryptos to a contract
        function depositCrypto() public payable{
            require(msg.value >= MinEth, "Error - check condition");
            FromAddressList.push(msg.sender);
            FromAddrAmtMap[msg.sender] += msg.value;        
        }


        //Function to Withdraw Cryptos from a contract
        function withdrawCrypto(uint256 _CryptoAmount) public  modifierContractOwner{

           
            //call method: (forward all gas or set gas, returns bool)
            //(bool callSuccess, ) = payable(msg.sender).call{value: _CryptoAmount}("");
            (bool callSuccess, ) = payable(msg.sender).call{value: _CryptoAmount}("");
            require(callSuccess, "My Call failed");

            //transfer - there is a preset 2300 gas cap, errors out when this is not met
            //payable(msg.sender).transfer(_CryptoAmount);
          
             //send- there is a preset 2300 gas cap, returns boolean with the message
            //bool message = payable(msg.sender).send(_CryptoAmount);  
            //require (message, "Failed");
        }

        modifier modifierContractOwner{
            require(msg.sender == ContractOwner, "Access Denied - not allowed to Withdraw");
            _;
        }


        //fallback() external payable{
        //    depositCrypto();
        //}

        string public LastRun;
        
        receive() external payable{
            depositCrypto();
            LastRun="Receive Function";
        }

        fallback() external payable{
            LastRun="Fallback Function";
        }

}