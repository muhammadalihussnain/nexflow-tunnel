#!/bin/bash
set -e

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_RESET='\033[0m'

echo "========================================="
echo "nexflow-tunnel - Code Coverage"
echo "========================================="

# Build with coverage
mkdir -p build-coverage
cd build-coverage
cmake .. -DCMAKE_BUILD_TYPE=Debug -DENABLE_COVERAGE=ON
make -j $(nproc)

# Run tests
./tests/nexflow_tests

# Generate coverage report
lcov --capture --directory . --output-file coverage.info --no-external
lcov --remove coverage.info '/usr/*' '*/tests/*' --output-file coverage-filtered.info
genhtml coverage-filtered.info --output-directory ../coverage-report

# Get coverage percentage
COVERAGE=$(lcov --summary coverage-filtered.info 2>&1 | grep "lines" | awk '{print $2}' | sed 's/%//')

echo "========================================="
echo "Coverage: ${COVERAGE}%"
echo "========================================="

# Enforce 100% coverage
if (( $(echo "$COVERAGE < 100" | bc -l) )); then
    echo -e "${COLOR_RED}❌ Coverage is ${COVERAGE}%, but 100% required${COLOR_RESET}"
    echo "Report generated at: $(pwd)/../coverage-report/index.html"
    exit 1
fi

echo -e "${COLOR_GREEN}✅ Coverage is ${COVERAGE}% - Excellent!${COLOR_RESET}"
echo "Report: $(pwd)/../coverage-report/index.html"

cd ..
