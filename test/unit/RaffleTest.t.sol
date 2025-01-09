// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Raffle} from "../../src/Raffle.sol";
import {Test} from "../../lib/forge-std/src/Test.sol";
import {HelperConfig} from "../../script/HelperConfig.s.sol";
import {LinkToken} from "../mocks/LinkToken.sol";
import {DeployRaffle} from "../../script/DeployRaffle.s.sol";
import {CodeConstants} from "../../script/HelperConfig.s.sol";

contract RaffleTest is Test,CodeConstants {

Raffle public raffle;
HelperConfig public helperConfig;
 uint256 subscriptionId;
    bytes32 gasLane;
    uint256 automationUpdateInterval;
    uint256 raffleEntranceFee;
    uint32 callbackGasLimit;
    address vrfCoordinatorV2_5;
    LinkToken link;
 address public PLAYER = makeAddr("player");
    uint256 public constant STARTING_USER_BALANCE = 10 ether;
    uint256 public constant LINK_BALANCE = 100 ether;


function setUp() public {
   DeployRaffle deployer= new DeployRaffle();
   (raffle,helperConfig) = deployer.run();
   vm.deal(PLAYER, STARTING_USER_BALANCE);

   HelperConfig.NetworkConfig memory config=  helperConfig.getConfig();
   subscriptionId= config.subscriptionId;
   gasLane=config.gasLane;
   automationUpdateInterval=config.automationUpdateInterval;
   raffleEntranceFee= config.raffleEntranceFee;
   callbackGasLimit= config.callbackGasLimit;
   vrfCoordinatorV2_5=config.vrfCoordinatorV2_5;
   link=LinkToken(config.link);
     vm.startPrank(msg.sender);
        if (block.chainid == LOCAL_CHAIN_ID) {
            link.mint(msg.sender, LINK_BALANCE);
            VRFCoordinatorV2_5Mock(vrfCoordinatorV2_5).fundSubscription(subscriptionId, LINK_BALANCE);
        }
        link.approve(vrfCoordinatorV2_5, LINK_BALANCE);
        vm.stopPrank();


}


}