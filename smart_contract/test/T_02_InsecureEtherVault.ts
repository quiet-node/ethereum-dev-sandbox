import { Provider } from '@ethersproject/providers';
import { expect } from 'chai';
import { BigNumber, Contract, Signer } from 'ethers';
import { ethers } from 'hardhat';

describe('InsecureEtherVault Contract', () => {
  let userA: Signer, userB: Signer, userC: Signer;
  let insecureEtherVaultContract: Contract;

  beforeEach(async () => {
    [userA, userB, userC] = await ethers.getSigners();

    const InsecureEtherVault = await ethers.getContractFactory(
      'C_02_InsecureEtherVault'
    );
    insecureEtherVaultContract = await InsecureEtherVault.deploy();
  });

  describe('Deposit', () => {
    it('Should add funder to userBalances map', async () => {
      let userAValue: BigNumber = ethers.utils.parseEther('1');
      await insecureEtherVaultContract
        .connect(userA)
        .deposit({ value: userAValue });

      const response = await insecureEtherVaultContract.getUserBalance(
        await userA.getAddress()
      );
      expect(response).to.eq(userAValue);
    });

    it('Should show that the contract address holds exact amount of ethers deposited', async () => {
      let userAValue: number = 10;
      let userBValue: number = 30;
      let userCValue: number = 20;
      let totalEthDeposited: number = userAValue + userBValue + userCValue;

      await insecureEtherVaultContract
        .connect(userA)
        .deposit({ value: userAValue });

      await insecureEtherVaultContract
        .connect(userB)
        .deposit({ value: userBValue });

      await insecureEtherVaultContract
        .connect(userC)
        .deposit({ value: userCValue });

      const response = await insecureEtherVaultContract.getTotalBalance();
      expect(response).to.eq(totalEthDeposited);
    });

    it('Should let msg.sender to widthdraw all the deposit', async () => {
      let userAValue: BigNumber = ethers.utils.parseEther('3');
      let userBValue: BigNumber = ethers.utils.parseEther('2');
      let userABalanceBeforeDeposit: BigNumber = await userA.getBalance();

      await insecureEtherVaultContract
        .connect(userA)
        .deposit({ value: userAValue });
      await insecureEtherVaultContract
        .connect(userB)
        .deposit({ value: userBValue });

      await insecureEtherVaultContract.connect(userA).withdrawAll();

      expect(await insecureEtherVaultContract.getTotalBalance()).eq(userBValue);
    });

    it('Should fail if userBalance = 0', async () => {
      await expect(
        insecureEtherVaultContract.connect(userA).withdrawAll()
      ).to.be.revertedWith('Insufficient Balance');
    });
  });
});
