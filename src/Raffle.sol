// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;



contract Raffle{

 error Raffle_insufficientAmount();

uint256 private immutable i_entranceFee;
address payable[] private s_players;
uint256 private immutable i_interval;
uint256 private s_lastTimeStamp;

event RaffleEntered(address indexed player);

constructor (uint256 entranceFee, uint256 interval){
    i_entranceFee=entranceFee;
    i_interval=interval;
    s_lastTimeStamp= block.timestamp;
}

function enterRaffle()external payable {
if(msg.value<i_entranceFee){
    revert Raffle_insufficientAmount();
}
s_players.push(payable(msg.sender)); //whenever updating storage variable-> emit an event
emit RaffleEntered(msg.sender);
}

function pickWinner()external{

}

function getEntryFee()public view returns(uint256){
    return i_entranceFee;
}

}