#!/bin/bash

# Specify the path to your HTML file
html_file="your_file.html"

# Use awk to extract value associated with "risk-3" and "High"
awk -F'</?div>' '/<td class="risk-3">/{getline; risk_value=$2; found_risk=1} /<td align="center">/{if(found_risk) {getline; center_value=$2; exit}} END {if (found_risk) print center_value}' "$html_file" | while read -r risk3_value; do
    quality_gate="yes"  # Set this variable based on your criteria
    
    if [[ "$quality_gate" == "yes" ]]; then
        if [[ "$risk3_value" == "0" ]]; then
            echo "Quality Gate Parameter: Yes"
            echo "Risk-3 Value: $risk3_value"
            echo "Success"
        else
            echo "Quality Gate Parameter: Yes"
            echo "Risk-3 Value: $risk3_value"
            echo "Failed"
            exit 1  # Exit the script with an error code
        fi
    elif [[ "$quality_gate" == "nothing" ]]; then
        echo "Quality Gate Parameter: Nothing"
        echo "Risk-3 Value: $risk3_value"
    else
        echo "Invalid quality gate parameter"
        exit 1  # Exit the script with an error code
    fi
done

------------------------------------

#!/bin/bash

# Specify the path to your HTML file
html_file="your_file.html"

# Use awk to extract value associated with "risk-3" and "High"
awk -F'</?div>' '/<td class="risk-3">/{getline; risk_value=$2; found_risk=1} /<td align="center">/{if(found_risk) {getline; center_value=$2; print "Risk-3 Value: " center_value; exit}}' "$html_file"
------------------------------------

I'm not sure about how BlackDuck services are written in Python, but Rob may explain. Let me clarify how the container works. Inside the container, we install Python 3. Regarding the pip configuration, we've designed the container to capture your local system's `.config/pip` using the mount option. When users run the Docker, we ask them to mount their local `.config/pip/` inside the container, ensuring a match with the user's pip.config. Therefore, any calls from the `requirements.txt` file will use the settings from pip.config. In your case, since you're using a cluster and mounting volumes, by default, the container will reflect whatever your cluster root contains. We've built the latest container, fixed the version, but currently, we're facing an issue with uploading files to the landing pad. Once this issue is resolved, we should be good with the Python issue as well.
