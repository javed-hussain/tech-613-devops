import boto3
import argparse

parser = argparse.ArgumentParser(description="delete an object in a S3 bucket")
parser.add_argument("bucket_name", help="Name of the S3 bucket")
parser.add_argument("file_name", help="Name of the file to delete")
args = parser.parse_args()

s3 = boto3.client("s3", region_name="eu-west-1")

bucket_name = args.bucket_name
file_name = args.file_name

s3.delete_object(Bucket=bucket_name, Key=file_name)

print(f"Deleted {file_name} from {bucket_name}")