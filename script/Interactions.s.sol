// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}(); // Corrected here
        vm.stopBroadcast();

        console.log("funded FUNDME with %s ", SEND_VALUE);
    }

    function run() external {
        address mostRecentAddressDeployed = DevOpsTools
            .get_most_recent_deployment("FundMe", block.chainid);

        vm.startBroadcast();
        fundFundMe(mostRecentAddressDeployed);

        vm.stopBroadcast();
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();

        FundMe(payable(mostRecentlyDeployed)).withdraw(); // Corrected here
        vm.stopBroadcast();

        console.log("WITHDRAW FUNDME with %s ");
    }

    function run() external {
        address mostRecentAddressDeployed = DevOpsTools
            .get_most_recent_deployment("FundMe", block.chainid);

        vm.startBroadcast();
        withdrawFundMe(mostRecentAddressDeployed);

        vm.stopBroadcast();
    }
}
