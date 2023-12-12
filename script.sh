#!/bin/bash

# Function to reset dependencies
reset() {
    rm pubspec.lock
    flutter clean
    flutter pub get
}

# Function to run tests, generate and report
test() {
    very_good test --coverage --test-randomize-ordering-seed random
    genhtml coverage/lcov.info -o coverage/
}

# Function for sorting imports
import_sorter() {
    dart run import_sorter:main
}

# Main menu for selecting an action
echo "Select an action:"
echo "[0] Reset dependencies"
echo "[1] Run tests"
echo "[2] Sort imports"
read -p "Enter your choice: " choice

case $choice in
    0) reset ;;
    1) test ;;
    2) import_sorter ;;
    *) echo "Invalid selection"; exit 1 ;;
esac
