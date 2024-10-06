# Base image
FROM python:3.12.7-alpine3.20 AS base

# Metadata
LABEL maintainer="ajalilian <a.jalilian66@gmail.com>"
LABEL version="1.0.0"
LABEL description="Optimized Django base image using Alpine Linux"

# Environment variables
ENV PYTHONUNBUFFERED=1
ENV PATH="/py/bin:$PATH"

# Install system dependencies
RUN apk add --update --no-cache \
    postgresql-client \
    jpeg-dev \
    zlib-dev \
    libffi-dev \
    libxslt-dev \
    libxml2-dev

# Install build dependencies in a temporary build stage
FROM base AS builder
RUN apk add --no-cache --virtual .build-deps \
    build-base \
    postgresql-dev \
    musl-dev \
    linux-headers \
    gcc

# Create a virtual environment and upgrade pip
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip

# Copy and install Python dependencies
COPY ./requirements.txt /requirements.txt
RUN /py/bin/pip install -r /requirements.txt

# Remove build dependencies after installation
RUN apk del .build-deps

# Final image
FROM base

# Copy the virtual environment from the build stage
COPY --from=builder /py /py

# Create user and directories
RUN adduser --disabled-password --no-create-home django-user && \
    mkdir -p /app /vol/web/static /vol/web/media && \
    chown -R django-user:django-user /app /vol && \
    chmod -R 755 /app /vol

# Set working directory
WORKDIR /app

# Switch to non-root user
USER django-user

# Expose the Django development server port
EXPOSE 8000

# Command to run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
