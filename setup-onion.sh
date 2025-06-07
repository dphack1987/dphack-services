#!/bin/bash

# Colores para los mensajes
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${GREEN}Iniciando configuración de DPhack Services para la Dark Web...${NC}"

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker no está instalado. Instalando...${NC}"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
fi

# Verificar Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}Docker Compose no está instalado. Instalando...${NC}"
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Crear directorio para datos persistentes
mkdir -p tor_data

# Construir y levantar los contenedores
echo -e "${GREEN}Construyendo y levantando los servicios...${NC}"
docker-compose build
docker-compose up -d

# Esperar a que el servicio de Tor esté listo
echo -e "${GREEN}Esperando a que el servicio .onion esté disponible...${NC}"
sleep 30

# Obtener la dirección .onion
echo -e "${GREEN}Tu dirección .onion es:${NC}"
docker-compose logs tor | grep "Hostname:"

echo -e "${GREEN}Configuración completada!${NC}"
echo -e "Para detener los servicios: ${RED}docker-compose down${NC}"
echo -e "Para ver los logs: ${RED}docker-compose logs${NC}"
echo -e "Para reiniciar: ${RED}docker-compose restart${NC}"
