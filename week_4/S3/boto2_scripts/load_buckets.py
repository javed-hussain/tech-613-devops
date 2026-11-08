import boto3

s3 = boto3.client("s3")

response = s3.list_buckets()

for bucket in response["Buckets"]:
    print(bucket["Name"])

"""
paginators are used for retrieving large set of results in batches
Each batch is a page
get_paginator creates the paginator helper for the specified command
.paginate() goes through and retrieves each page 

for page in s3.get_paginator("list_buckets").paginate():

    "loops through the list of buckets on each page and prints their name"
    for bucket in page["Buckets"]:
        print(bucket["Name"])

"""