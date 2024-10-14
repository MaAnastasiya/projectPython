#!/bin/bash

echo "Запускаем процесс очистки Docker..."

# 1. Удаление определенного контейнера по его имени или ID
docker rm my_container 2>/dev/null

# 2. Удаление нескольких контейнеров по их ID
docker rm container_id1 container_id2 container_id3 2>/dev/null

# 3. Запуск временного контейнера Ubuntu с автоматическим удалением после завершения
docker run --rm ubuntu:latest echo "Временный контейнер Ubuntu запущен"

# 4. Удаление неиспользуемых образов (висячих)
docker image prune -f

# 5. Удаление неиспользуемых сетей
docker network prune -f

# 6. Удаление образа по имени или ID
docker rmi my_image 2>/dev/null

# 7. Удаление всех контейнеров, созданных более 24 часов назад
docker ps -a --filter "until=24h" -q | xargs -r docker rm

# 8. Удаление всех контейнеров, включая остановленные
docker ps -a -q | xargs -r docker rm

# 9. Остановка всех работающих контейнеров
# shellcheck disable=SC2046
docker stop $(docker ps -q) 2>/dev/null

# 10. Удаление всех завершенных контейнеров
# shellcheck disable=SC2046
docker rm $(docker ps -a -f status=exited -q) 2>/dev/null

# 11. Удаление контейнера и всех связанных с ним анонимных томов
docker rm -v my_container 2>/dev/null

echo "Процесс очистки Docker завершен."