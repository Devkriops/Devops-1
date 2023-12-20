#!/bin/bash

# Specify the path to your HTML file
html_file="your_file.html"

# Extract the value associated with "High"
high_value=$(grep -oP '<td class="risk-3">\s*<div>\K[^<]+' "$html_file")

# Extract the value associated with "0"
zero_value=$(grep -oP '<td align="center">\s*<div>\K[^<]+' "$html_file")

# Print the results
echo "High Value: $high_value"
echo "Zero Value: $zero_value"
