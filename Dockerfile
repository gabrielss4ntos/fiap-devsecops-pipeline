FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl wget

ENV DATABASE_PASSWORD=admin123
ENV API_KEY=sk-1234567890abcdef

EXPOSE 22 3306 5432 8080

COPY . /app
WORKDIR /app

RUN chmod 777 /app

# Comando para manter container rodando
CMD ["sleep", "infinity"]
