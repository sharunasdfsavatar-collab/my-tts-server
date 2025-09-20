# ✅ Правильный Dockerfile v2
FROM ghcr.io/coqui-ai/tts-cpu

# Команда для запуска именно веб-сервера, а не утилиты командной строки
CMD ["tts-server", "--model_name", "tts_models/multilingual/multi-dataset/xtts_v2"]
