# Dockerfile для TTS-сервера Coqui XTTS - Версия 5.0 ("The Golden Key")
# Используем официальный образ от Coqui
FROM ghcr.io/coqui-ai/tts-cpu

# ✅ "ЗОЛОТОЙ КЛЮЧ": Автоматически принимаем лицензионное соглашение.
# Эта переменная окружения говорит программе не задавать вопрос [y/n]
# и сразу переходить к скачиванию модели.
ENV COQUI_TOS_AGREED=1

# Жестко указываем, что основной программой для запуска должен быть именно tts-server
ENTRYPOINT ["/usr/local/bin/tts-server"]

# А в CMD передаем только аргументы для этой программы
CMD ["--model_name", "tts_models/multilingual/multi-dataset/xtts_v2"]
