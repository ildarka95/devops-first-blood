FROM python:3.11-slim

# Устанавливаем curl для healthcheck и создаем non-root пользователя
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --shell /bin/bash appuser

WORKDIR /app

# Сначала копируем только код — кэш лучше работает
COPY app.py .

# Переключаемся на non-root. Это базовая безопасность.
# Если контейнер взломают — злоумышленник не получит root в системе.
USER appuser

EXPOSE 8080

# Docker сам проверяет, живой ли контейнер
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/ || exit 1

CMD ["python", "app.py"]