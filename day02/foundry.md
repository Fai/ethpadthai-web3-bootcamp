# Foundry using Docker

```bash
docker pull ghcr.io/foundry-rs/foundry:latest
docker run -v $PWD:/app foundry "forge test --root /app --watch"
```

```docker
# Use the latest foundry image
FROM ghcr.io/foundry-rs/foundry

# Copy our source code into the container
WORKDIR /app

# Build and test the source code
COPY . .
RUN forge build
RUN forge test

# Set the entrypoint to the forge deployment command
ENTRYPOINT ["forge", "create"]
```

```bash
docker build --no-cache --progress=plain . -t nft-deployer .
docker run nft-deployer --rpc-url $RPC_URL --constructor-args "ForgeNFT" "FNFT" "https://ethereum.org" --private-key $PRIVATE_KEY ./src/NFT.sol:NFT
```