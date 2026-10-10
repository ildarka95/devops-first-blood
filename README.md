# devops-first-blood

Мини-проект: Python HTTP-сервер за Nginx, упакованный в Docker,
с автоматической сборкой и публикацией образа через GitHub Actions.

## Стек
- Python 3.11
- Docker + Docker Compose
- Nginx (reverse proxy)
- GitHub Actions (CI/CD)
- GitHub Container Registry (ghcr.io)

## Запуск локально

    docker compose up -d --build

Приложение доступно на http://localhost/
Health-check: http://localhost/health

## CI/CD

При каждом push в `main` запускается пайплайн:
1. `test` — pytest проверяет, что приложение отвечает.
2. `build` — собирает Docker-образ и публикует в GHCR (только если тесты прошли).

Образ: `ghcr.io/ildarka95/devops-first-blood:latest`

## Архитектура

    [ Браузер ] --80--> [ Nginx ] --backend--> [ Python app:8080 ]

Приложение не доступно снаружи, только через Nginx внутри Docker-сети.