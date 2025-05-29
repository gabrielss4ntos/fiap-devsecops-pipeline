# Dockerfile com vulnerabilidades CRÍTICAS para testes
FROM ubuntu:18.04

# ❌ Versão antiga com CVEs conhecidos
RUN apt-get update && apt-get install -y \
    openssh-server \
    apache2 \
    mysql-server \
    curl \
    wget \
    unzip

# ❌ CRITICAL: Hardcoded secrets 
ENV DATABASE_PASSWORD=admin123
ENV ROOT_PASSWORD=password123
ENV JWT_SECRET=super-secret-key-123
ENV AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
ENV AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

# ❌ CRITICAL: SSH habilitado e rodando como root
RUN echo 'root:password' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# ❌ HIGH: Expor portas críticas
EXPOSE 22 80 3306 443 8080

# ❌ CRITICAL: Instalar pacotes com vulnerabilidades conhecidas
RUN apt-get install -y \
    openssl=1.1.1-1ubuntu2.1~18.04.23 \
    libssl1.1=1.1.1-1ubuntu2.1~18.04.23

# ❌ HIGH: Permissões inseguras
COPY . /app
RUN chmod -R 777 /app
RUN chmod 666 /etc/passwd
RUN chmod 666 /etc/shadow

# ❌ CRITICAL: Rodando múltiplos serviços como root
USER root
WORKDIR /app

# ❌ Sem HEALTHCHECK, sem USER final
CMD service ssh start && service apache2 start && service mysql start && tail -f /dev/null
