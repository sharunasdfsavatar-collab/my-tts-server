# Dockerfile для Silero TTS - Версия 9.0 ("The Silero Way")
FROM python:3.10-slim

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y ffmpeg

# Устанавливаем Python библиотеки
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код нашего сервера
COPY main.py .

# Запускаем наш сервер
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
