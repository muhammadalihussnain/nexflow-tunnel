#!/bin/bash
set -e

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_RESET='\033[0m'

echo "========================================="
echo "nexflow-tunnel - Running Tests"
echo "========================================="

# Build
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug
make -j $(nproc)

# Run unit tests
echo -e "${COLOR_YELLOW}[1/3] Unit tests...${COLOR_RESET}"
ctest --output-on-failure -R unit -C Debug

# Run integration tests
echo -e "${COLOR_YELLOW}[2/3] Integration tests...${COLOR_RESET}"
ctest --output-on-failure -R integration -C Debug

# Run with sanitizers
echo -e "${COLOR_YELLOW}[3/3] Sanitizer tests...${COLOR_RESET}"
cmake .. -DENABLE_ASAN=ON -DENABLE_UBSAN=ON
make -j $(nproc)
ctest --output-on-failure

cd ..
echo -e "${COLOR_GREEN}✅ All tests passed${COLOR_RESET}"
