# Đặt giá trị mặc định cho phiên bản nếu không có tệp version.txt
ARG APP_VERSION=latest

FROM python:3.13-slim

# Cài đặt các gói phụ thuộc
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ffmpeg \
    git \
    && rm -rf /var/lib/apt/lists/*

# Sao chép requirements.txt vào container và cài đặt các phụ thuộc
COPY ./requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt && rm -r /tmp/requirements.txt

# Đọc phiên bản từ version.txt và gán nó vào biến môi trường
RUN export APP_VERSION=$(cat /app/version.txt) && \
    echo "Version: $APP_VERSION"

# Thiết lập thư mục làm việc
WORKDIR /app

# Chạy ứng dụng khi container khởi động
CMD ["/app/start.sh"]
