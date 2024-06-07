// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {SubscriptionService} from "../src/SubscriptionService.sol";
import {DeploySubscriptionService} from "../script/DeploySubscriptionService.s.sol";

contract SubscriptionServiceTest is Test {
    SubscriptionService public subscriptionService;
    address public owner;
    address public user1;
    address public user2;

    function setUp() public {
        owner = address(this);
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        subscriptionService = new SubscriptionService(1 ether, 30 days);
    }

    function testSubscribe() public {
        vm.deal(user1, 2 ether);
        vm.prank(user1);
        subscriptionService.subscribe{value: 1 ether}();

        uint256 expiryTimestamp = block.timestamp * 30 days;
        assertEq(subscriptionService.subscriptionExpiry(user1), expiryTimestamp);
    }

    function testSubscribeInsufficientPayment() public {
        vm.deal(user1, 0.5 ether);
        vm.prank(user1);
        vm.expectRevert(bytes("Insufficient payment for subscription."));
        subscriptionService.subscribe{value: 0.5 ether}();
    }

    function testCheckSubscription() public {
        vm.deal(user1, 2 ether);
        vm.prank(user1);
        subscriptionService.subscribe{value: 1 ether}();

        vm.prank(user1);
        bool isSubscribed = subscriptionService.checkSubscription();
        assertTrue(isSubscribed);
    }

    function testRenewSubscription() public {
        vm.deal(user1, 2 ether);
        vm.prank(user1);
        subscriptionService.subscribe{value: 1 ether}();

        vm.warp(block.timestamp + 31 days); // Advance time to after the subscription expires

        vm.deal(user1, 2 ether); // Replenish user1's balance
        vm.prank(user1);
        subscriptionService.renewSubscription{value: 1 ether}();

        uint256 expiryTimestamp = block.timestamp + 30 days * 1 days; // Calculate the new expiry timestamp
        assertEq(subscriptionService.subscriptionExpiry(user1), expiryTimestamp);
    }

    function testRenewSubscriptionActive() public {
        vm.deal(user1, 2 ether);
        vm.prank(user1);
        subscriptionService.subscribe{value: 1 ether}();

        vm.prank(user1);
        vm.expectRevert("Subscription is still active");
        subscriptionService.renewSubscription{value: 1 ether}();
    }

    function testSetSubscriptionFee() public {
        vm.prank(owner);
        subscriptionService.setSubscriptionFee(2 ether);
        assertEq(subscriptionService.subscriptionFee(), 2 ether);
    }

    function testSetSubscriptionFeeNotOwner() public {
        vm.prank(user1);
        vm.expectRevert("Only owner can call this function");
        subscriptionService.setSubscriptionFee(2 ether);
    }

    function testWithdrawFunds() public {
        vm.deal(user1, 2 ether);
        vm.prank(user1);
        subscriptionService.subscribe{value: 1 ether}();

        vm.prank(owner);
        subscriptionService.withdrawFunds();

        uint256 contractBalance = address(subscriptionService).balance;
        assertEq(contractBalance, 0);
    }

    function testWithdrawFundsNotOwner() public {
        vm.prank(user1);
        vm.expectRevert("Only owner can call this function");
        subscriptionService.withdrawFunds();
    }
}