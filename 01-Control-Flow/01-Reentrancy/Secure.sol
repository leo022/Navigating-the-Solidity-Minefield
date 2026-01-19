// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title The Vault (Secure)
 * @author TC
 * @notice Implements Checks-Effects-Interactions and Mutex
 */
contract SecureVault {
    mapping(address => uint256) public balances;
    bool private locked;

    // Custom Reentrancy Guard Modifier
    modifier nonReentrant() {
        require(!locked, "No re-entrancy");
        locked = true;
        _;
        locked = false;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public nonReentrant {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "Insufficient funds");

        // === ✅ FIX 1: EFFECTS ===
        // Update state BEFORE sending ether (CEI Pattern)
        balances[msg.sender] = 0;

        // === ✅ FIX 2: INTERACTIONS ===
        // Now it is safe to send. Even if they re-enter,
        // their balance is already 0.
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Transfer failed");
    }
}
