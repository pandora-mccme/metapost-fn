#!/usr/bin/bash

cat > /tmp/figure.mp

mptopdf /tmp/figure.mp
pdftosvg /tmp/figure-1.pdf /tmp/figure.svg

cat /tmp/figure.svg