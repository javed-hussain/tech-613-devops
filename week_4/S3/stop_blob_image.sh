#!/bin/bash

set eu
export USE_MARKER_IMAGES=false
pm2 restart tictactoe --update-env

aws s3 rb s3://tech613-javed-ttt-app-script-bucket --force