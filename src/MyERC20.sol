// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

//Base
import {IStudentToken} from "./IStudentToken.sol";
import {IEvaluator} from "./IEvaluator.sol";
import {RewardToken} from "./RewardToken.sol";

//Uniswap
import {IUniswapV3Factory} from "../node_modules/@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import {IUniswapV3Pool} from "../node_modules/@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import {ISwapRouter} from "../node_modules/@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import {IQuoter} from "../node_modules/@uniswap/v3-periphery/contracts/interfaces/IQuoter.sol";

import {ERC20} from  "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyERC20 is IStudentToken, ERC20 {

    IEvaluator public evaluator;
    RewardToken public rewardToken;

    IUniswapV3Factory public factory;
    ISwapRouter public router;
    IQuoter public quoter;

    constructor(address _evaluatorAddress, address _rewardTokenAddress, address _factoryAddress, address _routerAddress, address _quoterAddress) ERC20("LucasToken", "LUC"){
        uint256 decimals = decimals();
        uint256 multiplicator = 10 ** decimals;
        uint valueToMint = 10000000 * multiplicator;
        _mint(address(this), valueToMint);

        evaluator = IEvaluator(_evaluatorAddress);
        rewardToken = RewardToken(_rewardTokenAddress);

        factory = IUniswapV3Factory(_factoryAddress);
        router = ISwapRouter(_routerAddress);
        quoter = IQuoter(_quoterAddress);
    }

    function approveAdmin(address spender, uint256 value) public virtual returns(bool){
        address owner = address(this);
        _approve(owner, spender, value);
        return true;
    }

    function giveTokens(address receiver, uint256 value) public virtual returns(bool){
        _transfer(address(this), receiver, value);
        return true;
    }

	function createLiquidityPool() external {
        factory.createPool(address(this), 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2, 500);
    }

	function SwapRewardToken() external{
        address tokenIn = address(evaluator);
        address tokenOut = address(rewardToken);

        uint256 amountOut = 10 ** 18 * 5;

        address poolAddress = factory.getPool(tokenIn, tokenOut, 500);

        IUniswapV3Pool pool = IUniswapV3Pool(poolAddress);
        uint24 fee = pool.fee();

        uint160 sqrtPriceLimitX96 = 0;
        uint256 amountInEstimate = quoter.quoteExactOutputSingle(tokenIn, tokenOut, fee, amountOut, sqrtPriceLimitX96);
        uint256 amountInMaximum = amountInEstimate * 110 / 100;

        ISwapRouter.ExactOutputSingleParams memory params = ISwapRouter.ExactOutputSingleParams({
            tokenIn: tokenIn,
            tokenOut: tokenOut,
            fee: fee,
            recipient: address(this),
            deadline: block.timestamp + 120,
            amountOut: amountOut,
            amountInMaximum: amountInMaximum,
            sqrtPriceLimitX96: sqrtPriceLimitX96
        });

        evaluator.approve(address(router), amountInMaximum);

        router.exactOutputSingle(params);
    } 
}
