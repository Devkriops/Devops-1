#!/bin/bash

# Specify the path to your HTML file
html_file="your_file.html"

# Use awk to extract values associated with "High" and "0"
high_value=$(awk -F'</?div>' '/<td class="risk-3">/{getline; print $2}' "$html_file")
zero_value=$(awk -F'</?div>' '/<td align="center">/{getline; print $2}' "$html_file")

# Print the results
echo "High Value: $high_value"
echo "Zero Value: $zero_value"
------------------------------------

#!/bin/bash

# Specify the path to your HTML file
html_file="your_file.html"

# Use awk to extract value associated with "risk-3" and "High"
awk -F'</?div>' '/<td class="risk-3">/{getline; risk_value=$2; found_risk=1} /<td align="center">/{if(found_risk) {getline; center_value=$2; print "Risk-3 Value: " center_value; exit}}' "$html_file"
