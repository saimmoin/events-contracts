//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.22;

import "./IEvents.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Event is Ownable, IEvents, ReentrancyGuard {
    constructor(address initialOwner) Ownable(initialOwner) ReentrancyGuard() {}

    IOracle public oracle;

    mapping(uint256 => EventDetails) public events;
    mapping(address => uint256[]) public ownedEvents;
    uint256 public eventId;

    modifier onlyEventOwner(uint256 _eventId) {
        require(events[_eventId].owner == msg.sender, "Not the event owner");
        _;
    }

    modifier goodTime(uint256 _time) {
        require(_time > block.timestamp, "Invalid time");
        _;
    }

    modifier eventExists(uint256 _eventId) {
        require(_eventId <= eventId, "Event does not exist");
        _;
    }

    function createEvent(EventDetails memory _event) public goodTime(_event.time) {
        eventId++;
        require(_event.owner == _msgSender(), "Not the event owner");
        require(_event.totalQntySold == 0, "Event already created");
        require(
            _event.categories.length == _event.tktQnty.length &&
                _event.categories.length == _event.prices.length &&
                _event.categories.length == _event.tktQntySold.length,
            "Invalid categories"
        );

        uint256 _totalTktQnty;
        for (uint256 index = 0; index < _event.categories.length; index++) {
            require(
                _event.tktQntySold[index] == 0,
                "Category qunatity sold must be zero"
            );
            _totalTktQnty = _totalTktQnty + _event.tktQnty[index];
            if (_event.ticketLimited[index] == false) {
                require(
                    _event.tktQnty[index] == 0,
                    "Ticket qunatity must be zero"
                );
            }
        }
        require(_event.totalQuantity == _totalTktQnty, "Invalid quantity");
        events[eventId] = _event;
        ownedEvents[msg.sender].push(eventId);
        emit EventCreated(eventId, msg.sender, _event);
    }

    function buyTicket(BuyTicket memory _buyTicket) public eventExists(_buyTicket.eventId) goodTime(events[_buyTicket.eventId].time) {
        
    }
}
