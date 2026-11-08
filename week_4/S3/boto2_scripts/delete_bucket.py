import boto3
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("bucket_name")
args = parser.parse_args()

s3 = boto3.client("s3", region_name="eu-west-1")

bucket_name = args.bucket_name

s3.delete_bucket(Bucket=bucket_name)

print(f"Deleted bucket: {bucket_name}")