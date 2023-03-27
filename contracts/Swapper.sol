// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwapper {
    address public owner;
    mapping(address => bool) public allowedTokens;

    event TokensSwapped(address indexed fromToken, address indexed toToken, address indexed sender, uint amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function addAllowedToken(address tokenAddress) public onlyOwner {
        allowedTokens[tokenAddress] = true;
    }

    function removeAllowedToken(address tokenAddress) public onlyOwner {
        allowedTokens[tokenAddress] = false;
    }

    function swapTokens(address fromToken, address toToken, uint amount) public {
        require(allowedTokens[fromToken], "Token not allowed");
        require(IERC20(fromToken).balanceOf(msg.sender) >= amount, "Insufficient balance");

        IERC20(fromToken).transferFrom(msg.sender, address(this), amount);

        uint toAmount = // Calculate the amount of token B to send in exchange for token A
        require(IERC20(toToken).balanceOf(address(this)) >= toAmount, "Insufficient liquidity");

        IERC20(toToken).transfer(msg.sender, toAmount);

        emit TokensSwapped(fromToken, toToken, msg.sender, amount);
    }
}