# Imagen base recomendada
FROM python:3.11-slim

# Crear carpeta de trabajo
WORKDIR /app

# Copiar archivo con dependencias
COPY requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Copiar el proyecto al contenedor
COPY . .

# Cloud Run inyecta PORT en runtime; se define un valor por defecto para uso local
ENV PORT=8080
EXPOSE 8080

# Servidor de produccion (gunicorn), en vez del servidor de desarrollo de Flask
CMD exec gunicorn --bind :$PORT --workers 2 --threads 8 --timeout 0 app:app
