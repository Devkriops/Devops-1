import socket

# List of target hosts and ports to check
targets = [
    ("example.com", 80),  # Replace with your target host and port combinations
    ("192.168.1.1", 22),  # Example: Check SSH on a local IP
]

def check_port(host, port):
    try:
        # Create a socket object
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        
        # Set a timeout to avoid hanging indefinitely
        s.settimeout(2)
        
        # Attempt to connect to the host and port
        result = s.connect_ex((host, port))
        
        if result == 0:
            print(f"Port {port} is open on {host}")
        else:
            print(f"Port {port} is closed on {host}")
        
        # Close the socket
        s.close()
    
    except socket.error:
        print(f"Could not connect to {host}:{port}")

# Loop through the list of targets and check the specified ports
for target in targets:
    host, port = target
    check_port(host, port)
