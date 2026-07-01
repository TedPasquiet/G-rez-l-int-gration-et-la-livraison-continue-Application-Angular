#!/bin/bash

# Script to run Angular tests and generate JUnit XML report for GitLab CI

# Check that node is installed
if ! command -v node &>/dev/null; then
    echo "Error: node is not installed"
    exit 1
fi
if ! command -v npm &>/dev/null; then
    echo "Error: npm is not installed"
    exit 1
fi
# Check if angular exists
if [ ! -f "./angular.json" ]; then
    echo "Error: angular not found"
    exit 1
fi
# Check if package exists
if [ ! -f "./package.json" ]; then
    echo "Error: package not found"
    exit 1
fi
# Clean   
rm -rf test-results
rm -rf reports   
# Install dependencies
npm ci --cache .npm --prefer-offline

npm test
TEST_EXIT_CODE=$?

# Copy Test reports to test-results folder
# Gradle generates JUnit XML reports in build/test-results/test/
mkdir -p test-results
cp -r reports/. test-results/

# Exit with the test exit code so GitLab CI knows if tests passed or failed
exit $TEST_EXIT_CODE
