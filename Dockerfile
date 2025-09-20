# Dockerfile для TTS-сервера - Версия 7.0 ("The Direct Approach")
# Используем официальный образ от Coqui
FROM ghcr.io/coqui-ai/tts-cpu

# Устанавливаем wget для скачивания файлов
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Создаем папку для нашей модели
RUN mkdir -p /app/models/

# ✅ ГЛАВНОЕ ИЗМЕНЕНИЕ:
# Скачиваем модель и конфиг напрямую с их официального хранилища (Hugging Face)
# Это обходит все баги их внутреннего менеджера.
RUN wget -O /app/models/config.json https://huggingface.co/coqui/tts_models--ru--multi-speaker--silero_tts/resolve/main/config.json
RUN wget -O /app/models/model.pth https://huggingface.co/coqui/tts_models--ru--multi-speaker--silero_tts/resolve/main/model.pth

# Жестко указываем, что основной программой для запуска должен быть именно tts-server
ENTRYPOINT ["/usr/local/bin/tts-server"]

# ✅ ГЛАВНОЕ ИЗМЕНЕНИЕ №2:
# Мы больше не используем --model_name. Мы напрямую указываем путь
# к файлам модели и конфига, которые мы только что скачали.
CMD ["--model_path", "/app/models/model.pth", "--config_path", "/app/models/config.json"]
