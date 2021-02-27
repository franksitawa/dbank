// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./Token.sol";

contract dBank {

  //assign Token contract to variable
  Token private token;

  //add mappings
  mapping(address=>uint) public etherBalanceOf;
  mapping(address=>uint) public depositStart;
  mapping(address=>uint) public isDeposited;

  //add events

  event Deposit(address indexed user,uint etherAmount,uint timeStart);
  event Withdraw(address indexed user,uint etherAmount,uint depositTime,uint interest);
  //pass as constructor argument deployed Token contract
  constructor(Toke _token) public {
    //assign token deployed contract to variable
    token=_token;
  }

  function deposit() payable public {
    //check if msg.sender didn't already deposited funds
    //check if msg.value is >= than 0.01 ETH

    //increase msg.sender ether deposit balance
    //start msg.sender hodling time
    etherBalanceOf[msg.sender]=etherBalanceOf[msg.sender]+msg.value;
    depositStart[msg.sender]=depositStart[msg.sender]+block.timestamp;
    isDeposited[msg.sender]=true;

    //set msg.sender deposit status to true
    //emit Deposit event
    emit Deposit(msg.sender, msg.value,block.timestamp);
  }

  function withdraw() public {
    //check if msg.sender deposit status is true
    //assign msg.sender ether deposit balance to variable for event
    require(isDeposited[msg.sender]==true,"Error, no previous deposit");
    uint userBalance=etherBalanceOf[msg.sender];

    //check user's hodl time
    uint depositTime= block.timestamp+depositStart[msg.sender];

    //calc interest per second
    uint interestPerSecond=31668017*(etherBalanceOf[msg.sender]/1e16);
    uint interest=interestPerSecond*depositTime;
    //calc accrued interest

    //send eth to user
    msg.sender.transfer(etherBalanceOf[msg.sender]);
    token.mint(msg.sender,interest);
    //send interest in tokens to user



    //reset depositer data
    etherBalanceOf[msg.sender]=0;
    depositStart[msg.sender]=0;
    isDeposited[msg.sender]=false;
    //emit event
    emit Withdraw(msg.sender,userBalance,depositTime,interest);
  }

  function borrow() payable public {
    //check if collateral is >= than 0.01 ETH
    //check if user doesn't have active loan

    //add msg.value to ether collateral

    //calc tokens amount to mint, 50% of msg.value

    //mint&send tokens to user

    //activate borrower's loan status

    //emit event
  }

  function payOff() public {
    //check if loan is active
    //transfer tokens from user back to the contract

    //calc fee

    //send user's collateral minus fee

    //reset borrower's data

    //emit event
  }
}