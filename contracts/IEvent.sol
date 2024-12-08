pragma solidity ^0.8.22;

struct Ticket {
    uint256 seatNo;
    uint256 eventId;
    string boughtLocation;
    string eventLocation;
}

interface IEvent {}