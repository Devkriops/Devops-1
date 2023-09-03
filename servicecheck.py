import requests

# Define the service URL
service_url = 'https://api.example.com/'

# Define a function to test a specific endpoint
def test_endpoint(endpoint):
    url = service_url + endpoint

    # Send a GET request to the endpoint
    response = requests.get(url)

    # Check the response status code
    if response.status_code == 200:
        print(f'Success: Endpoint {endpoint} is working correctly.')
    else:
        print(f'Error: Endpoint {endpoint} returned status code {response.status_code}.')

# Define the endpoints you want to test
endpoints_to_test = [
    'endpoint1',
    'endpoint2',
    # Add more endpoints as needed
]

# Perform tests for each endpoint
for endpoint in endpoints_to_test:
    test_endpoint(endpoint)
