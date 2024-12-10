#/bin/bash

PROCESS = "alacritty"

# логирование
function LOG() {
    if [ "$1" == "info" ]; then
        prefix="[INFO]"
    elif [ "$1" == "error" ]; then
        prefix="[ERROR]"
    fi

    echo -e "[$(date +'%Y-%m-%d %H:%M:%S')] $prefix $2" >> /var/log/monitor.log # не уверен, будет ли logrotate чистить наш лог - на заметку
}

if pgrep -x $PROCESS > /dev/null; then
    echo "$(pgrep -x $PROCESS)" > /tmp/monitor-pid
    if curl https://test.com/monitoring/test/api --max-time 5; then # в тз не совсем ясно, какой реквест нужен апи - даем апишке 5 секунд на ответ
                                                                    # также этот кусок будет зависеть от того, ждем лы мы какой то ответ от апишки,
                                                                    # и нужно ли нам смотреть на ответ коды
        continue
    else
        LOG error "Monitoring API is not available"
    fi
    # сравниваем сохраненный pid процесса - работает, по сути, даже если процессов нескольно, но будет триггер, если один из них умрет
    # или если их станет больше - в тз не указано, будет ли несколько процессов
    if [ "$(pgrep -x $PROCESS)" != "$(cat /tmp/monitor-pid)" ]; then
        LOG info "Process was restarted"
    fi
fi