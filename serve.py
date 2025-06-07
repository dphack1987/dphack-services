import http.server
import socketserver
import os
import zipfile
import threading

# Crear el ZIP primero
def create_zip():
    print("Creando archivo ZIP...")
    with zipfile.ZipFile('dphack-services.zip', 'w', zipfile.ZIP_DEFLATED) as zipf:
        # Lista de archivos y carpetas a incluir
        files_to_zip = ['src', 'public', 'Dockerfile', 'docker-compose.yml', 
                       'setup-onion.bat', 'package.json', 'next.config.js',
                       'postcss.config.js', 'tailwind.config.js', 'tsconfig.json']
        
        for item in files_to_zip:
            if os.path.isdir(item):
                for root, dirs, files in os.walk(item):
                    for file in files:
                        file_path = os.path.join(root, file)
                        zipf.write(file_path)
            else:
                if os.path.exists(item):
                    zipf.write(item)
    print("Archivo ZIP creado exitosamente")

class SimpleHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            html = '''
            <!DOCTYPE html>
            <html>
            <head>
            align-items: center; 
            height: 100vh; 
            margin: 0; 
        }
        a { 
            background: linear-gradient(45deg, #ff0000, #800080);
            color: white; 
            padding: 20px 40px; 
            text-decoration: none; 
            border-radius: 5px; 
            font-family: Arial; 
            font-size: 20px;
        }
    </style>
</head>
<body>
    <a href="/dphack-services.zip">DESCARGAR DPHACK SERVICES</a>
</body>
</html>
        ''')

# Crear los archivos
create_zip()
create_html()

# Iniciar el servidor
print("Servidor iniciado en http://localhost:8000")
HTTPServer(('0.0.0.0', 8000), SimpleHTTPRequestHandler).serve_forever()
