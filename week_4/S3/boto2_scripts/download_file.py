import boto3
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("bucket_name")
parser.add_argument("file_name")
parser.add_argument("key")
args = parser.parse_args()

s3 = boto3.client("s3", region_name="eu-west-1")

bucket_name = args.bucket_name
file_name = args.file_name
key = args.key


s3.download_file(bucket_name, file_name, key)

print(f"Downloaded {file_name} as {key}")