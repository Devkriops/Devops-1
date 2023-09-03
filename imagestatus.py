import boto3
import json

def lambda_handler(event, context):
    # Initialize AWS clients for ECR and IAM
    ecr_client = boto3.client('ecr')
    iam_client = boto3.client('iam')

    # List all Docker images in the ECR repository
    repository_name = 'your-ecr-repository-name'
    try:
        response = ecr_client.list_images(repositoryName=repository_name)
        image_ids = response['imageIds']
    except ecr_client.exceptions.RepositoryNotFoundException:
        return {
            'statusCode': 404,
            'body': json.dumps('ECR repository not found.')
        }

    # Iterate through the Docker images and retrieve user information
    user_info = []
    for image_id in image_ids:
        image_digest = image_id['imageDigest']
        image_tags_response = ecr_client.list_image_tags(repositoryName=repository_name, imageIds=[{'imageDigest': image_digest}])
        tags = image_tags_response.get('imageTag')
        if tags:
            for tag in tags:
                # Assuming the tag contains user information (e.g., username)
                user_info.append(tag)

    # Check if user information is found
    if not user_info:
        return {
            'statusCode': 200,
            'body': json.dumps('No user information found for Docker images.')
        }

    # Return the user information as a JSON response
    return {
        'statusCode': 200,
        'body': json.dumps(user_info)
    }
