# Foundry Template

A template for quickly getting started with foundry

## Setup

1. Install foundry

```
curl -L https://foundry.paradigm.xyz | bash
```

2. Create `.env` file in root

```
DEPLOYER_PRIVATE_KEY=
ETHERSCAN_API_KEY=
GOERLI_RPC_URL=
MAINNET_RPC_URL
SEPOLIA_RPC_URL=
```

3. Install dependencies

```
npm ci
forge install
```

4. Run linter

```
npm run lint
```

5. Run all tests (Stack traces: `-vvvvv` | Gas report: `--gas-report`)

```
forge test --mc BaseTest
forge test --mc BaseTest -vvvvv
forge test --mc BaseTest --gas-report
```

6. Run individual tests

```
forge test --mt testMint20
forge test --mt testMint721
forge test --mt testMint1155
```

7. Deploy contracts

```
forge script script/Deploy.s.sol:Deploy --rpc-url $GOERLI_RPC_URL --private-key $DEPLOYER_PRIVATE_KEY --verify --etherscan-api-key $ETHERSCAN_API_KEY --broadcast
```

### Goerli Contracts

| Name      | Address                                                                                                                      |
| --------- | ---------------------------------------------------------------------------------------------------------------------------- |
| `ERC20`   | [0x2c2aaaeE26D16426d47FD5ded73D0D59f2B5a5D8](https://goerli.etherscan.io/address/0x2c2aaaeE26D16426d47FD5ded73D0D59f2B5a5D8) |
| `ERC721`  | [0xa6bb3cCD1C1D93D9d5c090411d69FEF3DBCf0C7D](https://goerli.etherscan.io/address/0xa6bb3cCD1C1D93D9d5c090411d69FEF3DBCf0C7D) |
| `ERC1155` | [0xe3f9B5beddF4bcbb139C20542158b249a24c4245](https://goerli.etherscan.io/address/0xe3f9B5beddF4bcbb139C20542158b249a24c4245) |

### Sepolia Contracts

| Name      | Address                                                                                                                       |
| --------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `ERC20`   | [0xB3fb1de50BB11C9A4413455C2606F7c182f5D355](https://sepolia.etherscan.io/address/0xB3fb1de50BB11C9A4413455C2606F7c182f5D355) |
| `ERC721`  | [0x467408bB421ef6724a74aCf814835115a42EFCf9](https://sepolia.etherscan.io/address/0x467408bB421ef6724a74aCf814835115a42EFCf9) |
| `ERC1155` | [0xFD6bb72963DF1C6cbC92700d77A86fF988E88F1F](https://sepolia.etherscan.io/address/0xFD6bb72963DF1C6cbC92700d77A86fF988E88F1F) |

### Gas Reports

| src/tokens/Token.sol |                 |       |        |       |         |
| -------------------- | --------------- | ----- | ------ | ----- | ------- |
| Deployment Cost      | Deployment Size |       |        |       |         |
| 701378               | 3775            |       |        |       |         |
| Function Name        | min             | avg   | median | max   | # calls |
| approve              | 24652           | 24652 | 24652  | 24652 | 2       |
| mint                 | 46589           | 46589 | 46589  | 46589 | 4       |
| transferFrom         | 22197           | 22197 | 22197  | 22197 | 1       |

| src/tokens/NFT721.sol |                 |        |        |        |         |
| --------------------- | --------------- | ------ | ------ | ------ | ------- |
| Deployment Cost       | Deployment Size |        |        |        |         |
| 1164048               | 6085            |        |        |        |         |
| Function Name         | min             | avg    | median | max    | # calls |
| mint                  | 296924          | 296924 | 296924 | 296924 | 4       |
| setApprovalForAll     | 24694           | 24694  | 24694  | 24694  | 2       |
| transferFrom          | 5759            | 17263  | 17263  | 28768  | 2       |

| src/tokens/NFT1155.sol |                 |       |        |       |         |
| ---------------------- | --------------- | ----- | ------ | ----- | ------- |
| Deployment Cost        | Deployment Size |       |        |       |         |
| 1364268                | 7092            |       |        |       |         |
| Function Name          | min             | avg   | median | max   | # calls |
| mint                   | 48057           | 48057 | 48057  | 48057 | 4       |
| safeTransferFrom       | 3434            | 13650 | 13650  | 23867 | 2       |
| setApprovalForAll      | 24650           | 24650 | 24650  | 24650 | 2       |
