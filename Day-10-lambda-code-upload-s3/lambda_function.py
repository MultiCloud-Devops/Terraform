def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': 'Lambda Created from Terraform and Code accessed for S3!'
    }