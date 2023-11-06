// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {ERC721} from "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {IERC721} from "openzeppelin-contracts/contracts/token/ERC721/IERC721.sol";
import {IStudentNft} from "./IStudentNft.sol";

import {IEvaluator} from "./IEvaluator.sol";

contract MyERC721 is IStudentNft, ERC721{

    IEvaluator private evaluator;

    constructor(address _evaluatorAddress) ERC721("LucasNFT", "LucNFT"){
        evaluator = IEvaluator(_evaluatorAddress);
        _mint(address(this), 2);
    }

    function mint(uint256 tokenIdToMint) external {
        uint256 approvedAmount = evaluator.allowance(msg.sender, address(this));
        require(approvedAmount > 0, "cannot mint nft without collateral");

        evaluator.transferFrom(msg.sender, address(this), approvedAmount);
        _mint(msg.sender, tokenIdToMint);
    }

    function burn(uint256 tokenIdToBurn) external {
        _burn(tokenIdToBurn);
    }
}
