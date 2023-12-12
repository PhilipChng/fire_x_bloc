#!/bin/bash

# Function to reset dependencies
reset() {
    rm pubspec.lock
    flutter clean
    flutter pub get
}

# Function to simulate build in Github Action
build() {
    echo "✨ Check Formatting"
    dart format --line-length 80 --set-exit-if-changed lib test

    echo "🕵️ Analyze"
    flutter analyze lib test
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
echo "[1] Simulate Github Action build"
echo "[2] Run tests"
echo "[9] Sort imports"
read -p "Enter your choice: " choice

case $choice in
    0) reset ;;
    1) build ;;
    2) test ;;
    9) import_sorter ;;
    *) echo "Invalid selection"; exit 1 ;;
esac
