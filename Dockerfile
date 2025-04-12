# ---------- Base image for building frontend ----------
FROM node:18 AS frontend

WORKDIR /app/frontend
COPY frontend/ .

RUN npm install && npm run build


# ---------- Base image for backend + nginx ----------
FROM python:3.10-slim

# Install nginx
RUN apt-get update && apt-get install -y nginx && apt-get clean

# Set environment
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create workdir
WORKDIR /app

# Copy backend code
COPY backend/ ./backend/

# Install Python requirements
COPY backend/requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy built frontend from previous stage
COPY --from=frontend /app/frontend/build /var/www/frontend

# Replace default nginx config
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/sites-enabled/default

# Static files setup (optional: if using whitenoise/static in Django)
RUN mkdir -p /app/static/

# Expose ports
EXPOSE 80

# Start nginx and backend
CMD service nginx start && python backend/main.py
