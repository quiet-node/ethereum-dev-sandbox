# ethereum development sandbox

An ethereum playground powered on top of the [Hardhat](https://hardhat.org/) framework and [ethers.js](https://docs.ethers.io/v5/) library. Smart contracts are written in [solidity](https://docs.soliditylang.org/en/latest/) language and thoroughly tested using the [chai.js](https://www.chaijs.com/) unit testing framework. 

The contracts' source code are published on the ***Görli*** ethereum testnet and verified on [Etherscan.io](https://goerli.etherscan.io/) using [hardhat-etherscan](https://hardhat.org/hardhat-runner/plugins/nomiclabs-hardhat-etherscan).

- [C_00_Messages.goerli.etherscan.io](https://goerli.etherscan.io/address/0x7E913454210c4C0459146F69BF1c0C1bE59B811C#code)
- [C_01_Storage.goerli.etherscan.io](https://goerli.etherscan.io/address/0x9a2074296da58eEDA0746900ac819Ca3bA1F7735#code)
- [C_02_InsecureEtherVault.goerli.etherscan.io](https://goerli.etherscan.io/address/0xaA7A5355fda1Cb11266dB32De172E18Bda45Cf58#code)

## Interacting with the contracts from Hardhat Console

After deploy the contracts, run `npx hardhat console --network goerli` to get into the hardhat console

`ethers.js` is built with hardhat, so we can use `ethers.js` to retrieve contracts from `ContractFactory`
`const Box = await ethers.getContractFactory('Box');`
`const box = await Box.attach('${box-contract-address}')`
