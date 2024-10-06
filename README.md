# Django Alpine Base Image

A basic Django base image using Alpine Linux.

## Features

- Python 3.12.7
- Alpine 3.20
- PostgreSQL client
- Common Django dependencies pre-installed
- Optimized for size and performance
- Follows best practices for Docker and Django

## Usage

In your Dockerfile:

```dockerfile
FROM ajalilian/django-alpine-base:latest

COPY . /app

RUN python manage.py collectstatic --noinput

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

