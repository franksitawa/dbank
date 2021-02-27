// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;

  //add minter changed event
  event MinterChanged(address indexed from,address to);

  constructor() public payable ERC20("Elikia Bank", "EB") {
    minter=msg.sender;
  }

  //Add pass minter role function

  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
    require(msg.sender==minter,"Error, sender has no minter role");
		_mint(account, amount);
	}

  function passMinterRole(address dBank) public returns (bool){
    require(msg.sender==minter,"Error, sender has no minter role");

    minter=dBank;
    emit MinterChanged(msg.sender,dBank);
    return true;
  }
}