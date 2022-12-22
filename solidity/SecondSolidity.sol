//SPDX-License-Identifier: MIT


pragma solidity 0.8.8;
import "./FirstSolidity.sol";

contract SecondSolidity{

    FirstSolidity public InstanceFirstSolidity;

    function createFirstSolidity() public {
        InstanceFirstSolidity = new FirstSolidity();
    }
}