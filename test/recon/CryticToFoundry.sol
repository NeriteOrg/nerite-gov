
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";

import {console} from "forge-std/console.sol";


contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();
    }


// forge test --match-test test_governance_claimForInitiativeFuzzTest_0 -vv 
 
function test_governance_claimForInitiativeFuzzTest_0() public {

   property_GV01();
  
   vm.roll(256169);
   vm.warp(block.timestamp +3260161);
   vm.prank(0x0000000000000000000000000000000000010000);
   helper_deployInitiative();
  
   vm.roll(270373);
   vm.warp(block.timestamp +3602226);
   vm.prank(0x0000000000000000000000000000000000030000);
   governance_depositLQTY(17);
  
   vm.roll(308818);
   vm.warp(block.timestamp +3771211);
   vm.prank(0x0000000000000000000000000000000000010000);
   governance_allocateLQTY_clamped_single_initiative(0, 15205252162723499549798549773, 133873542249422983867704365);
  
   vm.roll(364433);
   vm.warp(block.timestamp +4218237);
   vm.prank(0x0000000000000000000000000000000000020000);
   governance_registerInitiative(197);
  
   vm.roll(398954);
   vm.warp(block.timestamp +4578472);
   vm.prank(0x0000000000000000000000000000000000020000);
   helper_deployInitiative();
  
   vm.roll(427374);
   vm.warp(block.timestamp +4937813);
   vm.prank(0x0000000000000000000000000000000000020000);
   helper_deployInitiative();
  
   vm.roll(451255);
   vm.warp(block.timestamp +5026129);
   vm.prank(0x0000000000000000000000000000000000010000);
   check_unregisterable_consistecy(45);
  
   vm.roll(451317);
   vm.warp(block.timestamp +5026210);
   vm.prank(0x0000000000000000000000000000000000030000);
   governance_claimForInitiativeFuzzTest(0);
}
			
				
}