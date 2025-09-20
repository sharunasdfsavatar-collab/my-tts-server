# Dockerfile для TTS-сервера - Версия 6.0 ("The Reliable Engine")
# Используем официальный образ от Coqui
FROM ghcr.io/coqui-ai/tts-cpu

# Автоматически принимаем лицензионное соглашение.
ENV COQUI_TOS_AGREED=1

# Жестко указываем, что основной программой для запуска должен быть именно tts-server
ENTRYPOINT ["/usr/local/bin/tts-server"]

# ✅ ГЛАВНОЕ ИЗМЕНЕНИЕ:
# Мы просим загрузить другую, более стабильную и быструю русскую модель от Silero.
CMD ["--model_name", "tts_models/ru/multi-speaker/silero_tts"]
