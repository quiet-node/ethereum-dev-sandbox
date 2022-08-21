# ethereum development sandbox

An ethereum play-ground whic is powered on top of the [Hardhat](https://hardhat.org/) framework and [ethers.js](https://docs.ethers.io/v5/) library. Smart contracts are written in [solidity](https://docs.soliditylang.org/en/latest/) language and thoroughly tested using the [chai.js](https://www.chaijs.com/) unit testing framework. The contracts' source code are published on the ***Görli*** ethereum testnet and verified on [Etherscan](https://goerli.etherscan.io/). 

## Interacting with the contracts from Hardhat Console

After deploy the contracts, run `npx hardhat console --network goerli` to get into the hardhat console

`ethers.js` is built with hardhat, so we can use `ethers.js` to retrieve contracts from `ContractFactory`
`const Box = await ethers.getContractFactory('Box');`
`const box = await Box.attach('${box-contract-address}')`
