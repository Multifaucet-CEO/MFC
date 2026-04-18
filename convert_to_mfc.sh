#!/bin/bash
# Automatisches Multicoin → Multicoin (MFC) Konvertierungs-Script
# Erstellt am: 18.04.2026

echo "=========================================="
echo "Multicoin → Multicoin (MFC) Konvertierung"
echo "=========================================="
echo ""

# Farben für Ausgabe
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Schritt 1: Text-Ersetzungen (Multicoin → Multicoin)
echo -e "${BLUE}[1/5] Ersetze Multicoin → Multicoin in allen Dateien...${NC}"

# Finde alle relevanten Dateien (außer .git, node_modules, etc.)
find . -type f \
  -not -path "./.git/*" \
  -not -path "./depends/*" \
  -not -path "./build/*" \
  -not -name "*.o" \
  -not -name "*.a" \
  -exec grep -l "multicoin\|Multicoin\|MULTICOIN\|MUC" {} \; 2>/dev/null | while read file; do
    
    # Text-Ersetzungen
    sed -i 's/multicoin/multicoin/g' "$file"
    sed -i 's/Multicoin/Multicoin/g' "$file"
    sed -i 's/MULTICOIN/MULTICOIN/g' "$file"
    sed -i 's/\bLTC\b/MUC/g' "$file"
    sed -i 's/\bltc\b/muc/g' "$file"
done

echo -e "${GREEN}✓ Text-Ersetzungen abgeschlossen${NC}"

# Schritt 2: chainparams.cpp - Ports ändern
echo -e "${BLUE}[2/5] Ändere Ports in src/chainparams.cpp...${NC}"

if [ -f "src/chainparams.cpp" ]; then
    # Mainnet Port: 9333 → 13333
    sed -i 's/nDefaultPort = 9333;/nDefaultPort = 13333;/g' src/chainparams.cpp
    
    # Testnet Port: 19335 → 13334
    sed -i 's/nDefaultPort = 19335;/nDefaultPort = 13334;/g' src/chainparams.cpp
    
    # Regtest Port: 19444 → 13335
    sed -i 's/nDefaultPort = 19444;/nDefaultPort = 13335;/g' src/chainparams.cpp
    
    echo -e "${GREEN}✓ Ports geändert: 13333 (Main), 13334 (Test), 13335 (Regtest)${NC}"
else
    echo -e "${RED}✗ src/chainparams.cpp nicht gefunden!${NC}"
fi

# Schritt 3: chainparams.cpp - Adresspräfixe ändern
echo -e "${BLUE}[3/5] Ändere Adresspräfixe...${NC}"

if [ -f "src/chainparams.cpp" ]; then
    # Mainnet: PUBKEY_ADDRESS 48 → 50
    sed -i 's/base58Prefixes\[PUBKEY_ADDRESS\] = std::vector<unsigned char>(1,48);/base58Prefixes[PUBKEY_ADDRESS] = std::vector<unsigned char>(1,50);/g' src/chainparams.cpp
    
    # Mainnet: SCRIPT_ADDRESS 5 → 55
    sed -i 's/base58Prefixes\[SCRIPT_ADDRESS\] = std::vector<unsigned char>(1,5);/base58Prefixes[SCRIPT_ADDRESS] = std::vector<unsigned char>(1,55);/g' src/chainparams.cpp
    
    # Mainnet: SECRET_KEY 176 → 178
    sed -i 's/base58Prefixes\[SECRET_KEY\] =     std::vector<unsigned char>(1,176);/base58Prefixes[SECRET_KEY] =     std::vector<unsigned char>(1,178);/g' src/chainparams.cpp
    
    echo -e "${GREEN}✓ Adresspräfixe geändert: PUBKEY=50, SCRIPT=55, SECRET=178${NC}"
else
    echo -e "${RED}✗ src/chainparams.cpp nicht gefunden!${NC}"
fi

# Schritt 4: DNS Seeds auskommentieren
echo -e "${BLUE}[4/5] Kommentiere DNS Seeds aus...${NC}"

if [ -f "src/chainparams.cpp" ]; then
    # Kommentiere alle vSeeds.emplace_back Zeilen aus (Mainnet)
    sed -i '/vSeeds\.emplace_back("seed-a\.multicoin\.loshan\.co\.uk");/s/^/\/\/ /' src/chainparams.cpp
    sed -i '/vSeeds\.emplace_back("dnsseed\.thrasher\.io");/s/^/\/\/ /' src/chainparams.cpp
    sed -i '/vSeeds\.emplace_back("dnsseed\.multicointools\.com");/s/^/\/\/ /' src/chainparams.cpp
    sed -i '/vSeeds\.emplace_back("dnsseed\.multicoinpool\.org");/s/^/\/\/ /' src/chainparams.cpp
    sed -i '/vSeeds\.emplace_back("dnsseed\.koin-project\.com");/s/^/\/\/ /' src/chainparams.cpp
    
    # Kommentiere Testnet DNS Seeds aus
    sed -i '/vSeeds\.emplace_back("testnet-seed\.multicointools\.com");/s/^/\/\/ /' src/chainparams.cpp
    sed -i '/vSeeds\.emplace_back("seed-b\.multicoin\.loshan\.co\.uk");/s/^/\/\/ /' src/chainparams.cpp
    sed -i '/vSeeds\.emplace_back("dnsseed-testnet\.thrasher\.io");/s/^/\/\/ /' src/chainparams.cpp
    
    echo -e "${GREEN}✓ DNS Seeds auskommentiert${NC}"
else
    echo -e "${RED}✗ src/chainparams.cpp nicht gefunden!${NC}"
fi

# Schritt 5: README.md anpassen
echo -e "${BLUE}[5/5] Passe README.md an...${NC}"

if [ -f "README.md" ]; then
    cat > README.md << 'EOF'
# Multicoin (MFC)

Multicoin (MFC) is a cryptocurrency based on Multicoin Core 0.21.4.

## Specifications

- **Ticker:** MUC (Mainnet), TMUC (Testnet), RMUC (Regtest)
- **Algorithm:** Scrypt PoW
- **Block Time:** 2.5 minutes
- **Block Reward:** 50 MUC (initial)
- **Halving:** Every 840,000 blocks
- **Max Supply:** 84 million MUC
- **Network Ports:** 
  - Mainnet: 13333
  - Testnet: 13334
  - Regtest: 13335

## Address Prefixes

- PUBKEY_ADDRESS: 50
- SCRIPT_ADDRESS: 55
- SECRET_KEY: 178
- Bech32 HRP: "muc" (mainnet), "tmuc" (testnet), "rmuc" (regtest)

## Distribution

Coins are distributed through Multifaucet.eu platform.

## Mining

- Solo mining available via wallet RPC
- Pool mining allowed only with written permission from Multifaucet.eu
- No staking (PoW only)

## Building

See [INSTALL.md](INSTALL.md) for build instructions.

## License

Multicoin is released under the terms of the MIT license. See [COPYING](COPYING) for more information.
EOF
    echo -e "${GREEN}✓ README.md erstellt${NC}"
else
    echo -e "${RED}✗ README.md nicht gefunden!${NC}"
fi

echo ""
echo -e "${GREEN}=========================================="
echo "Konvertierung abgeschlossen! ✓"
echo "==========================================${NC}"
echo ""
echo "Dein Multicoin-Code wurde erfolgreich zu Multicoin (MFC) konvertiert!"
echo ""
echo "Nächste Schritte:"
echo "  1. Überprüfe die Änderungen: git status"
echo "  2. Füge zu Git hinzu: git add ."
echo "  3. Committe: git commit -m 'Convert Multicoin to Multicoin (MFC)'"
echo "  4. Pushe zu GitHub: git push"
echo ""
