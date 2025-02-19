#!/bin/bash

BLUE='\033[0;34m'
PURPLE='\033[0;35m'
L_BLUE='\033[0;36m'
END='\033[0m'

echo -e "${L_BLUE}\n\t\t СИСТЕМА${END}\n"

echo -e "${L_BLUE}Название ОС:${END} $(lsb_release -si)"
echo -e "${L_BLUE}Версия ОС:${END} $(lsb_release -sr)"
echo -e "${L_BLUE}Версия ядра:${END} $(uname -r)"
echo -e "${L_BLUE}Архитектура ядра Linux:${END} $(uname -m)"

echo -e "\n${PURPLE}\t\tПРОЦЕССОР${END}\n"

echo -e "${PURPLE}Модель:${END} $(grep "model name" /proc/cpuinfo | head -1 | awk -F: '{ print $2 }' | sed 's/^[ \t]*//;s/[ \t][ \t]*/ /g')"
echo -e "${PURPLE}Частота:${END} $(grep "cpu MHz" /proc/cpuinfo | awk -F: '{ print $2 " MHz" }' | head -n 1 | sed 's/^[ \t]*//')"
physical_cores=$(grep -m1 "cpu cores" /proc/cpuinfo | awk '{print $4}')
logical_processors=$(nproc)
threads_per_core=$(( logical_processors / physical_cores ))
echo -e "${PURPLE}Количество физических ядер:${END} $physical_cores"
echo -e "${PURPLE}Количество логических процессоров:${END} $logical_processors"
echo -e "${PURPLE}Потоков на ядро:${END} $threads_per_core"
echo -e "${PURPLE}Кэш-память:${END} $(grep "cache size" /proc/cpuinfo | head -1 | awk -F: '{ print $2 / 1024 " MB" }')"

echo -e "\n${L_BLUE}\t    ОПЕРАТИВНАЯ ПАМЯТЬ${END}\n"

echo -e "${L_BLUE}Общий размер памяти:${END} $(free -h | head -n2 | tail -n1 | awk '{print $2 * 1024 " MB"}')"
echo -e "${L_BLUE}Использовано:${END} $(free -h | head -n2 | tail -n1 | awk '{print $3 * 1024 " MB"}')"
echo -e "${L_BLUE}Доступно:${END} $(free -h | head -n2 | tail -n1 | awk '{print $7 * 1024 " MB"}')"

echo -e "\n${PURPLE}\t    СЕТЕВЫЕ ИНТЕРФЕЙСЫ${END}"

for interface in $(ls /sys/class/net/ | grep -v lo); do
  echo -e "\n${PURPLE}Интерфейс:${END} $interface"
  echo -e "${PURPLE}IP адрес:${END} $(ip addr show $interface | grep -E "inet\b" | awk '{print $2}')"
  echo -e "${PURPLE}MAC адрес:${END} $(cat /sys/class/net/$interface/address | awk '{print $1}')"
  speed=$(ethtool $interface 2>/dev/null | grep "Speed:" | awk '{print $2}')
  if [ -n "$speed" ]; then
    echo -e "${PURPLE}Скорость соединения:${END} $speed"
  else
    echo -e "${PURPLE}Скорость соединения:${END} Не удалось определить"
  fi
done

echo -e "\n${L_BLUE}\t     СИСТЕМНЫЕ РАЗДЕЛЫ${END}\n"

df -h

