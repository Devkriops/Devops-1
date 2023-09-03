Data: file path
# Open the file for reading (change 'dates.txt' to your file's name)
with open('dates.txt', 'r') as file:
    # Loop through each line in the file
    for line in file:
        # Remove leading and trailing whitespace from the line
        line = line.strip()
        
        # Process the raw date string (You can replace this part with your own logic)
        print(f"Raw Date: {line}")
        
        # Add your date parsing and processing logic here
        # For example, you can use date parsing libraries like datetime to work with dates

        # For illustration, let's assume we want to split the date string by '-' and print the parts
        date_parts = line.split('-')
        print(f"Year: {date_parts[0]}, Month: {date_parts[1]}, Day: {date_parts[2]}\n")
