#!/bin/bash
set -e

echo "========================================="
echo "nexflow-tunnel - Code Linting"
echo "========================================="

echo "[1/2] Running clang-format..."

# Find all C++ files
CPP_FILES=$(find containers common -name "*.cpp" -o -name "*.hpp" 2>/dev/null || echo "")

if [ -z "$CPP_FILES" ]; then
    echo "✅ No C++ files to check"
    echo "========================================="
    echo "✅ All linting checks passed"
    echo "========================================="
    exit 0
fi

# Check formatting
for file in $CPP_FILES; do
    clang-format --dry-run --Werror "$file"
done

echo "✅ clang-format passed"
echo "========================================="
echo "✅ All linting checks passed"
echo "========================================="
