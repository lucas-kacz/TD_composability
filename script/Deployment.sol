// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Evaluator} from "../src/EvaluatorToken.sol";
import {RewardToken} from "../src/RewardToken.sol";
import {MyERC20} from "../src/MyERC20.sol";

contract DeploymentScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // RewardToken rewardToken = new RewardToken();
        // new Evaluator(rewardToken);

        address factoryAddress = 0x1F98431c8aD98523631AE4a59f267346ea31F984;
        address evaluatorAddress = 0x5cd93e3B0afBF71C9C84A7574a5023B4998B97BE;
        address rewardAddress = 0x56822085cf7C15219f6dC404Ba24749f08f34173;
        address routerAddress = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
        address quoterAddress = 0xb27308f9F90D607463bb33eA1BeBb41C27CE5AB6;

        MyERC20 myErc20 = new MyERC20(evaluatorAddress, rewardAddress, factoryAddress, routerAddress, quoterAddress);

        vm.stopBroadcast();
    }
}
