# main.py (для сервера на Railway) - ВЕРСИЯ 2.0 (ФИНАЛ)
import os
import torch
import soundfile as sf
from fastapi import FastAPI, Response
from pydantic import BaseModel
import io # <-- Добавили этот импорт

# --- Загрузка модели ---
device = torch.device('cpu')
torch.set_num_threads(4)
local_file = 'model.pt'

if not os.path.isfile(local_file):
    print("Скачивание модели Silero...")
    torch.hub.download_url_to_file('https://models.silero.ai/models/tts/ru/v3_1_ru.pt', local_file)
    print("Модель скачана.")

model = torch.package.PackageImporter(local_file).load_pickle("tts_models", "model")
model.to(device)

# --- Настройки ---
sample_rate = 48000
speaker = 'kseniya'

# --- API Сервер ---
app = FastAPI()

class TTSRequest(BaseModel):
    text: str

@app.post("/api/tts")
async def text_to_speech(req: TTSRequest):
    print(f"Получен запрос на синтез: '{req.text}'")
    
    # Синтез аудио
    audio_tensor = model.apply_tts(
        text=req.text,
        speaker=speaker,
        sample_rate=sample_rate
    )
    
    # ✅ ИСПРАВЛЕНИЕ: Преобразуем тензор в numpy массив напрямую
    audio_numpy = audio_tensor.numpy()
    
    # ✅ ИСПРАВЛЕНИЕ: Правильно сохраняем WAV в буфер в памяти
    buffer = io.BytesIO()
    sf.write(buffer, audio_numpy, sample_rate, format='WAV', subtype='PCM_16')
    
    return Response(content=buffer.getvalue(), media_type="audio/wav")

print("Сервер TTS готов к работе.")
