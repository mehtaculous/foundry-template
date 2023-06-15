// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "src/tokens/NFT721.sol";
import "src/tokens/NFT1155.sol";
import "src/tokens/Token.sol";

contract BaseTest is Test {
    // Contracts
    Token token;
    NFT721 nft721;
    NFT1155 nft1155;

    // Users
    address alice;
    address bob;
    address eve;
    address susan;

    // State
    uint256 tokenId = 1;

    // Constants
    uint256 constant BALANCE = 100 ether;
    uint256 constant NFT_SUPPLY = 1;
    uint256 constant TOKEN_SUPPLY = 1000 * 10e18;

    // Errors
    bytes ERC20_INSUFFICIENT_ALLOWANCE_ERROR =
        bytes("ERC20: insufficient allowance");
    bytes ERC721_NOT_APPROVED_ERROR =
        bytes("ERC721: caller is not token owner or approved");
    bytes ERC1155_NOT_APPROVED_ERROR =
        bytes("ERC1155: caller is not token owner or approved");

    /// =====================
    /// ===== MODIFIERS =====
    /// =====================

    modifier prank(address _caller) {
        vm.startPrank(_caller);
        _;
        vm.stopPrank();
    }

    /// =================
    /// ===== SETUP =====
    /// =================

    function setUp() public {
        alice = _createUser("alice");
        bob = _createUser("bob");
        eve = _createUser("eve");
        susan = _createUser("susan");

        token = new Token();
        nft721 = new NFT721();
        nft1155 = new NFT1155();

        vm.label(address(this), "BaseTest");
        vm.label(address(token), "Token");
        vm.label(address(nft721), "NFT721");
        vm.label(address(nft1155), "NFT1155");
    }

    /// ================
    /// ===== MINT =====
    /// ================

    function testMint20() public {
        // execute
        _mint20(alice, TOKEN_SUPPLY);
        // assert
        assertEq(token.balanceOf(alice), TOKEN_SUPPLY);
    }

    function testMint721() public {
        // execute
        _mint721(bob);
        // assert
        assertEq(nft721.balanceOf(bob), NFT_SUPPLY);
    }

    function testMint1155() public {
        // execute
        _mint1155(eve, NFT_SUPPLY);
        // assert
        assertEq(nft1155.balanceOf(eve, tokenId), NFT_SUPPLY);
    }

    /// ====================
    /// ===== APPROVAL =====
    /// ====================

    function testApproval20() public {
        // setup
        _mint20(alice, TOKEN_SUPPLY);
        // execute
        _setApproval20(alice, bob, TOKEN_SUPPLY);
        // assert
        assertEq(token.allowance(alice, bob), TOKEN_SUPPLY);
    }

    function testApproval721() public {
        // setup
        _mint721(bob);
        // execute
        _setApproval721(bob, eve, true);
        // assert
        assertEq(nft721.isApprovedForAll(bob, eve), true);
    }

    function testApproval1155() public {
        // setup
        _mint1155(eve, NFT_SUPPLY);
        // execute
        _setApproval1155(eve, susan, true);
        // assert
        assertEq(nft1155.isApprovedForAll(eve, susan), true);
    }

    /// ====================
    /// ===== TRANSFER =====
    /// ====================

    function testTransfer20() public {
        // setup
        testApproval20();
        // execute
        _transfer20(bob, alice, eve, TOKEN_SUPPLY);
        // assert
        assertEq(token.balanceOf(eve), TOKEN_SUPPLY);
    }

    function testTransfer20RevertInsufficientAllowance() public {
        // setup
        _mint20(alice, TOKEN_SUPPLY);
        // revert
        vm.expectRevert(ERC20_INSUFFICIENT_ALLOWANCE_ERROR);
        // execute
        _transfer20(bob, alice, eve, TOKEN_SUPPLY);
    }

    function testTransfer721() public {
        // setup
        testApproval721();
        // execute
        _transfer721(eve, bob, susan, tokenId);
        // assert
        assertEq(nft721.ownerOf(tokenId), susan);
    }

    function testTransfer721RevertNotAuthorized() public {
        // setup
        _mint721(bob);
        // revert
        vm.expectRevert(ERC721_NOT_APPROVED_ERROR);
        // execute
        _transfer721(eve, bob, susan, tokenId);
    }

    function testTransfer1155() public {
        // setup
        testApproval1155();
        // execute
        _transfer1155(susan, eve, alice, tokenId, NFT_SUPPLY);
        // assert
        assertEq(nft1155.balanceOf(alice, tokenId), NFT_SUPPLY);
    }

    function testTransfer1155RevertNotAuthorized() public {
        // setup
        _mint1155(eve, NFT_SUPPLY);
        // revert
        vm.expectRevert(ERC1155_NOT_APPROVED_ERROR);
        // execute
        _transfer1155(susan, eve, alice, tokenId, NFT_SUPPLY);
    }

    /// ===================
    /// ===== HELPERS =====
    /// ===================

    function _createUser(string memory _name) internal returns (address user) {
        user = address(uint160(uint256(keccak256(abi.encodePacked(_name)))));
        vm.label(user, _name);
        vm.deal(user, BALANCE);
    }

    function _mint20(address _owner, uint256 _amount) internal prank(_owner) {
        token.mint(_amount);
    }

    function _mint721(address _owner) internal prank(_owner) {
        nft721.mint();
    }

    function _mint1155(address _owner, uint256 _amount) internal prank(_owner) {
        nft1155.mint(_amount);
    }

    function _setApproval20(
        address _owner,
        address _operator,
        uint256 _amount
    ) internal prank(_owner) {
        token.approve(_operator, _amount);
    }

    function _setApproval721(
        address _owner,
        address _operator,
        bool _approved
    ) internal prank(_owner) {
        nft721.setApprovalForAll(_operator, _approved);
    }

    function _setApproval1155(
        address _owner,
        address _operator,
        bool _approved
    ) internal prank(_owner) {
        nft1155.setApprovalForAll(_operator, _approved);
    }

    function _transfer20(
        address _operator,
        address _from,
        address _to,
        uint256 _amount
    ) internal prank(_operator) {
        token.transferFrom(_from, _to, _amount);
    }

    function _transfer721(
        address _operator,
        address _from,
        address _to,
        uint256 _tokenId
    ) internal prank(_operator) {
        nft721.transferFrom(_from, _to, _tokenId);
    }

    function _transfer1155(
        address _operator,
        address _from,
        address _to,
        uint256 _id,
        uint256 _amount
    ) internal prank(_operator) {
        nft1155.safeTransferFrom(_from, _to, _id, _amount, "");
    }
}
