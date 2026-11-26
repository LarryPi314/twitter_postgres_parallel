#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
echo "$files" | time parallel -j 10 ./load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
echo "$files" | time parallel -j 10 python3 load_tweets.py --db=postgresql://postgres:pass@localhost:11490/postgres --inputs

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
echo "$files" | time parallel -j 10 python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:11500/ --inputs
