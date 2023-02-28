// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract sum100Game {
    address player1;
    address player2;
    address public winner;

    int public sum;
    address public turnOf;

    function joinGame () public payable {
        require(msg.value == 20 ether, "You need to stake required amount");
        require(player2 == address(0), "Game arena is full with 2 players");
        if(player1 == address(0)) {
            player1 = msg.sender;
        } else {
            player2 = msg.sender;
            turnOf = player2;
        }
    }

    function chooseYourNumber(int8 myChoice) public {
        if (turnOf != msg.sender) {
            revert("Buddy it's not your turn");
        }
        int newSum = sum + myChoice;
        if(newSum < sum) {
            revert("Buddy, don't choose -ve number");
        }
        if(newSum == 100) {
            // we have a winner
            winner = msg.sender;
            player1 = address(0);
            player2 = address(0);
            turnOf = address(0);
            sum = 0;
        } else {
            // game is ongoing
            sum += myChoice;
            if(msg.sender == player1) {
                turnOf = player2;
            } else {
                turnOf = player1;
            }
        }
    }

    function withdrawWinnings() public {
       assert(msg.sender == winner); //punish by taking all the gas ;-)
       bool sent = payable(winner).send(40 ether); // winner takes all
       require(sent, "Transfer was unsucessful");
       winner = address(0);
    }
     
}