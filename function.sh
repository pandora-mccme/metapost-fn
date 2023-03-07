#!/usr/bin/bash

WD=$(mktemp -d)
cd "$WD" || exit 1
cat > figure.mp

mptopdf figure.mp > /dev/stderr
pdf2svg figure-1.pdf figure.svg > /dev/stderr

cat figure.svg
cd || exit 1
rm -rf "$WD"