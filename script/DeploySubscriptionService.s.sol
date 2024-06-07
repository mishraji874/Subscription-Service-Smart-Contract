// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {SubscriptionService} from "../src/SubscriptionService.sol";

contract DeploySubscriptionService is Script {

    function run() external returns (SubscriptionService) {
        vm.startBroadcast();
        SubscriptionService subscriptionService = new SubscriptionService(200, 1);
        console.log("Deployed at: ", address(subscriptionService));
        vm.stopBroadcast();
        return subscriptionService;
    }
}