pragma solidity >=0.4.25 <0.6.0;

import "./ConvertLib.sol";

contract Paris{

    uint256 public minimumBet = 1;
    uint256 public totalBetOne;
    uint256 public totalBetTwo;
    uint256 public numberOfBets;
    uint256 public maxAmountOfBets = 1000;

    address payable[] public players;

    struct Parieur {
        uint256 amountBet;
        uint16 teamSelected;
    }
//    mapping (address => uint) balances;
    // Address of the player and => the user info
    mapping(address => Parieur) public playerInfo;

    constructor() public {
        minimumBet = 100000000000000;
    }
//
//    event Transfer(address indexed _from, address indexed _to, uint256 _value);
//
//
//    constructor() public {
//        balances[tx.origin] = 10000;
//    }
//
//    function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
//        if (balances[msg.sender] < amount) return false;
//        balances[msg.sender] -= amount;
//        balances[receiver] += amount;
//        emit Transfer(msg.sender, receiver, amount);
//        return true;
//    }
//    //testCommit
//    function getBalanceInEth(address addr) public view returns(uint){
//        return ConvertLib.convert(getBalance(addr),2);
//    }
//
//    function getBalance(address addr) public view returns(uint) {
//        return balances[addr];
//    }
}
