# Ethereum Development Sandbox

An ethereum playground powered on top of the [hardhat](https://hardhat.org/) framework and [ethers.js](https://docs.ethers.io/v5/) library. Smart contracts are written in [solidity](https://docs.soliditylang.org/en/latest/) language and thoroughly tested using the [chai.js](https://www.chaijs.com/) unit testing framework.

The contracts' source code are published on the **_Görli_** ethereum testnet and verified on [etherscan.io](https://goerli.etherscan.io/) using [hardhat-etherscan](https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-etherscan).

- [C_00_Messages.goerli.etherscan.io](https://goerli.etherscan.io/address/0x7E913454210c4C0459146F69BF1c0C1bE59B811C#code)
- [C_01_Storage.goerli.etherscan.io](https://goerli.etherscan.io/address/0x9a2074296da58eEDA0746900ac819Ca3bA1F7735#code)
- [C_02_InsecureEtherVault.goerli.etherscan.io](https://goerli.etherscan.io/address/0xaA7A5355fda1Cb11266dB32De172E18Bda45Cf58#code)

# Getting Started

## Requirement

- [git](https://git-scm.com/)
- [node.js](https://nodejs.org/en/)
- [yarn](https://yarnpkg.com/getting-started/install)
- [metamask](https://metamask.io/)

## Quickstart

```
git clone https://github.com/logann131/ethereum-dev-sandbox.git
cd ethereum-dev-sandbox/smart_contract
yarn
```

## Running the project

#### 1. Set environment variables

- create a `.env` file using the `.example.env` as the template and fill out the variables.
  - `PRIVATE_KEY:` The private key of your [metamask](https://metamask.io/) account. See [Helpers.PRIVATE-KEY](https://github.com/logann131/ethereum-dev-sandbox#1-how-to-export-private_key-from-your-metamask) on how to export your `PRIVATE KEY`. NOTE: FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT AND DO NOT SHARE YOUR PRIVATE KEY.
  - `GOERLI_RPC_URL`: This is url of the `goerli` testnet node you're working with then deploy the `smart contracts` to. Setup with one for free from [Alchemy](https://www.alchemy.com/). See [Helpers.GOERLI-RPC-URL](https://github.com/logann131/ethereum-dev-sandbox#2-how-to-export-a-goerli_rpc_url-from-alchemy) on how to export a `GOERLI_RPC_URL` from [Alchemy](https://www.alchemy.com/).

#### 2. Get testnet `Goerli ETH`

- Head to [Goerli Faucet](https://goerlifaucet.com/)
- Sign into the site using the [Alchemy](https://www.alchemy.com/) account you've created for the `GOERLI_RPC_URL`
- Paste your [metamask](https://metamask.io/) `PUBLIC_KEY` a.k.a `account's address` (not `PRIVATE_KEY`)
- Hit `Send Me ETH` to get some free `Goerli ETH`. Now, `0.5 Goerli ETH` should show up in your [metamask](https://metamask.io/) account

#### 3. Compile smart contracts

```
yarn hardhat compile
```

#### 4. Test smart contracts

```
yarn hardhat test
```

#### 5.1 Deploy smart contracts to Goerli Testnet

```
yarn hardhat run scripts --network goerli
```

#### 5.2 Deploy smart contracts to localhost/hardhat network

```
yarn hardhat node
```

then leave this terminal session open. This will set of a list of 20 fake ethereum accounts with fake ethereum to serve testing purposes

- Open new terminal session, run

```
yarn hardhat run scripts --network hardhat
```

#### 6. Verify smart contracts on [etherscan](https://goerli.etherscan.io/)

```
npx hardhat verify --network goerli DEPLOYED_CONTRACT_ADDRESS "Constructor argument 1"
```

# Helpers

### 1. How to export `PRIVATE_KEY` from your [metamask](https://metamask.io/)

[How to export an account's private key](https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-Export-an-Account-Private-Key)

### 2. How to export a `GOERLI_RPC_URL` from [Alchemy](https://www.alchemy.com/).

- Go to [Alchemy](https://www.alchemy.com/) => `Signup` => `Signin`
- Hit `CREATE APP` => fill out the form
  ```
    {
      NAME: 'ANY',
      DESCRIPTION: 'ANY',
      CHAIN: 'Ethereum',
      NETWORK: 'Goerli`
    }
  ```
- Now, go to the app you just created. Find and click on the `VIEW KEY` button top-right.
- The `URL` under `HTTPS` is the `GOERLI_RPC_URL` you want.
