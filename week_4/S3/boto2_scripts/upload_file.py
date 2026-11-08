import boto3
import argparse

parser = argparse.ArgumentParser(description="argparse")
parser.add_argument("bucket_name")
parser.add_argument("file_name")
args = parser.parse_args()

s3 = boto3.client("s3", region_name="eu-west-1")

bucket_name = args.bucket_name
file_name = args.file_name

s3.upload_file(file_name, bucket_name, 
               file_name)

print(f"Uploaded {file_name}")