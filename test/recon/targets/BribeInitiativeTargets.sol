// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";

import {IInitiative} from "../../../src/interfaces/IInitiative.sol";
import {IBribeInitiative} from "../../../src/interfaces/IBribeInitiative.sol";
import {DoubleLinkedList} from "../../../src/utils/DoubleLinkedList.sol";
import {Properties} from "../Properties.sol";


abstract contract BribeInitiativeTargets is Test, BaseTargetFunctions, Properties {
    using DoubleLinkedList for DoubleLinkedList.List;

    // NOTE: initiatives that get called here are deployed but not necessarily registered

    function initiative_depositBribe(uint128 boldAmount, uint128 bribeTokenAmount, uint16 epoch, uint8 initiativeIndex) withChecks public {
        IBribeInitiative initiative = IBribeInitiative(_getDeployedInitiative(initiativeIndex));
        
        // clamp token amounts using user balance
        boldAmount = uint128(boldAmount % lusd.balanceOf(user));
        bribeTokenAmount = uint128(bribeTokenAmount % lqty.balanceOf(user));

        initiative.depositBribe(boldAmount, bribeTokenAmount, epoch);
    }

    function initiative_claimBribes(uint16 epoch, uint16 prevAllocationEpoch, uint16 prevTotalAllocationEpoch, uint8 initiativeIndex) withChecks public {        
        IBribeInitiative initiative = IBribeInitiative(_getDeployedInitiative(initiativeIndex));
        
        // clamp epochs by using the current governance epoch
        epoch = epoch % governance.epoch();
        prevAllocationEpoch = prevAllocationEpoch % governance.epoch();
        prevTotalAllocationEpoch = prevTotalAllocationEpoch % governance.epoch();

        IBribeInitiative.ClaimData[] memory claimData = new IBribeInitiative.ClaimData[](1); 
        claimData[0] =  IBribeInitiative.ClaimData({
            epoch: epoch,
            prevLQTYAllocationEpoch: prevAllocationEpoch,
            prevTotalLQTYAllocationEpoch: prevTotalAllocationEpoch
        });

        bool alreadyClaimed = initiative.claimedBribeAtEpoch(user, epoch);

        initiative.claimBribes(claimData);

        // check if the bribe was already claimed at the given epoch
        if(alreadyClaimed) {
            // toggle canary that breaks the BI-02 property
            claimedTwice = true;
        }
    }
}