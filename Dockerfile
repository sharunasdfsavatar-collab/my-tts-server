FROM ghcr.io/coqui-ai/tts-cpu
CMD ["tts-server", "--model_name", "tts_models/multilingual/multi-dataset/xtts_v2", "--use_cuda", "false"]