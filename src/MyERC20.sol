// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {IStudentToken} from "./IStudentToken.sol";
import {ERC20} from  "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyERC20 is IStudentToken, ERC20 {

    constructor() ERC20("LucasToken", "LUC"){
        uint256 decimals = decimals();
        uint256 multiplicator = 10 ** decimals;
        uint valueToMint = 10000000 * multiplicator;
        _mint(address(this), valueToMint);
    }

    function setUniswapV3Factory(address _uniswapV3Factory) public payable {
        
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

	function createLiquidityPool() external{

    }

	function SwapRewardToken() external{

    }
}
