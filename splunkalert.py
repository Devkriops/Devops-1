import requests

# Define your Splunk server URL and credentials
splunk_url = 'https://your-splunk-server:8089'
splunk_username = 'your_username'
splunk_password = 'your_password'

# Define the search query or job you want to trigger
search_query = 'index=myindex sourcetype=mytype | stats count by field'

# Create a session to maintain the Splunk connection
session = requests.Session()

# Authenticate with Splunk
login_url = f'{splunk_url}/services/auth/login'
login_payload = {'username': splunk_username, 'password': splunk_password}
login_response = session.post(login_url, data=login_payload)

if login_response.status_code != 200:
    print(f'Failed to authenticate with Splunk: {login_response.text}')
    exit()

# Create the search job
search_url = f'{splunk_url}/services/search/jobs'
search_payload = {'search': search_query}
search_response = session.post(search_url, data=search_payload)

if search_response.status_code != 201:
    print(f'Failed to create search job: {search_response.text}')
    exit()

job_id = search_response.text  # Extract the job ID from the response

# Optionally, you can wait for the job to finish or perform other actions here
# For example, you can poll the job status using the job_id

# Close the session
session.close()
