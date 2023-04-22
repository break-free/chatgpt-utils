#!/bin/bash

##
# Script that calls ChatGPT with questions written on the command line (not
# quoted, no '' or ""). Can pass data to ChatGPT using:
#
#     `chatgpt.sh <OPENAI_TOKEN> use this data $(cat example.csv)
#
# ... or similar.
#
# Code based on the example provided here:
#
#     https://kadekillary.work/posts/1000x-eng/.
#
# Note that orginal code is in `fish`, and was coed into `bash`
#
# @author: Chris Mills, cjmills@gmail.com
# @date: Apr 3, 2023
##

OPENAI_KEY="$1" # API Key
PROMPT="${@:2}" # Capture all arguments after script as query to GPT.

# model: gpt-4 is in private beta (have to get from waitlist)
# model: gpt-3.5-turbo (if you don't have access)
echo
curl https://api.openai.com/v1/chat/completions -s \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $OPENAI_KEY" \
    -d '{
          "model": "gpt-3.5-turbo",
          "messages": [{ "role": "user", "content": "'"$PROMPT"'" }],
          "temperature": 0.7,
          "stream": false
        }' | jq -r -j '.choices[0].message.content'
echo
