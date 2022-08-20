import { expect } from 'chai';
import { Contract, ContractFactory } from 'ethers';
import { ethers } from 'hardhat';

describe('Messages Contract', () => {
  let messagesContract: Contract;
  let initialMessage: String = 'Hello, Messages Contract!';
  beforeEach(async () => {
    const Messages: ContractFactory = await ethers.getContractFactory(
      'C_00_Messages'
    );
    messagesContract = await Messages.deploy(initialMessage);
  });

  describe('Deployment', () => {
    it("Should deploy with the 'initialMessage' message", async () => {
      expect(await messagesContract.message()).to.eq(initialMessage);
    });
  });

  describe('Updating Messages', () => {
    const newUpdatedMessage: String = 'New updated message';
    it("Should update a new message based the user's input", async () => {
      await messagesContract.updateMessage(newUpdatedMessage);
      expect(await messagesContract.getMessage()).to.eq(newUpdatedMessage);
    });
  });
});
