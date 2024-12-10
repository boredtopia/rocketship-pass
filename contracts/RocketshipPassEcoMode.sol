// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Register {
    function register(address _recipient) public returns (uint256 tokenId) {}
}

contract RocketshipPassEco is ERC721A, Ownable {

    // config
    constructor(address initialOwner)
        ERC721A("Rocketship Pass Eco Class", "ECOPASS")
        Ownable(initialOwner) {
    }
    uint256 public MAX_MINT_PER_WALLET = 5;
    uint256 public START_ID = 1;

    bool public mintEnabled = false;
    string public baseURI = "https://boredtopia.github.io/rocketship-pass/eco.json";

    // start token id
    function _startTokenId() internal view virtual override returns (uint256) {
        return START_ID;
    }

    // metadata
    function setBaseURI(string calldata _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        return baseURI;
    }

    // toggle sale
    function toggleSale() external onlyOwner {
        mintEnabled = !mintEnabled;
    }

    // mint
    function mint(uint quantity, bytes32[] calldata _merkleProof) external {
        require(mintEnabled, "Sale is not enabled");
        require(_numberMinted(msg.sender) + quantity <= MAX_MINT_PER_WALLET, "Over wallet limit");
        
        _mint(msg.sender, quantity);
    }
    function adminMint(uint quantity) external onlyOwner {
        _mint(msg.sender, quantity);
    }

    // aliases
    function numberMinted(address owner) external view returns (uint256) {
        return _numberMinted(owner);
    }
    function remainingSupply() external pure returns (uint256) {
        return 0;
    }

    // https://docs.mode.network/build-on-mode/tutorials/sfs-sequencer-fee-sharing/sfs-registering-a-contract
    /// @dev Registers this contract and assigns the NFT to the owner of this contract
    /// @param sfsContractAddress This address is the address of the SFS contract
    function registerThis(address sfsContractAddress) public onlyOwner returns (uint256 tokenId){
        Register sfsContract = Register(sfsContractAddress);
        return sfsContract.register(Ownable.owner());
    }

}
