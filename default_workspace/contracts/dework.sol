// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.34;

import {FreelancerProfile,CreateJobListingInput} from "./types/DeworkTypes.sol";

contract Dework {
    uint256 connectFee; //state variable
    address public initialOwner;

    FreelancerProfile[] public freelancerProfiles;
    //EmployerProfile[] public employerProfiles;

    mapping(uint256=>address) public freelancerIdToAddress;

    event FreelancerProfileRegistered(uint256 freelancerId,address caller);

    error Dework_IncorrectJobCreationFee(uint256 expectedFee,uint256 actualFee);

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
) external {
    uint256 freelancerId = getNumberOfRegisteredFreelancers();

    FreelancerProfile memory freelancerProfile = FreelancerProfile({ //struct
        id: freelancerId,
        name: name,
        wallet: msg.sender,
        experienceYears: experienceYears,
        isAvailableHire: true,
        hourlyRateWei: hourlyRateWei
    });

    freelancerProfiles.push(freelancerProfile);
    freelancerIdToAddress[freelancerId]=msg.sender; //map[id]=address

   
    emit FreelancerProfileRegistered(freelancerId,msg.sender); //emit the event

}

function getFreelancerProfile() public view returns(FreelancerProfile[] memory) {
    return freelancerProfiles;
}

function createJobListing(
    uint256 employerId,
    CreateJobListingInput calldata jobListingInput //struct
)external payable{
    uint256 fixedPriceForJob=jobListingInput.fixedPriceInWei; //access struct ele
    if(msg.value!=fixedPriceForJob){
        revert Dework_IncorrectJobCreationFee(fixedPriceForJob,msg.value);
    }

}
}