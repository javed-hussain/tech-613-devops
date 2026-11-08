import boto3
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("bucket_name")
args = parser.parse_args()

s3 = boto3.client("s3", region_name="eu-west-1")
bucket_name = args.bucket_name

#List the objects in specified bucket as a dictionary 
#In the dictionary is a contents list (stores every object)
# each object is a dictionary in itself with "Key" = kaye name and then 
# other metadata
response = s3.list_objects_v2(Bucket=bucket_name)

for obj in response.get("Contents", []):
    print(obj["Key"])

"""

paginators are used for retrieving large set of results in batches
Each batch is a page
get_paginator creates the paginator helper for the specified command
.paginate() goes through and retrieves each page 

for page in s3.get_paginator("list_objects_v2").paginate(Bucket=bucket_name):
    for obj in page.get("Contents", []):
        print(obj["Key"])
        
"""