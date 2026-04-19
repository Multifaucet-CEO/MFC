# Multicoin (MFC)

![Multicoin Logo](share/pixmaps/multicoin.png)

Multicoin (MFC) is a cryptocurrency based on Litecoin Core 0.21.4, designed for fair distribution through the Multifaucet.eu ecosystem.

## 🪙 Specifications

* **Ticker:** MFC (Mainnet), TMFC (Testnet), RMFC (Regtest)
* **Algorithm:** Scrypt Proof-of-Work
* **Block Time:** 2.5 minutes
* **Block Reward:** 50 MFC (initial)
* **Halving:** Every 840,000 blocks (~4 years)
* **Max Supply:** 84,000,000 MFC
* **Premine:** None

## 🌐 Network

### Ports
* **Mainnet (P2P):** 13333
* **Mainnet (RPC):** 13332
* **Testnet (P2P):** 13334
* **Testnet (RPC):** 13335
* **Regtest (P2P):** 13336
* **Regtest (RPC):** 13337

### Address Prefixes
* **P2PKH (PUBKEY_ADDRESS):** 50 (addresses start with 'M')
* **P2SH (SCRIPT_ADDRESS):** 55 (addresses start with 'Q' or 'R')
* **WIF (SECRET_KEY):** 178 (private keys start with '7')
* **Bech32 HRP:** `mfc` (mainnet), `tmfc` (testnet), `rmfc` (regtest)

## 💰 Distribution

Multicoin is distributed through:
* **Faucet:** [Multifaucet.eu](https://multifaucet.eu)
* **Offerwalls:** Earn MFC by completing offers
* **Mining:** Solo and pool mining available
* **Games:** Play-to-earn on Multifaucet platform

## ⛏️ Mining

### Solo Mining
Solo mining is available directly through the wallet:
```bash
multicoind -daemon
multicoin-cli generatetoaddress 1 <your_mfc_address>
```

### Pool Mining
Pool mining is fully supported and encouraged for network decentralization.

**Running a public pool?** Please notify us at admin@multifaucet.eu so we can list it on our website.

**Official Pools:**
* Coming soon - community submissions welcome!

### Mining Pools - Technical Info
* **Algorithm:** Scrypt
* **Difficulty Retarget:** Every block (DGW - Dark Gravity Wave)
* **Network Hashrate:** View at [Multifaucet Explorer](https://explorer.multifaucet.eu) *(if available)*

## 🔧 Building from Source

### Dependencies
* GCC 7+ or Clang 5+
* Berkeley DB 4.8
* Boost 1.64+
* Qt 5.9+ (for GUI)
* miniupnpc
* libnatpmp
* ZeroMQ (optional)

### Linux
```bash
sudo apt-get install build-essential libtool autotools-dev automake pkg-config bsdmainutils curl git
sudo apt-get install libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-thread-dev
sudo apt-get install libevent-dev libminiupnpc-dev libnatpmp-dev libzmq3-dev
sudo apt-get install qtbase5-dev qttools5-dev qttools5-dev-tools

./autogen.sh
./configure
make -j$(nproc)
sudo make install
```

### Windows (Cross-Compile from Ubuntu)
```bash
sudo apt-get install g++-mingw-w64-x86-64 mingw-w64-x86-64-dev

# Set POSIX threads
sudo update-alternatives --set x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix
sudo update-alternatives --set x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix

# Build dependencies
cd depends
make HOST=x86_64-w64-mingw32 -j$(nproc)
cd ..

# Build Multicoin
./autogen.sh
CONFIG_SITE=$PWD/depends/x86_64-w64-mingw32/share/config.site ./configure --prefix=/
make -j$(nproc)
```

### macOS
```bash
brew install automake libtool boost miniupnpc pkg-config python qt@5 zmq

./autogen.sh
./configure
make -j$(sysctl -n hw.ncpu)
sudo make install
```

## 📱 Wallet

### GUI Wallet (multicoin-qt)
Download pre-built binaries from [Releases](https://github.com/Multifaucet-CEO/MFC/releases)

### Command Line
```bash
# Start daemon
multicoind -daemon

# Check balance
multicoin-cli getbalance

# Send coins
multicoin-cli sendtoaddress <address> <amount>

# Get new address
multicoin-cli getnewaddress

# Stop daemon
multicoin-cli stop
```

## 🔗 Links

* **Website:** [Multifaucet.eu](https://multifaucet.eu)
* **Faucet:** [Multifaucet.eu](https://multifaucet.eu)
* **GitHub:** [github.com/Multifaucet-CEO/MFC](https://github.com/Multifaucet-CEO/MFC)
* **Support:** admin@multifaucet.eu

## 📜 License

Multicoin Core is released under the terms of the MIT license. See [COPYING](COPYING) for more information or see https://opensource.org/licenses/MIT.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## ⚠️ Disclaimer

This is experimental software. Use at your own risk. Cryptocurrency investments can be volatile and risky.

---

**Built with ❤️ for the Multifaucet.eu community**