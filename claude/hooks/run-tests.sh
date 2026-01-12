#!/bin/bash

if [ -x "bin/test.sh" ]; then
    bin/test.sh
    exit $?
else
    echo "bin/test.sh not found or not executable. Each project should have a bin/test.sh script." >&2
    exit 1
fi
