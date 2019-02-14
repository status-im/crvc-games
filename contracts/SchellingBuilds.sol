pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

/*
GOALS:
- To get people to submit honest binaries
- Treat a release candidate as a schelling point
- Client still voluntarily chooses what release and what contract to follow (should check platform if relevant)
- release candidates should have signatories available to trust
- people who commit and reveal early should win proportionally


TODO:
IF Release has URL and Signature then add to platform build
Needs to be enough for build validators to add to pot
whoever builds last gets to collect pot
war of attrition?
people submit hashes of their build, then reveal
people win if they are in the majority?


the contract address for different platforms is also a shelling point
*/

import "token/ERC20Token.sol";

contract SchellingBuilds {

	struct Signature {
	    bytes32 r;
	    bytes32 s;
	    uint8 v;
	    bytes32 hash;
	    address signer;
	    uint256 stake;
	    bool upvote; // (optional?) approve or disprove a build
	}

	struct Release {
			Release previousRelease;
			Release nextRelease;
			// Release alternateRelease;  // Could have a downward tree
	       // semver.org
	        uint16 major;
	        uint16 minor;
	        uint16 patch;
	        bytes32 ext;
	        // Hashes & Urls
	        string gitremote;
	        bytes20 gitsha1; // git commit hash, TODO: pointer into mango?
	        bytes32 binsha256; // binary hash
	        string[] urls; // ipfs/swarm hash and/or http urls
	        Signature[] signatures; // Release must have at least 1 signature to exist.
	}

	Release public currentRelease;
	string public platform; // Simpler if each platform has it's own contract
	mapping(bytes32 => Release) public binary; // Lookup Release from Binary hash
	ERC20Token public token;

	array private commits; // 

	function openReleaseCandidateRound () external {

	}

	function commitReleaseCandidate (	bytes32 _rcSaltySHA3, bytes32 _urlSaltySHA3) external {
		// require SNT stake
	}

	function revealReleaseCandidate ( 	uint16 _major, uint16 _minor, uint16 _patch,  bytes32 _ext, 
	 																	string calldata _gitremote, bytes20 _gitsha1, bytes32 _binsha256, string calldata _url, bytes32 _salt) external {
	}

	function ratifyReleaseCandidate() private {
		// Order candidates
		// Create new Release with previousRelease as currentRelease
		// set nextRelease in currentRelease to new release 
		// replace currentRelease with new release 
		// add currentRelease hash to binary mapping
	}

	function closeReleaseCandidateRound ()  external {
		// reward / penalize
		ratifyReleaseCandidate();
	}


	constructor(string _platform, address _token) public {
        // Body
        owner = msg.sender;
        platform = _platform;
        token = ERC20Token(_token);
    }

}