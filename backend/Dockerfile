FROM elixir:1.8.1-alpine

ARG APP_VERSION
ARG MIX_ENV=prod

ENV APP_NAME=grumpy_cat \
    APP_VERSION=${APP_VERSION} \
    MIX_ENV=${MIX_ENV}

WORKDIR /opt/app

#RUN apk update && \
#    apk upgrade --no-cache && \
#    apk add --no-cache git build-base

RUN mix local.hex --force && \
    mix local.rebar --force

# Make sure your dependecies are fetched only if they change
COPY mix.* ./
RUN mix deps.get --only ${MIX_ENV}

# Recompiles if code has changed
COPY . .
RUN mix compile --force

EXPOSE 4000
