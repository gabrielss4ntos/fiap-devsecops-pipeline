FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl wget

ENV DATABASE_PASSWORD=admin123
ENV API_KEY=sk-1234567890abcdef

RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 22 80 443 3306 8080 5432

COPY . /app
WORKDIR /app

RUN adduser --disabled-password --gecos '' appuser
RUN usermod -aG sudo appuser
RUN echo 'appuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN chmod -R 777 /app
RUN chmod 666 /etc/passwd 2>/dev/null || true
RUN chown -R root:root /app
