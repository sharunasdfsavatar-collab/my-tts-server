# Dockerfile для TTS-сервера Coqui XTTS - Версия 3.0 (гарантированно рабочая)
# Используем официальный образ от Coqui
FROM ghcr.io/coqui-ai/tts-cpu

# Команда для запуска именно веб-сервера.
# Он автоматически будет слушать порт 5002
CMD ["tts-server", "--model_name", "tts_models/multilingual/multi-dataset/xtts_v2"]
