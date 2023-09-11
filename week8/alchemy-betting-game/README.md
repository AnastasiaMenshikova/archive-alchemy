# Alchemy Betting game on L2 Optimism 

[Alchemy Road to Web 3 Week 8](https://www.youtube.com/watch?v=TL5NoWky3Uk)

### How to install and use

To set up the repository and run the marketplace locally, run the below

```bash

git clone https://github.com/AnastasiaMenshikova/alchemy-betting-game

cd alchemy-betting-game

yarn install

yarn start

```
Create the `.env` file and add your own api keys and private key by using `.example.env`. 

To deploy smart contract to Goerli Optimism testnet use:

 
 ```bash
 
 yarn deploy

 ```

For testing added static analyzer [Slither](https://github.com/crytic/slither) for Solidity code. Run following command:

```bash

yarn slither

```
If you want to write unit tests for your solidity code and check coverage of tests, run command:

```bash

yarn coverage

```