#!/bin/bash

# Dừng container
echo "🛑 Đang dừng container..."
docker-compose down || { echo "Lỗi khi dừng container"; exit 1; }

# Cập nhật code từ Git
echo "🔄 Đang cập nhật code từ Git..."
git pull origin $(git rev-parse --abbrev-ref HEAD) || { echo "Lỗi khi cập nhật code từ Git"; exit 1; }

# Đọc phiên bản từ version.txt
VERSION=$(cat version.txt)

# Hiển thị thông báo
echo "🚀 Đang khởi động lại container với phiên bản $VERSION..."

# Build lại Docker image
docker-compose build --no-cache || { echo "Lỗi khi build Docker image"; exit 1; }

# Gán phiên bản cho image
docker tag <image_name> "$<image_name>:$VERSION" || { echo "Lỗi khi gán phiên bản cho Docker image"; exit 1; }

# Khởi động lại container
docker-compose up -d || { echo "Lỗi khi khởi động container"; exit 1; }

echo "✅ Cập nhật và khởi động lại thành công!"
