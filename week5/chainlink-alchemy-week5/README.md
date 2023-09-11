# ALCHEMY'S ROAD TO WEB3 DEVELOPER PROGRAM WEEK 5

### Project Description

<a href="https://www.youtube.com/watch?v=hNdXSMKLDi4&ab_channel=Alchemy">Tutorial on youtube</a>
<a href="https://docs.alchemy.com/alchemy/road-to-web3/weekly-learning-challenges/5.-connect-apis-to-your-smart-contracts-using-chainlink">Written tutorial version</a>

This project mints Dynamic NFTs that change based on the market price of an asset pair (for example, the ETH/USD asset price). When prices go up, its a bull trend and when the go down its a bear trend. We run [Chainlink Keepers](https://docs.chain.link/docs/chainlink-keepers/introduction/) to have our smart contract automatically called at specified intervals so that on-chain logic checks the [Chainlink Price Feed](https://docs.chain.link/docs/using-chainlink-reference-contracts/) to see if there has been a change in price. Accordingly the minted NFTs dynamically alternate between the images below.

<p float="left">
    <img src="./ipfs/gamer_bull.png" width = "200" />
    <img src="./ipfs/party_bull.png" width = "200" />
    <img src="./ipfs/simple_bull.png" width = "200" />
    <img src="./ipfs/beanie_bear.png" width = "200" />
    <img src="./ipfs/coolio_bear.png" width = "200" />
    <img src="./ipfs/simple_bear.png" width = "200" />
</p>

The entire project is designed for ease of use by those new to Web3 and can be run from a Remix in-browser IDE and network environment.

### How to use

```bash

git clone https://github.com/AnastasiaMenshikova/chainlink-alchemy-week5

cd chainlink-alchemy-week5

yarn install

```
To deploy and verify smart contract on Rinkeby testnet run following commands:

```bash

yarn deploy

yarn verify

```