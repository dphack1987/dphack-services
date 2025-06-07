@echo off
echo Creando paquete de DPhack Services...

REM Crear directorio temporal
mkdir temp_package

REM Copiar archivos necesarios
xcopy /E /I src temp_package\src
xcopy /E /I public temp_package\public
copy Dockerfile temp_package\
copy docker-compose.yml temp_package\
copy setup-onion.bat temp_package\
copy package.json temp_package\
copy next.config.js temp_package\
copy postcss.config.js temp_package\
copy tailwind.config.js temp_package\
copy tsconfig.json temp_package\
copy download.html temp_package\

REM Crear archivo ZIP
powershell Compress-Archive -Path temp_package\* -DestinationPath dphack-services.zip -Force

REM Limpiar directorio temporal
rmdir /S /Q temp_package

echo Paquete creado exitosamente: dphack-services.zip
pause
