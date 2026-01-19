# Project Launch: The Solidity Security Field Guide (2026 Edition)

**Author:** TC
**Status:** Active / In-Progress
**Update Frequency:** Bi-Weekly

---
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

### Why Another Security Guide?

Solidity is not just a language; it is a moving target.

If you paste security best practices from a 2018 blog post into a 2026 smart contract, you aren't just writing legacy code—you might be introducing vulnerabilities. The Ethereum landscape has shifted tectonically. Patterns that were once "best practice" (like using `SafeMath` for every integer) are now redundant native features, while new attack vectors (like cross-chain bridge exploits and intricate DeFi flash loan logic) have emerged to take their place.

This repository is **not** a static archive. It is a living reconstruction of the classic security literature, modernized for the current state of the EVM.

### The Philosophy: "Living Code, Living Docs"

This project starts with a comprehensive **Outline**, which serves as our roadmap. Every two weeks, I will light up a new section of the map, expanding it from a bullet point into a full-fledged deep dive.

**What distinguishes this handbook?**

#### 1. Pruning the Dead Wood (Evolutionary Context)

Solidity version `0.4.x` might as well be a different language compared to `0.8.x` or newer. This guide explicitly filters out noise:

* **Outdated:** We won't waste time on `SafeMath` libraries (native since 0.8.0) or obscure quirks that compilers patched years ago.
* **Modernized:** We focus on current mechanisms—Custom Errors, the deprecation path of `selfdestruct` (EIP-6780), and modern gas optimization techniques that don't compromise safety.

#### 2. Visual & Tactical Learning

Security concepts are often abstract. This guide bridges the gap between theory and engineering reality using:

* **Architecture Diagrams:** Visualizing control flow in Re-Entrancy and Delegatecall exploits.
* **"Red Team / Blue Team" Code:** Every chapter includes the *vulnerable* code snippet alongside the *patched* version, with line-by-line diffs explaining the fix.

#### 3. The Engineer's Lens

As a Network Security Engineer, I approach this not just as a coder, but as a defender. We don't just ask "Does it compile?"; we ask "How can this be weaponized?"

---

### The Roadmap

The project is divided into four primary "Security Zones." I will be releasing deep dives for these zones bi-weekly:

* **Phase I:** Control Flow & Identity (Re-Entrancy, Phishing, Access Control)
* **Phase II:** The Mathematics of Failure (Overflows, Precision Loss)
* **Phase III:** Blockchain Intrinsic Flaws (Randomness, Timestamping, MEV)
* **Phase IV:** Silent Failures & DoS (Gas Griefing, Return Values)

### Join the Reconstruction

This is an open invitation to learn alongside me. Whether you are a Web2 developer pivoting to Web3, or a seasoned auditor refreshing your knowledge base, watch this space.

* **Star this Repo** to follow the bi-weekly updates.
* **Open an Issue** if you spot a new vector or want to debate a pattern.

Let's build something unhackable.
