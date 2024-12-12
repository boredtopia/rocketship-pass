# TODO run script pass but not verify
#forge verify-contract 0xc371d572a299910994f48B10f649daE75209605f contracts/RocketshipPassEco.sol:RocketshipPassEco \
forge verify-contract 0x6AAD776eCCd74471683aCb1dAf38310Ce3b05a3c contracts/RocketshipPassBusiness.sol:RocketshipPassBusiness \
--verifier-url 'https://api.routescan.io/v2/network/mainnet/evm/1088/etherscan' \
--etherscan-api-key "verifyContract" \
--num-of-optimizations 200 \
--compiler-version 0.8.26 \
--constructor-args $(cast abi-encode "constructor(address param1)" 0x53873925c5156C505E65A73542CEc125eDD3E8A1)
