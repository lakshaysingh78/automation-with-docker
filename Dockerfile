# 1. Base image
FROM python:3.10-slim

# 2. Working dir
WORKDIR /app

# 3. Install system dependencies for Pillow
RUN apt-get update && apt-get install -y \
    build-essential \
    libjpeg-dev \
    zlib1g-dev \
    libpng-dev \
    && rm -rf /var/lib/apt/lists/*

# 4. Install python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# 5. Copy project files
COPY . /app/

# 6. Run the app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
