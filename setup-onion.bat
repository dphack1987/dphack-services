@echo off
echo Iniciando configuracion de DPhack Services para la Dark Web...

REM Verificar que Docker este corriendo
docker info > nul 2>&1
if errorlevel 1 (
    echo Docker no esta corriendo. Por favor, inicia Docker Desktop.
    exit /b
)

REM Crear directorio para datos persistentes
mkdir tor_data

REM Construir y levantar los contenedores
echo Construyendo y levantando los servicios...
docker-compose build
docker-compose up -d

REM Esperar a que el servicio de Tor este listo
echo Esperando a que el servicio .onion este disponible...
timeout /t 30 /nobreak

REM Obtener la direccion .onion
echo Tu direccion .onion es:
docker-compose logs tor | findstr "Hostname:"

echo Configuracion completada!
echo Para detener los servicios: docker-compose down
echo Para ver los logs: docker-compose logs
echo Para reiniciar: docker-compose restart
pause
