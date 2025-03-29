FROM python:3.13-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm -r /tmp/requirements.txt

WORKDIR /app

CMD ["streamlit", "run", "gemini_multimodal_chatbot.py", "--server.port=8501", "--server.address=0.0.0.0"]
