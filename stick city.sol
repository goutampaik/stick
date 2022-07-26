// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract StickCity is ERC721A, Ownable {
    // Supply
    uint256 public maxSupply = 9999;
    uint256 public freesaleSupply = 9499;

    // States
    bool public freesale = true;

    // URI
    string public baseURI = "ipfs://QmbDf9xpQwm6cN1pY1dsh6eKeq8HBnDzKD8Ym6XhFGiptv/";

    // Constructor
    constructor() ERC721A("STICK CITY", "SC") {}

    // Mint - Functions
    function mint(uint256 _mintAmount) external payable {
        require(totalSupply() + _mintAmount <= maxSupply, "MSG: Max supply exceeded.");
        require(freesale, "MSG: Freesale is not live yet.");
        require(totalSupply() + _mintAmount <= freesaleSupply, "MSG: Freesale max supply exceeded.");

        _safeMint(msg.sender, _mintAmount);
    }

    //Owner Mint
    function ownerMint(uint256 _mintAmount) external payable onlyOwner {
        require(totalSupply() + _mintAmount <= maxSupply, "MSG: Max supply exceeded.");
        _safeMint(msg.sender, _mintAmount);
    }

    // Other - Functions
    function setMaxSupply(uint256 _supply) public onlyOwner {
        maxSupply = _supply;
    }

    function setFreesaleSupply(uint256 _supply) public onlyOwner {
        freesaleSupply = _supply;
    }

    function setFreesale(bool _state) public onlyOwner {
        freesale = _state;
    }


    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }


    function withdraw() external payable onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}