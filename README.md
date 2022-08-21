# Ethereum Development Sandbox

An ethereum playground powered on top of the [Hardhat](https://hardhat.org/) framework and [ethers.js](https://docs.ethers.io/v5/) library. Smart contracts are written in [solidity](https://docs.soliditylang.org/en/latest/) language and thoroughly tested using the [chai.js](https://www.chaijs.com/) unit testing framework. 

The contracts' source code are published on the ***Görli*** ethereum testnet and verified on [Etherscan.io](https://goerli.etherscan.io/) using [hardhat-etherscan](https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-etherscan).

- [C_00_Messages.goerli.etherscan.io](https://goerli.etherscan.io/address/0x7E913454210c4C0459146F69BF1c0C1bE59B811C#code)
- [C_01_Storage.goerli.etherscan.io](https://goerli.etherscan.io/address/0x9a2074296da58eEDA0746900ac819Ca3bA1F7735#code)
- [C_02_InsecureEtherVault.goerli.etherscan.io](https://goerli.etherscan.io/address/0xaA7A5355fda1Cb11266dB32De172E18Bda45Cf58#code)

# Getting Started
## Requirement
- [git](https://git-scm.com/)
- [NodeJs](https://nodejs.org/en/)
- [Yarn](https://yarnpkg.com/getting-started/install)
- [metamask](https://metamask.io/)

## Quickstart
```
git clone https://github.com/logann131/ethereum-dev-sandbox.git
cd ethereum-dev-sandbox/smart_contract
yarn
```

## Running the project
1. Set environment variables
- create a `.env` file using the `.example.env` as the template and fill out the variables.
  - `PRIVATE_KEY:` The private key of your account ([Helpers.PRIVATE-KEY](https://github.com/logann131/ethereum-dev-sandbox#1-how-to-retrieve-private_key-from-your-metamask)). NOTE: FOR DEVELOPMENT, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT AND DO NOT SHARE YOUR PRIVATE KEY.
  
  

# Helpers
### 1. How to retrieve `PRIVATE_KEY` from your [metamask](https://metamask.io/)
- Download `metamask chrome extension`
- Open or import your wallet
- Navigate to and click the `three vertical dots` next to your account name and address
- Click on `account details` => `Export Private Key`
- Type your `password` then `confirm`
- Now your private key is showing. Again, PLEASE USE A KEY THAT DOESN'T HAVE ANY REAL FUNDS ASSOCIATED WITH IT AND DO NOT SHARE YOUR PRIVATE KEY.
