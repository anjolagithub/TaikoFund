// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/CreditUnion.sol";

contract CreditUnionTest is Test {
    CreditUnion creditUnion;

    function setUp() public {
        creditUnion = new CreditUnion();
    }

    function testRequestLoan() public {
        creditUnion.requestLoan(1 ether);
        (uint256 amount,, bool isRepaid) = creditUnion.loans(address(this));
        assertEq(amount, 1 ether);
        assertEq(isRepaid, false);
    }

    function testRepayLoan() public {
        creditUnion.requestLoan(1 ether);
        payable(address(creditUnion)).call{value: 1 ether}("");
        creditUnion.repayLoan{value: 1 ether}();
        (,, bool isRepaid) = creditUnion.loans(address(this));
        assertEq(isRepaid, true);
    }
}
