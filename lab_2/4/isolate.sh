#!/bin/bash

BLUE='\033[0;34m'
PURPLE='\033[0;35m'
L_BLUE='\033[0;36m'
END='\033[0m'

echo -e "\n\t\t${BLUE}УРОВНИ ИЗОЛЯЦИИ${END}\n"

echo -e "${PURPLE}1. PID - изоляция идентификаторов объектов${END}"
echo -e "PID внутри контейнера: $(ps -o ppid= -p $$)\n"

echo -e "${L_BLUE}2. IPC - изоляция процессов${END}"
ipcs -q

echo -e "${PURPLE}3. network - изоляция сетевых интерфейсов${END}"
echo "Хост внутри контейнера: $(hostname)"
echo -e "Его сетевые интерфейсы:\n $(ip addr show)"

echo -e "${L_BLUE}\n4. users - изоляция идентификаторов пользователей${END}"
echo "ID группы (GID) в контейнере: $(id -g)"
echo "ID пользователя (UID) в контейнере: $(id -u)"

echo -e "${PURPLE}\n5. mount - изоляция файловых систем${END}"
echo "Точка монтирования корня файловой системы: $(findmnt -n -o TARGET /)"

echo -e "${L_BLUE}\n6. UTS - изоляция имён хостов и доменов${END}"
echo -e "Имя узла: $(uname -n)\n"
