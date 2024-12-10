#/bin/bash

# логирование
function LOG() {
    if [ "$1" == "info" ]; then
        prefix="[INFO]"
    elif [ "$1" == "error" ]; then
        prefix="[ERROR]"
    fi

    echo -e "[$(date +'%Y-%m-%d %H:%M:%S')] $prefix $2" >> /var/log/monitor.log # не уверен, будет ли logrotate чистить наш лог - на заметку
}

if pgrep -x "test" > /dev/null; then
    LOG info "test is running"
else
    LOG error "test is not running"
fi