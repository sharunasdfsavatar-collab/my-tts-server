# main.py (для сервера на Railway)
import os
import torch
import soundfile as sf
from fastapi import FastAPI, Response
from pydantic import BaseModel

# --- Загрузка модели ---
# Модель будет скачана автоматически при первом запуске контейнера
device = torch.device('cpu')
torch.set_num_threads(4) # Оптимизация для CPU
local_file = 'model.pt'

if not os.path.isfile(local_file):
    print("Скачивание модели Silero...")
    torch.hub.download_url_to_file('https://models.silero.ai/models/tts/ru/v3_1_ru.pt', local_file)
    print("Модель скачана.")

model = torch.package.PackageImporter(local_file).load_pickle("tts_models", "model")
model.to(device)

# --- Настройки ---
sample_rate = 48000
speaker = 'baya' # 'aidar', 'baya', 'kseniya', 'xenia', 'eugene', 'random'

# --- API Сервер ---
app = FastAPI()

class TTSRequest(BaseModel):
    text: str

@app.post("/api/tts")
async def text_to_speech(req: TTSRequest):
    print(f"Получен запрос на синтез: '{req.text}'")
    
    # Синтез аудио
    audio = model.apply_tts(
        text=req.text,
        speaker=speaker,
        sample_rate=sample_rate
    )
    
    # Сохраняем во временный файл в памяти
    audio_bytes = torch.int16_to_float(audio).numpy()
    
    # Отдаем аудио в формате WAV
    return Response(content=sf.read(audio_bytes, samplerate=sample_rate)[0].tobytes(), media_type="audio/wav")

print("Сервер TTS готов к работе.")