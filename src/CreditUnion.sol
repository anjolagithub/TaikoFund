// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract CreditUnion {
    struct Loan {
        uint256 amount;
        uint256 dueDate;
        bool isRepaid;
    }

    mapping(address => Loan) public loans;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function requestLoan(uint256 _amount) external {
        require(loans[msg.sender].amount == 0, "Loan already exists");
        loans[msg.sender] = Loan(_amount, block.timestamp + 30 days, false);
    }

    function repayLoan() external payable {
        Loan storage loan = loans[msg.sender];
        require(loan.amount > 0, "No loan exists");
        require(msg.value >= loan.amount, "Insufficient repayment amount");
        require(!loan.isRepaid, "Loan already repaid");

        loan.isRepaid = true;
        (bool success, ) = owner.call{value: msg.value}("");
        require(success, "Transfer failed");
    }

    function checkLoanStatus(address _borrower) external view returns (Loan memory) {
        return loans[_borrower];
    }
}
