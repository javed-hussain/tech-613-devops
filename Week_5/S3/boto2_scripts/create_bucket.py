import boto3
import argparse

parser = argparse.ArgumentParser(description="Create an S3 bucket")
parser.add_argument("bucket_name", help="Name of the S3 bucket to create")
args = parser.parse_args()

s3 = boto3.client("s3", region_name="eu-west-1")

bucket_name = args.bucket_name

s3.create_bucket(
    Bucket=bucket_name,
    CreateBucketConfiguration={"LocationConstraint": "eu-west-1"}
)

print("Created bucket:", bucket_name)