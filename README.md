# Subscription-Based Service Smart Contract

This smart contract facilitates a subscription-based service model on a blockchain network. Users can subscribe to different service tiers with varying features and benefits, paying with supported cryptocurrencies.

## Features:

- **Tiered Subscriptions:** Define different service tiers with distinct features and pricing.
- **Secure Payments:** Users subscribe and pay for services using supported cryptocurrencies, ensuring secure and transparent transactions.
- **Automatic Recurring Payments:** Subscriptions can be set up for automatic renewals after a predefined period, simplifying user management.
- **Access Control:** Users gain access to service features based on their subscribed tier.
- **Role-Based Access Control (Optional):** Implement additional access control based on user roles within a tier (advanced configuration).


## Getting Started:

### Installation and Deployment

1. Clone the repository:
   ```bash
   git clone https://github.com/mishraji874/Subscription-Service-Smart-Contract.git
2. Navigate to the project directory:
    ```bash
    cd Subscription-Service-Smart-Contract
3. Initialize Foundry and Forge:
    ```bash
    forge init
4. Create the ```.env``` file and paste the [Alchemy](https://www.alchemy.com/) api for the Sepolia Testnet and your Private Key from the Metamask.

5. Compile and deploy the smart contracts:

    If you want to deploy to the local network anvil then run this command:
    ```bash
    forge script script/DeploySubscriptionService.s.sol --rpc-url {LOCAL_RPC_URL} --private-key {PRIVATE_KEY}
    ```
    If you want to deploy to the Sepolia testnet then run this command:
    ```bash
    forge script script/DeploySubscriptionService.s.sol --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY}
### Running Tests

Run the automated tests for the smart contract:

```bash
forge test
```

## Configuration:

- Supported cryptocurrencies can be configured within the contract.
- Define different service tiers and their features.
- Set pricing for each tier and renewal intervals for recurring subscriptions.

## Additional Notes:

- This is a basic implementation and can be extended to include additional features like tiered access control within subscriptions or integration with external service providers.
- Refer to the SubscriptionService.sol and SubscriptionServiceTest.t.sol files for detailed contract logic and test cases.
- Carefully consider the legal and regulatory implications of offering a subscription service on a blockchain platform.

## Security Considerations:

- Smart contract audits by reputable security firms are highly recommended.
- Securely store sensitive information, such as access control logic, off-chain.