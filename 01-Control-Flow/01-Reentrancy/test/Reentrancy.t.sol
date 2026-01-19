// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Vulnerable.sol";
import "../src/Secure.sol";
import "../src/Attacker.sol";

contract ReentrancyTest is Test {
    VulnerableVault public vulnerableVault;
    SecureVault public secureVault;
    Attacker public attacker;
    
    address public victimUser = address(0x1);
    address public hacker = address(0x2);

    function setUp() public {
        // 1. Deploy Vaults
        vulnerableVault = new VulnerableVault();
        secureVault = new SecureVault();

        // 2. Fund the Vaults with "innocent" user money (10 ETH)
        vm.deal(victimUser, 10 ether);
        
        vm.prank(victimUser);
        vulnerableVault.deposit{value: 10 ether}();
        
        vm.prank(victimUser);
        secureVault.deposit{value: 10 ether}();
    }

    function test_AttackVulnerable() public {
        // 1. Deploy the Attacker contract pointing to VulnerableVault
        vm.startPrank(hacker);
        attacker = new Attacker(address(vulnerableVault));
        
        // 2. Fund the Hacker with 1 ETH (to start the loop)
        vm.deal(hacker, 1 ether);
        
        // 3. Launch the Attack
        attacker.attack{value: 1 ether}();
        vm.stopPrank();

        // 4. Assertions: Vault should be empty, Attacker should have 11 ETH
        console.log("Vault Balance:", address(vulnerableVault).balance);
        console.log("Attacker Balance:", address(attacker).balance);

        assertEq(address(vulnerableVault).balance, 0, "Vault should be drained");
        assertEq(address(attacker).balance, 11 ether, "Attacker should have 11 ETH");
    }

    function test_AttackSecure() public {
        // 1. Deploy the Attacker contract pointing to SecureVault
        vm.startPrank(hacker);
        attacker = new Attacker(address(secureVault));
        vm.deal(hacker, 1 ether);

        // 2. Launch Attack - It should Fail/Revert
        // The SecureVault follows Checks-Effects-Interactions, so the second 
        // withdraw call will fail because the balance was already set to 0.
        // Or the ReentrancyGuard will block it.
        vm.expectRevert("Transfer failed"); 
        attacker.attack{value: 1 ether}();
        vm.stopPrank();
    }
}
