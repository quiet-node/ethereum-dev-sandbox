# eth-sandbox

Decentralized Apps play ground

## Interacting with the contracts from Hardhat Console

After deploy the contracts, run `npx hardhat console --network goerli` to get into the hardhat console

`ethers.js` is built with hardhat, so we can use `ethers.js` to retrieve contracts from `ContractFactory`
`const Box = await ethers.getContractFactory('Box');`
`const box = await Box.attach('${box-contract-address}')`
