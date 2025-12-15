# AMCOIN (Stacks / Clarity)

AMCOIN is a simple SIP-010 fungible token smart contract built with **Clarinet**.

## Prerequisites

- **Clarinet** installed and on your PATH
  - Verify: `clarinet --version`
- (Optional) **Node.js** + **npm** (only needed if you want to run the TypeScript tests)

## Project structure

- `Clarinet.toml` — Clarinet project config
- `contracts/`
  - `amcoin.clar` — AMCOIN SIP-010 fungible token contract
  - `sip-010-ft-trait.clar` — local SIP-010 trait definition used by `amcoin.clar`
- `settings/` — Clarinet network settings
- `tests/` — TypeScript test stubs (Vitest + clarinet-sdk)

## Contract overview

### Token metadata

- Name: `AMCoin`
- Symbol: `AMCOIN`
- Decimals: `6`

### Admin / ownership

The contract stores an `owner` principal (initially the contract deployer).

Admin functions:

- `set-owner (new-owner principal)`
- `mint (amount uint) (recipient principal)`

### SIP-010 functions implemented

AMCOIN implements the SIP-010 trait in `contracts/sip-010-ft-trait.clar`:

- `transfer (amount uint) (sender principal) (recipient principal) (memo (optional (buff 34)))`
- `get-name ()`
- `get-symbol ()`
- `get-decimals ()`
- `get-balance (who principal)`
- `get-total-supply ()`
- `get-token-uri ()`

Notes:

- `transfer` requires `tx-sender == sender`.
- `memo` is accepted for compatibility but not interpreted.

## Common commands

### Verify the contracts

```bash
clarinet check
```

### Format Clarity files

```bash
clarinet format
```

### (Optional) Run TypeScript tests

```bash
npm install
npm test
```

## Deploying

This repo is structured for local development with Clarinet. For real deployments, use Clarinet deployments workflows (Devnet/Testnet/Mainnet) and ensure the deployer address is the intended `owner`.
