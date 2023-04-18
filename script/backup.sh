#!/bin/bash

#Force file syncronization and lock writes
mongo admin --eval "printjson(db.fsyncLock())"

MONGODUMP_PATH="/usr/bin/mongodump"
MONGO_HOST="127.0.0.1" #replace with your server ip
MONGO_PORT="27017"
MONGO_DATABASE="customerapp" #replace with your database name

TIMESTAMP=`date +%F-%H%M`
S3_BUCKET_NAME="bucket_name" #replace with your bucket name on Amazon S3
S3_BUCKET_PATH="s3://bucket_name/"

# Create backup
$MONGODUMP_PATH -h $MONGO_HOST:$MONGO_PORT -d $MONGO_DATABASE

# Add timestamp to backup
mv dump mongodb-$HOSTNAME-$TIMESTAMP
tar cf mongodb-$HOSTNAME-$TIMESTAMP.tar mongodb-$HOSTNAME-$TIMESTAMP

# Upload to S3
s3cmd put mongodb-$HOSTNAME-$TIMESTAMP.tar  $S3_iBUCKET_PATH

#Unlock database writes
mongo admin --eval "printjson(db.fsyncUnlock())"
