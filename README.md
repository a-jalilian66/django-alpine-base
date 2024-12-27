# Django Alpine Base Image

A basic Django base image using Alpine Linux.

## Features

- Python 3.12.7
- Alpine 3.20
- Django 5.1.4
- PostgreSQL client
- Common Django dependencies pre-installed
- Optimized for size and performance
- Multi-stage build
- Non-root user implementation
- Follows Docker and Django best practices

## Pre-installed Packages

- Django 5.1.4
- Django REST Framework 3.15.2
- Django Filter 24.3
- PostgreSQL support (psycopg 3.2.3)
- Django CORS Headers 4.6.0
- Django Treebeard 4.7.1
- Pillow 11.0.0

## Usage

In your Dockerfile:

```dockerfile
FROM ajalilian/django-alpine-base:5.1.4

COPY . /app

RUN python manage.py collectstatic --noinput

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]