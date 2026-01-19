# 01. Re-Entrancy: The Recursive Trap

**Phase:** Control Flow
**Difficulty:** ⭐⭐☆☆☆
**Impact:** Critical (Total Loss of Funds)
**Updated:** Feb 02, 2026

---

## The Concept

Imagine you are a bank teller. A customer asks to withdraw $100. You check their balance, see they have $100, and hand them the cash. But *before* you can update your ledger to say "Balance: $0", the customer freezes time, duplicates themselves, and the duplicate asks to withdraw $100 again.

You look at the ledger. It still says "Balance: $100" (because you haven't written the new balance down yet). So, you hand the duplicate another $100. This repeats until the vault is empty.

In Solidity, this is **Re-Entrancy**. It happens when a contract hands over control flow (by sending Ether) to an untrusted contract *before* it has updated its own internal state.



---

## The Attack Mechanism

1.  **Target:** A vulnerable contract has a `withdraw()` function. It checks your balance, sends the Ether, and *then* updates your balance.
2.  **Attacker:** Deploys a malicious contract.
3.  **Trigger:** The attacker calls `withdraw()`.
4.  **Handover:** The Target sends Ether to the Attacker. This triggers the Attacker's `receive()` or `fallback()` function.
5.  **Recursion:** Inside the `fallback()`, the Attacker calls `Target.withdraw()` *again*.
6.  **The Flaw:** Since the Target hasn't reached the line of code where it updates the balance, the check passes again.
7.  **Drain:** The loop continues until the Attacker runs out of gas or the Target runs out of Ether.

---

## 🔴 Red Team: The Vulnerable Code

This contract makes the classic mistake: **Interacting before Effect**.

*(See `Vulnerable.sol` for the deployable code)*

```solidity
function withdraw() public {
    uint256 amount = balances[msg.sender];
    require(amount > 0, "No funds");

    // ❌ DANGER: Interaction happens before state update
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");

    // The code below is never reached until the recursive calls finish
    balances[msg.sender] = 0;
}

```

---

## 🔵 Blue Team: The Fix

We have two primary lines of defense. You should ideally use **both**.

### Defense 1: Checks-Effects-Interactions (CEI) Pattern

Always structure your functions in this exact order:

1. **Checks:** Validate inputs (`require`).
2. **Effects:** Update state variables (optimistically deduct balances).
3. **Interactions:** External calls (send Ether).

### Defense 2: Mutex (Re-Entrancy Guard)

A "mutex" (Mutual Exclusion) places a lock on the contract. If a function is "locked," no one can enter it (or any other locked function) until the first execution finishes.

*(See `Secure.sol` for the deployable code)*

```solidity
// ✅ SAFE: Effects happen before Interaction
function withdraw() public nonReentrant {
    uint256 amount = balances[msg.sender];
    require(amount > 0, "No funds");

    // 1. Effect: Update state FIRST
    balances[msg.sender] = 0;

    // 2. Interaction: Send Ether LAST
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");
}

```

---

## Historical Context: The DAO (2016)

The most famous hack in Ethereum history used this exact vector. The DAO contract sent Ether to users *before* updating their internal token balance. An attacker drained ~3.6 million ETH, leading to the controversial hard fork that created Ethereum (ETH) and Ethereum Classic (ETC).

## Summary

* **Never** trust an external call.
* **Always** finish your internal work (state updates) before talking to the outside world.
* **Use** OpenZeppelin's `ReentrancyGuard` for critical functions.




### 2. The Vulnerable Contract (`Vulnerable.sol`)

```solidity
// SPDX-License-Identifier: MIT
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

```

---

### 3. The Secure Contract (`Secure.sol`)

```solidity
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
```
