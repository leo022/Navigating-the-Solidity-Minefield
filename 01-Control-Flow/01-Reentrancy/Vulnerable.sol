pragma solidity ^0.8.20;

/**
 * @title The Vault (Vulnerable)
 * @author TC
 * @notice DO NOT USE IN PRODUCTION. This contract is a honeypot.
 */
contract VulnerableVault {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "Insufficient funds");

        // === ❌ VULNERABILITY HERE ===
        // We send the money BEFORE we update the balance.
        (bool success, ) = msg.sender.call{value: balance}("");
        require(success, "Transfer failed");

        // The attacker's fallback function executes here,
        // calling withdraw() again before this line runs.
        balances[msg.sender] = 0;
    }
}
