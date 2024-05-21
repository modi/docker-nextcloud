#!/usr/bin/env bash

set -eux

# 将维护窗口设置为：18:00 - 22:00（UTC）
# https://docs.nextcloud.com/server/28/admin_manual/configuration_server/background_jobs_configuration.html#maintenance-window-start
docker compose exec -u www-data app php occ config:system:set maintenance_window_start --type=integer --value=18

# 关闭自动检查更新
docker compose exec -u www-data app php occ config:system:set update_checker --type=boolean --value=false

# 使用中国的语言、时区
docker compose exec -u www-data app php occ config:system:set default_language --type=string --value=zh_CN
docker compose exec -u www-data app php occ config:system:set default_locale --type=string --value=zh_Hans_CN
docker compose exec -u www-data app php occ config:system:set default_phone_region --type=string --value=CN
docker compose exec -u www-data app php occ config:system:set default_timezone --type=string --value=Asia/Shanghai

# 禁止未注册用户上传
docker compose exec -u www-data app php occ config:app:set core shareapi_allow_public_upload --value=no

# 通过链接分享文件必须设置密码和过期时间，过期时间最长为 7 天
docker compose exec -u www-data app php occ config:app:set core shareapi_enable_link_password_by_default --value=yes
docker compose exec -u www-data app php occ config:app:set core shareapi_enforce_links_password --value=yes
docker compose exec -u www-data app php occ config:app:set core shareapi_default_expire_date --value=yes
docker compose exec -u www-data app php occ config:app:set core shareapi_enforce_expire_date --value=yes
docker compose exec -u www-data app php occ config:app:set core shareapi_expire_after_n_days --value=7

# 密码规则：
# - 最小长度 8
# - 必须同时包含大写英文、小写英文及数字字符
# - 登录失败达到 3 次则锁定账号
docker compose exec -u www-data app ./occ config:app:set password_policy enforceNumericCharacters --value=1
docker compose exec -u www-data app ./occ config:app:set password_policy enforceUpperLowerCase --value=1
docker compose exec -u www-data app ./occ config:app:set password_policy maximumLoginAttempts --value=3
docker compose exec -u www-data app ./occ config:app:set password_policy minLength --value=8

docker compose exec -u www-data app ./occ config:app:set theming slogan --value=""

docker compose exec -u www-data app php occ config:system:set allow_local_remote_servers --type=boolean --value=true
