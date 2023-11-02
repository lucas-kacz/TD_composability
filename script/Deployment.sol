// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Evaluator} from "../src/EvaluatorToken.sol";
import {RewardToken} from "../src/RewardToken.sol";
import {MyERC20} from "../src/MyERC20.sol";

contract DeploymentScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY_2");
        vm.startBroadcast(deployerPrivateKey);

        RewardToken rewardToken = new RewardToken();
        new Evaluator(rewardToken);

        MyERC20 myErc20 = new MyERC20();

        vm.stopBroadcast();
    }
}
