pragma solidity >=0.4.25 <0.6.0;

contract Paris{


    uint256 minimumBet = 0;
    uint256 public totalBetOne;
    uint256 public totalBetTwo;
    uint256 public numberOfBets;
    uint256 public maxAmountOfBets = 1000;
    address payable[] public players;

    struct Player{
        uint256 amountBet;
        uint16 teamSelected;
    }

    //Adress of the player and => the user info
    mapping(address => Player) public playerInfo;





}
