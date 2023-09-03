#!/bin/bash

json_file_path="path_to_your_json_file.json"
combined_str=""

# Read JSON data from file
data=$(cat "$json_file_path")

# Extract vulnerability information
total=$(echo "$data" | jq -r '.vulnerabilities.byseverity[]')

# Initialize an associative array for storing severity counts
declare -A severity_counts

# Loop through vulnerability data and populate the severity_counts array
for entry in $total; do
    severity_label=$(echo "$entry" | jq -r '.severity.label')
    label_total=$(echo "$entry" | jq -r '.total')

    severity_counts["$severity_label"]=$label_total
done

# Create the combined string
for severity in "${!severity_counts[@]}"; do
    combined_str+="$severity=${severity_counts[$severity]} "
done

echo "$combined_str"




# Print the extracted values
echo "Result: $result"
echo "Scan URL: $scan_url"
echo "Vulnerabilities: Critical=$critical_count; High=$high_count; Medium=$medium_count; Low=$low_count"

slack_message=$(cat <<EOF
{
  "channel": "$YOUR_CHANNEL_ID",
  "text": "Sysdig Result: \"$result\"\nVulnerabilities: Critical=$critical_count; High=$high_count; Medium=$medium_count; Low=$low_count\nSysdigURL: \"$scan_url\""
}
EOF
)

