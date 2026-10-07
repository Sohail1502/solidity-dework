// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.34;

import {FreelancerProfile} from "./types/DeworkTypes.sol";

contract Dework {
    uint256 connectFee;
    address public initialOwner;

    FreelancerProfile[] public freelancerProfiles;
    //EmployerProfile[] public employerProfiles;

    constructor(address _initialOwner) {
        initialOwner = _initialOwner;
    }
    function getNumberOfRegisteredFreelancers() public view returns(uint256) {
    return freelancerProfiles.length;
}

function registerFreelancerProfile(
    string calldata name,
    uint8 experienceYears,
    uint256 hourlyRateWei
) public {
    uint256 freelancerId = getNumberOfRegisteredFreelancers();

    FreelancerProfile memory freelancerProfile = FreelancerProfile({
        id: freelancerId,
        name: name,
        wallet: msg.sender,
        experienceYears: experienceYears,
        isAvailableHire: true,
        hourlyRateWei: hourlyRateWei
    });

    freelancerProfiles.push(freelancerProfile);
}

function getFreelancerProfile() public view returns(FreelancerProfile[] memory) {
    return freelancerProfiles;
}
}