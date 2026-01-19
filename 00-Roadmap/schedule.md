# 📅 Publication Schedule (Q1-Q2 2026)

**Cadence:** Bi-Weekly Updates (Mondays)
**Timezone:** UTC+8 (Hong Kong Time)

| Target Date | Phase | Topic | Key Concepts Covered | Status |
| --- | --- | --- | --- | --- |
| **Jan 19, 2026** | **Launch** | **Project Kickoff** | Outline, Repository Structure, Introduction Post | ✅ **Live** |
| **Feb 02, 2026** | Phase I | **Re-Entrancy** | Recursive calls, `Checks-Effects-Interactions`, Mutex patterns, *The DAO* case study. | 🚧 In Progress |
| **Feb 16, 2026** | Phase I | **Identity & Auth** | `tx.origin` vs `msg.sender`, Phishing vectors, Authorization modifiers. | ⏳ Pending |
| **Mar 02, 2026** | Phase I | **Access & Visibility** | Default visibility risks, `private` vs `internal`, Function exposure analysis. | ⏳ Pending |
| **Mar 16, 2026** | Phase I | **Context Corruption** | `delegatecall` mechanics, Storage collision, Library security, *Parity Hack* analysis. | ⏳ Pending |
| **Mar 30, 2026** | Phase II | **Integer Arithmetic** | Overflow/Underflow (Pre-0.8 vs Post-0.8), `unchecked` blocks, Type casting risks. | ⏳ Pending |
| **Apr 13, 2026** | Phase II | **Data Precision** | Floating point lack, Fixed-point math strategies, Order of operations (mul before div). | ⏳ Pending |
| **Apr 27, 2026** | Phase II | **Storage Pointers** | Uninitialized storage pointers, Local variable storage defaults, State overwriting. | ⏳ Pending |

---

## 🔮 Future Phases (Tentative)

**Phase III: Blockchain Intrinsic Flaws (May - June 2026)**

* **Entropy Illusion:** Why on-chain randomness fails (Miners, `block.difficulty`).
* **Timestamp Manipulation:** The 15-second rule and miner influence.
* **Front Running:** Mempool watching, MEV basics, Commit-Reveal schemes.
* **Forced Ether:** `selfdestruct` mechanics and logic breaking.

**Phase IV: Silent Failures & Advanced Patterns (July - August 2026)**

* **Unchecked Returns:** Low-level `.call` risks.
* **Denial of Service:** Gas limit grieving, Loop attacks.
* **Honey Pots:** Detecting hidden malicious code in external contracts.

---

## 📌 Maintenance & Review

* **Quarterly Review:** I will review this schedule every 3 months to adjust for new Solidity updates (e.g., upcoming hard forks or EIPs).
* **Emergency Updates:** Critical 0-day vulnerabilities found in the wild may preempt the scheduled topic.

---
