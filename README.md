# Dockerized Nextcloud

## 安装

### 脚本安装

    ./install.sh

### 手动安装

1）创建目录

    mkdir data
    sudo chown 33:33 data

2）启动容器

    docker compose up -d

## 卸载

（危险）删除所有容器、数据：

    ./destroy.sh

## 调整配置

加载默认配置：`./load-default-configs.sh`。

或手动配置，修改 `config/config.php`。

## 管理应用

### 离线安装应用

1）从[应用商店](https://apps.nextcloud.com/)下载应用软件包

2）将软件包解压至 `apps` 目录

3）执行启用应用的命令 `php occ app:enable xxx`

### 停用应用

    docker compose exec -u www-data app php occ app:disable circles federation nextcloud_announcements sharebymail support updatenotification survey_client weather_status

## 扫描来自外部的文件更新

    docker compose exec -u www-data app php occ files:scan --all

## 备忘

- Calendar 应用的版本历史：https://apps.nextcloud.com/apps/calendar/releases
- NextCloud Office 应用的版本历史：https://apps.nextcloud.com/apps/richdocuments/releases
- 配置项 `has_internet_connection`
- 配置项 `['overwrite.cli.url' => 'http://x.x.x.x:yyyy']`,

## XXX

    docker compose exec -u www-data app ./occ --help
    docker compose exec -u www-data app ./occ config:list all
    docker compose exec -u www-data app ./occ config:list richdocuments
