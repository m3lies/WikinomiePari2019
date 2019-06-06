pragma solidity >=0.4.25 <0.6.0;

import "./ConvertLib.sol";

contract Paris{

    uint256 public minimumBet;
    uint256 public totalBetOne;
    uint256 public totalBetTwo;
    uint256 public numberOfBets;
    uint256 public maxAmountOfBets = 1000;

    address payable[] public parieurs;

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

    function checkParieurExists(address parieur) public view returns(bool){
        for(uint256 i = 0; i < parieurs.length; i++){
            if(parieurs[i] == parieur) return true;
        }
        return false;
    }

    function makeBet(uint8 _teamSelected) public payable {
        //The first require is used to check if the player already exist
        require(!checkParieurExists(msg.sender));
        //The second one is used to see if the value sended by the player is
        //Higher than the minum value
        require(msg.value >= minimumBet);

        //We set the player informations : amount of the bet and selected team
        playerInfo[msg.sender].amountBet = msg.value;
        playerInfo[msg.sender].teamSelected = _teamSelected;

        //then we add the address of the player to the players array
        parieurs.push(msg.sender);

        //at the end, we increment the stakes of the team selected with the player bet
        if ( _teamSelected == 1){
            totalBetOne += msg.value;
        }
        else{
            totalBetTwo += msg.value;
        }
    }

    function distributePrizes(uint16 teamWinner) public {
        address payable[1000] memory winners;
        //We have to create a temporary in memory array with fixed size
        //Let's choose 1000
        uint256 count = 0; // This is the count for the array of winners
        uint256 LoserBet = 0; //This will take the value of all losers bet
        uint256 WinnerBet = 0; //This will take the value of all winners bet
        address add;
        uint256 bet;
        address payable playerAddress;
        //We loop through the player array to check who selected the winner team
        for(uint256 i = 0; i < parieurs.length; i++){
            playerAddress = parieurs[i];
            //If the player selected the winner team
            //We add his address to the winners array
            if(playerInfo[playerAddress].teamSelected == teamWinner){
                winners[count] = playerAddress;
                count++;
            }
        }
        //We define which bet sum is the Loser one and which one is the winner
        if ( teamWinner == 1){
            LoserBet = totalBetTwo;
            WinnerBet = totalBetOne;
        }
        else{
            LoserBet = totalBetOne;
            WinnerBet = totalBetTwo;
        }
        //We loop through the array of winners, to give ethers to the winners
        for(uint256 j = 0; j < count; j++){
            // Check that the address in this fixed array is not empty
            if(winners[j] != address(0))
                add = winners[j];
            bet = playerInfo[add].amountBet;
            //Transfer the money to the user
            winners[j].transfer((bet*(10000+(LoserBet*10000/WinnerBet)))/10000 );
        }

        delete playerInfo[playerAddress]; // Delete all the players
        parieurs.length = 0; // Delete all the players array
        LoserBet = 0; //reinitialize the bets
        WinnerBet = 0;
        totalBetOne = 0;
        totalBetTwo = 0;
    }

    function AmountOne() public view returns(uint256){
        return totalBetOne;
    }

    function AmountTwo() public view returns(uint256){
        return totalBetTwo;
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
