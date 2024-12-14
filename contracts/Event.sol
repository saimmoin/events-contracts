//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.22;

import "./Oracle.sol";
import "./IEvent.sol";

contract Event is Oracle, IEvent {
    mapping(uint256 => Event) public events;
    uint256 public eventCount;

    modifier onlyEventOwner(uint256 _eventId) {
        require(events[_eventId].owner == msg.sender, "Not the event owner");
        _;
    }

    function createEvent() external {}
}
