#!/bin/bash
# Save as: ~/show-colors.sh

echo "═══════════════════════════════════════"
echo "  BASH COLOR REFERENCE CHART"
echo "═══════════════════════════════════════"
echo ""

echo "Standard Colors:"
for i in {30..37}; do
    echo -e "\e[${i}m  Color $i  \e[0m  Code: \\e[${i}m"
done
echo ""

echo "Bright Colors:"
for i in {90..97}; do
    echo -e "\e[${i}m  Color $i  \e[0m  Code: \\e[${i}m"
done
echo ""

echo "Bold Colors:"
for i in {30..37}; do
    echo -e "\e[1;${i}m  Bold Color 1;$i  \e[0m  Code: \\e[1;${i}m"
done
echo ""

echo "256 Color Samples (some favorites):"
for color in 196 202 226 118 46 51 21 27 33 39 63 201 208 214; do
    echo -e "\e[38;5;${color}m  Color ${color}  \e[0m  Code: \\e[38;5;${color}m"
done
