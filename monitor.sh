#/bin/bash

if pgrep -x "test" > /dev/null; then
    echo "test is running"
else
    echo "test is not running"
fi
sleep 1