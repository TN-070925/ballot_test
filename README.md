# 🧾 InteractionLogger Smart Contract

**Contract Address:** [`0x0c274CEfE8C44CF38106aB6C0E8ef4f93d6565dB`](https://etherscan.io/address/0x0c274CEfE8C44CF38106aB6C0E8ef4f93d6565dB)

---

## 📜 Overview

**InteractionLogger** is a simple Solidity smart contract designed to record and retrieve user interactions **without any input parameters**.  
Each interaction logs the caller’s wallet address and the block timestamp of when the interaction occurred.

This contract is minimalistic — it includes:
- **No constructor**
- **No imports**
- **No function parameters**
- Full on-chain transparency for logged interactions.

---

## ⚙️ Contract Details

| Item | Description |
|------|--------------|
| **Network** | Ethereum (or compatible EVM chain) |
| **Language** | Solidity `^0.8.20` |
| **Contract Name** | `InteractionLogger` |
| **License** | MIT |
| **Deployed Address** | `0x0c274CEfE8C44CF38106aB6C0E8ef4f93d6565dB` |

---

## 🧩 Features

- **Log Interactions:**  
  Records `msg.sender` and `block.timestamp` every time a user calls `logInteraction()`.

- **View Latest Interaction:**  
  Fetches the most recent interaction (address, timestamp, and ID).

- **Total Interactions Count:**  
  Returns the total number of interactions stored on-chain.

- **All Interactions (View Only):**  
  Returns two arrays (addresses and timestamps) of all interactions — mainly for **off-chain reads** due to gas limitations.

---

## 🧠 Functions

### 1. `logInteraction()`
Records a new interaction using `msg.sender` and `block.timestamp`.  
Emits the event:
```solidity
event InteractionLogged(address indexed user, uint256 timestamp, uint256 id);
