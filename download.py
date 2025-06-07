from http.server import HTTPServer, SimpleHTTPRequestHandler
import os
import zipfile

print("Creando archivo ZIP del proyecto...")

# Crear el ZIP
with zipfile.ZipFile('dphack-services.zip', 'w', zipfile.ZIP_DEFLATED) as zipf:
    # Agregar todos los archivos y carpetas
    for root, dirs, files in os.walk('.'):
        for file in files:
            # Excluir el propio archivo ZIP y archivos temporales
            if file != 'dphack-services.zip' and not file.endswith('.pyc'):
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, '.')
                print(f"Agregando: {arcname}")
                zipf.write(file_path, arcname)

print("\nArchivo ZIP creado exitosamente!")
print("\nIniciando servidor en http://localhost:8000")
print("Para descargar el proyecto, visita: http://localhost:8000/dphack-services.zip")
print("Presiona Ctrl+C para detener el servidor")

# Iniciar servidor HTTP simple
HTTPServer(('0.0.0.0', 8000), SimpleHTTPRequestHandler).serve_forever()
