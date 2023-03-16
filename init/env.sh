#!/bin/sh

# env.sh

# Change the contents of this output to get the environment variables
# of interest. The output must be valid JSON, with strings for both
# keys and values.
cat <<EOF
{
  "GITHUB_TOKEN": "$GITHUB_TOKEN",
  "PM_API_TOKEN_SECRET": "$PM_API_TOKEN_SECRET"
}
EOF