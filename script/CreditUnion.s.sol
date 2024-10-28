// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/CreditUnion.sol";

contract DeployCreditUnion is Script {
    function run() external {
        vm.startBroadcast();
        new CreditUnion();
        vm.stopBroadcast();
    }
}
