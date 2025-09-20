# Dockerfile для TTS-сервера Coqui XTTS - Версия 4.0 ("Silver Bullet")
# Используем официальный образ от Coqui
FROM ghcr.io/coqui-ai/tts-cpu

# Жестко указываем, что основной программой для запуска должен быть именно tts-server
ENTRYPOINT ["/usr/local/bin/tts-server"]

# А в CMD передаем только аргументы для этой программы
CMD ["--model_name", "tts_models/multilingual/multi-dataset/xtts_v2"]
