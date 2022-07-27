//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.10;

contract FaceTimeWithWallet{
    uint rate;
    address payable owner;

    struct Appointment{
        string title;
        address attendee;
        uint startTime;
        uint endTime;
        uint amountPaid;
    }

    Appointment[] appointments;

    constructor(){
        owner = payable(msg.sender);
    }

    function getRate() public view returns(uint){
        return rate;
    }

    function setRate(uint _rate) public{
        require(msg.sender == owner, "You are not the owner!");
        rate = _rate;
    }

    function getAppointments() public view returns (Appointment[] memory){
        return appointments;
    }

    function addAppointment(string memory title, uint startTime, uint endTime) public payable{
        Appointment memory appointment;
        appointment.title = title;
        appointment.startTime = startTime;
        appointment.endTime = endTime;
        appointment.amountPaid = ((endTime-startTime)/60)*rate;

        require(msg.value >= appointment.amountPaid, "Please enter an appropritate amount :)");

        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Failed to send Ether");

        appointments.push(appointment);
    }
}
