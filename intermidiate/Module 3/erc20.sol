// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Shobhit is ERC20 {
    mapping(address => bool) canMint;
    address owner;

    modifier onlyOwner {
        require(owner == msg.sender, "You are not the owner");
        _;
    }
    constructor() ERC20("Shobhit", "SBT") {
        //premint 10 tokens on deployment
        _mint(msg.sender, 10 * 10 ** decimals());
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public {
        require(canMint[msg.sender], "You can't mint this token");
        _mint(to, amount * 10 ** decimals());
    }

    function changeMintableStatus(address _modifingAddress, bool _newStatus) public onlyOwner {
        canMint[_modifingAddress] = _newStatus;
    }
}