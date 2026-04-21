#!/bin/bash
set -e

COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[1;33m'
COLOR_RESET='\033[0m'

echo "========================================="
echo "nexflow-tunnel - Code Linting"
echo "========================================="

# Find all C++ files
CPP_FILES=$(find containers common -name "*.cpp" 2>/dev/null || echo "")
HPP_FILES=$(find containers common -name "*.hpp" 2>/dev/null || echo "")

if [ -z "$CPP_FILES" ] && [ -z "$HPP_FILES" ]; then
    echo -e "${COLOR_YELLOW}⚠️ No C++ files found. Skipping linting.${COLOR_RESET}"
    exit 0
fi

# Run clang-format
echo -e "${COLOR_YELLOW}[1/2] Running clang-format...${COLOR_RESET}"
for file in $CPP_FILES $HPP_FILES; do
    clang-format --dry-run --Werror "$file" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "${COLOR_RED}❌ Formatting error in: $file${COLOR_RESET}"
        echo "Run: clang-format -i \"$file\""
        exit 1
    fi
done
echo -e "${COLOR_GREEN}✅ clang-format passed${COLOR_RESET}"

# Run clang-tidy (only on .cpp files)
echo -e "${COLOR_YELLOW}[2/2] Running clang-tidy...${COLOR_RESET}"
for file in $CPP_FILES; do
    clang-tidy "$file" --warnings-as-errors=* 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "${COLOR_RED}❌ Tidy error in: $file${COLOR_RESET}"
        exit 1
    fi
done
echo -e "${COLOR_GREEN}✅ clang-tidy passed${COLOR_RESET}"

echo "========================================="
echo -e "${COLOR_GREEN}✅ All linting checks passed${COLOR_RESET}"
echo "========================================="
