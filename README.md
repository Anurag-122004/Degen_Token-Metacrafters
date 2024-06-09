# Degen Token

**Degen Token** is an ERC20 token designed for the Degen Gaming platform, deployed on the Avalanche network. The smart contract includes the following functionalities:

- **Minting new tokens:** The platform can create new tokens and distribute them to players as rewards. Only the owner can mint tokens.
- **Transferring tokens:** Players can transfer their tokens to others.
- **Redeeming tokens:** Players can redeem their tokens for items in the in-game store.
- **Checking token balance:** Players can check their token balance at any time.
- **Burning tokens:** Anyone can burn tokens they own that are no longer needed.

## Deployment

The smart contract for Degen Token was developed and deployed using Remix IDE, and tested on the Snowtrace testnet.

## Prerequisites

To interact with the Degen Token smart contract, you will need the following:

- **MetaMask:** A browser extension wallet for interacting with the Avalanche network.
- **Avalanche Fuji Testnet AVAX:** Some testnet AVAX for deploying and testing the contract on the Snowtrace testnet.

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/degen-token.git
    cd degen-token
    ```

2. **Install dependencies:**

    No additional dependencies are required for this project. All development and deployment were done using Remix IDE.

## Usage

1. **Open Remix IDE:**

    Navigate to [Remix IDE](https://remix.ethereum.org/) in your web browser.

2. **Load the Smart Contract:**

    - Copy the smart contract code from the `contracts/DegenToken.sol` file in this repository.
    - In Remix IDE, create a new file named `DegenToken.sol` and paste the copied code into it.

3. **Compile the Smart Contract:**

    - In Remix IDE, navigate to the "Solidity Compiler" tab.
    - Ensure the correct Solidity version is selected (as specified in the `pragma` directive in the contract).
    - Click "Compile DegenToken.sol".

4. **Deploy the Smart Contract:**

    - Navigate to the "Deploy & Run Transactions" tab.
    - Select "Injected Web3" as the environment to connect Remix with MetaMask.
    - Ensure you are connected to the Avalanche Fuji Testnet in MetaMask.
    - Click "Deploy" and confirm the transaction in MetaMask.

5. **Interact with the Smart Contract:**

    - Use the deployed contract's interface in Remix to mint, transfer, redeem, check balances, and burn tokens as needed.
    - Alternatively, you can interact with the contract using Web3 libraries (e.g., Web3.js or Ethers.js) in your own applications.

## Testing

The smart contract was tested on the Snowtrace testnet. To test the contract yourself:

1. Obtain some testnet AVAX from the Avalanche Fuji Testnet faucet.
2. Deploy the contract as described above.
3. Use the Remix IDE or Web3 libraries to call the contract functions and ensure they work as expected.

## Contributing

If you would like to contribute to the Degen Token project, please fork the repository and submit a pull request. We welcome all improvements and suggestions.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

**Degen Token**: Enhancing the gaming experience with blockchain technology on the Avalanche network.
