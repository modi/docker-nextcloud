#!/usr/bin/env bash

# 将维护窗口设置为：16:00am UTC - 20:00am UTC
# https://docs.nextcloud.com/server/28/admin_manual/configuration_server/background_jobs_configuration.html#maintenance-window-start
docker compose exec -u www-data app php occ config:system:set maintenance_window_start --type=integer --value=18

# 关闭自动检查更新
docker compose exec -u www-data app php occ config:system:set update_checker --type=boolean --value=false

# 使用中国的语言、时区
docker compose exec -u www-data app php occ config:system:set default_language --type=string --value=zh_CN
docker compose exec -u www-data app php occ config:system:set default_locale --type=string --value=zh_Hans_CN
docker compose exec -u www-data app php occ config:system:set default_phone_region --type=string --value=CN
docker compose exec -u www-data app php occ config:system:set default_timezone --type=string --value=Asia/Shanghai
