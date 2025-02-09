# Event Ticket Manager

Welcome to the **Event Ticket Manager** project! This project allows the management of event tickets, providing a seamless and decentralized way of managing ticket issuance, ownership, and transfers using blockchain technology.

## Table of Contents
- [Project Overview](#project-overview)
- [Technologies Used](#technologies-used)
- [Smart Contracts](#smart-contracts)
  - [Event Contract](#event-contract)
  - [Oracle Contract](#oracle-contract)
  - [Alpha Token Contract](#alpha-token-contract)
- [Deployment Details](#deployment-details)
- [Subgraph Integration](#subgraph-integration)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [License](#license)

## Project Overview
The Event Ticket Manager utilizes blockchain technology to manage events, ticket sales, and transfers. It integrates with an oracle for price feeds and leverages a custom token (Alpha Token) for handling transactions.

Key features of the platform:
- Event creation and management.
- Ticket sales and ownership tracking.
- Oracle integration for dynamic price updates.
- Alpha Token integration for seamless payments.
- Transparent and verifiable transactions via smart contracts.

## Technologies Used
- **Blockchain**: Ethereum Smart Contracts (Solidity)
- **Oracle**: Custom Oracle to fetch real-time data
- **Token**: Alpha Token (ERC-20)
- **GraphQL Subgraph**: For querying event-related data
- **Web3.js**: For interacting with Ethereum from the frontend
- **IPFS**: To store off-chain data related to the events and tickets

## Smart Contracts

### Event Contract
The Event contract is used to manage the creation, sale, and transfer of tickets for specific events. It includes functionalities such as:
- Event creation.
- Ticket issuance and transfer.
- Event cancellation and refunds.

Contract Address: `0x52aaef799de8089FfCA08be7406F6C5F067D10B3`

### Oracle Contract
The Oracle contract serves as the bridge between the blockchain and external data sources. It fetches the required data such as ticket prices, event details, and other important information.

Contract Address: `0x8ca50D0fe94ca37ecCf468abe6960663c75cAb76`

### Alpha Token Contract
Alpha Token is the utility token used within the Event Ticket Manager ecosystem. It can be used to buy tickets, make transfers, and interact with other services on the platform.

Contract Address: `0x2E224d6f7C1858cf9572393bd1f29917d8A604c0`

## Deployment Details

- **Deployer Address**: `0x6C800E831aEcfB4aF4D9f09a8093467F01A48a9A`
- **Deployer Public Key**: `ztuRhVrm+2PqEb2srhrV+0Z+xnYQ/CXr7VSFMpbLmgU=`
- **Event Data Encryption Key (EPK)**: The event data is encrypted using the EPK below:
0x7b2276657273696f6e223a227832353531392d7873616c736132302d706f6c7931333035222c226e6f6e6365223a2279306e6b4f3148487743532f776a346d6b4a39716b4f446e415442767a734a4c222c22657068656d5075626c69634b6579223a226d79326d7052746a4c596b514d6e633976464265476867684a413977673369786a4847597a3533613731593d222c2263697068657274657874223a225171324d435048784b55313157664e6c706f636a304d5035317467504a477a2f6b53654879425a565933432f452f794d4f6e76633064553646716146543976333272385176326b6a6457756f314c787954526f4864365330326433506b4b4f65745938324941315362793643476e774d6343316d6c766130793669352b466c45674e77443050324168536259644f6f694555325a6e452f5958633850484f61582f3658315571626c594a5635756243545a44684e4f3975734f6e63312b304d67227d


## Subgraph Integration

We use The Graph protocol for indexing and querying event-related data. The event details and ticket information can be queried using the subgraph hosted at:

[Subgraph URL](https://api.studio.thegraph.com/query/103782/events-subgraph/version/latest)

### Example Query
Here’s an example GraphQL query you can use to get all events:
```graphql
{
  eventCreateds {
    owner
    eventId
    eventDetails_token
    eventDetails_name
    eventDetails_topic
    eventDetails_location
  }
}
```