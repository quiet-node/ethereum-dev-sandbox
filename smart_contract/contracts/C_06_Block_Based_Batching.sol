pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// In this example, a user can swap tokenA for tokenB at a fixed rate of 100. An attacker can exploit this contract by watching the transaction pool (mempool) 
// for swap transactions and front-running them. When they see a profitable swap transaction, they submit their own swap transaction with a higher gas price, 
// which is likely to be processed before the original transaction.

contract VulnerableTokenSwap {
    ERC20 public tokenA;
    ERC20 public tokenB;

    constructor(ERC20 _tokenA, ERC20 _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
    }

    function swap(uint256 amount) external {
        uint256 rate = getRate(amount);
        require(tokenA.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        require(tokenB.transfer(msg.sender, amount * rate), "Transfer failed");
    }

    function getRate(uint256 amount) public view returns (uint256) {
        // simplified calculation based on liquidity pools, etc.
        return 100;
    }
}


// In this modified version, users can only submit swap requests during a batch's duration. The actual token swaps are processed in a separate function processBatch(),
// which can only be called once the current batch has ended. This approach reduces the advantage of front-running by making it less predictable which transactions 
// will be processed first.

contract BatchedTokenSwap {
    IERC20 public tokenA;
    IERC20 public tokenB;
    uint256 public constant BATCH_DURATION = 1 minutes;

    struct SwapRequest {
        address user;
        uint256 amount;
    }

    SwapRequest[] public swapRequests;
    uint256 public currentBatchEnd;

    event SwapRequestAdded(address indexed user, uint256 amount);

    constructor(IERC20 _tokenA, IERC20 _tokenB) {
        tokenA = _tokenA;
        tokenB = _tokenB;
        currentBatchEnd = block.timestamp + BATCH_DURATION;
    }

    function requestSwap(uint256 amount) external {
        require(block.timestamp <= currentBatchEnd, "Batch has ended");

        swapRequests.push(SwapRequest({
            user: msg.sender,
            amount: amount
        }));

        emit SwapRequestAdded(msg.sender, amount);
    }

    function processBatch() external {
        require(block.timestamp > currentBatchEnd, "Batch is still ongoing");

        uint256 rate = getRate();

        for (uint256 i = 0; i < swapRequests.length; i++) {
            SwapRequest storage swapRequest = swapRequests[i];

            require(tokenA.transferFrom(swapRequest.user, address(this), swapRequest.amount), "Transfer failed");
            require(tokenB.transfer(swapRequest.user, swapRequest.amount * rate), "Transfer failed");
        }

        delete swapRequests;
        currentBatchEnd = block.timestamp + BATCH_DURATION;
    }

    function getRate() public view returns (uint256) {
        // simplified calculation based on liquidity pools, etc.
        return 100;
    }
}
