#!/bin/bash
set -eu

sudo -iu ubuntu bash <<'EOF'

set -eu
BUCKET="tech613-javed-ttt-app-script-bucket"

#
curl -o x.png https://pngimg.com/uploads/cat/cat_PNG115421.png
curl -o o.png https://pngimg.com/uploads/dog/dog_PNG50411.png

aws s3 mb s3://$BUCKET --region eu-west-1
aws s3 cp x.png s3://$BUCKET
aws s3 cp o.png s3://$BUCKET

# 1. Allow public bucket policies, but keep public ACLs blocked
aws s3api put-public-access-block \
  --bucket "$BUCKET" \
  --public-access-block-configuration \
  "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"

# 2. Write the public-read policy to a JSON file
cat > marker-policy.json <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": [
        "arn:aws:s3:::$BUCKET/x.png",
        "arn:aws:s3:::$BUCKET/o.png"
      ]
    }
  ]
}
POLICY

# 3. Apply the policy to the bucket
aws s3api put-bucket-policy \
  --bucket "$BUCKET" \
  --policy file://marker-policy.json

cd /home/ubuntu/tictactoe-deploy/app
export USE_MARKER_IMAGES=true
export MARKER_IMAGES_PATH=https://$BUCKET.s3.eu-west-1.amazonaws.com
pm2 restart tictactoe --update-env
pm2 save
EOF