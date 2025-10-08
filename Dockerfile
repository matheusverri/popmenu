# syntax=docker/dockerfile:1
FROM ruby:3.2

# Dependências do sistema
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  libyaml-dev \
  nodejs \
  curl \
  netcat-openbsd \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Instala Yarn (para assets)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
  && apt-get update -qq && apt-get install -y nodejs \
  && npm install --global yarn

# Diretório de trabalho
WORKDIR /popmenu

# Copia Gemfile para cache de bundle
COPY Gemfile* /popmenu/

# Instala bundler e gems
RUN gem install bundler && bundle install

# Copia o restante do projeto
COPY . /popmenu

# Entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Porta padrão do Rails
EXPOSE 3000

# Comando default: Puma
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]