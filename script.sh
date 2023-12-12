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

    echo "🧪 Run Tests"
    very_good test -j 4 --coverage --test-randomize-ordering-seed random
}

# Function for sorting imports
code_gen() {
    dart run build_runner build --delete-conflicting-outputs
    dart run import_sorter:main
}

# Function to run tests, generate and report
test() {
    very_good test --coverage --test-randomize-ordering-seed random
    genhtml coverage/lcov.info -o coverage/
}

# Main menu for selecting an action
echo "Select an action:"
echo "[0] Reset dependencies"
echo "[1] Simulate build in Github Action"
echo "[2] Code generation"
echo "[3] Run tests"
read -p "Enter your choice: " choice

case $choice in
    0) reset ;;
    1) build ;;
    2) code_gen ;;
    3) test ;;
    *) echo "Invalid selection"; exit 1 ;;
esac
