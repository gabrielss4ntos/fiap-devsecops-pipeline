# Dockerfile intencionalmente vulnerável para testes do Trivy
FROM ubuntu:latest

# ❌ Rodando como root (sem USER)
# ❌ Usando tag 'latest' (não específica)

# ❌ Instalando pacotes sem atualizar cache
RUN apt-get install -y curl wget

# ❌ Deixando senhas hardcoded
ENV DATABASE_PASSWORD=admin123
ENV API_KEY=sk-1234567890abcdef

# ❌ Expondo portas desnecessárias
EXPOSE 22 3306 5432 6379

# ❌ Copiando tudo sem .dockerignore
COPY . /app

# ❌ Permissões muito abertas
RUN chmod 777 /app

# ❌ Instalando pacotes vulneráveis
RUN apt-get install -y openssl=1.1.1-1ubuntu2.1~18.04.1

# ❌ Sem HEALTHCHECK
# ❌ Sem limpeza de cache apt
# ❌ Múltiplas camadas desnecessárias

RUN mkdir /tmp/sensitive
RUN echo "secret-data" > /tmp/sensitive/config.txt
RUN chmod 644 /tmp/sensitive/config.txt

# ❌ Comando inseguro
CMD ["sh", "-c", "while true; do sleep 30; done"]
