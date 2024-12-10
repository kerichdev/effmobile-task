# Тестовое задания для Effective Mobile
* `monitor.sh` должен находиться в /bin
* `process-monitor.timer` подтягивает сервис, оба должны быть в `/etc/systemd/system/`

```shell
systemctl enable process-monitor.timer
```