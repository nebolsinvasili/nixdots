#!/bin/sh

# Определение пути к директории для сохранения скриншота
screenshot_dir=~/Изображения/Screenshots/$(date +%Y-%m-%d)

# Проверка существования директории
if [ ! -d "$screenshot_dir" ]; then
  mkdir -p "$screenshot_dir"
fi

filename="${screenshot_dir}/screen_$(date +%Y-%m-%d_%H-%M-%S).png"

if [[ "$1" == "-f" ]]; then
  grim "$filename"
else
  grim -g "$(slurp)" "$filename"
fi

# Копирование скриншота в буфер обмена
cat "$filename" | wl-copy

# echo "Скриншот сохранён как $filename"
