### Instructions for Readers (to include in README)

You can add this snippet to your `README.md` to guide users on how to run this lab:

```bash
## 🧪 Run the Lab

1. **Install Foundry** (if you haven't yet):
   ```bash
   curl -L [https://foundry.paradigm.xyz](https://foundry.paradigm.xyz) | bash
   foundryup

```

2. **Run the Attack Test:**
```bash
forge test --match-path test/Reentrancy.t.sol -vv

```


3. **See the Traces:**
To visualize the recursive calls, use triple verbosity (`-vvv`):
```bash
forge test --match-test test_AttackVulnerable -vvv

```



Complete content pack for **Phase 1: Re-Entrancy**.
1.  `article.md` (Theory)
2.  `Vulnerable.sol` & `Secure.sol` (Code)
3.  `Attacker.sol` & `Reentrancy.t.sol` (Lab)

