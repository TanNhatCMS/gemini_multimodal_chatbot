#!/bin/bash

# Đọc phiên bản từ tệp version.txt
VERSION=$(cat version.txt)

# Hiển thị thông báo
echo "🚀 Đang khởi động container docker với phiên bản $VERSION..."

# Build Docker image với tag là phiên bản từ version.txt
docker-compose build --no-cache

# Gán phiên bản cho image
docker tag <image_name> "$<image_name>:$VERSION"

# Chạy Docker container
docker-compose up -d
