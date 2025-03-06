FROM elixir:1.17-alpine AS build

# Install build dependencies
RUN apk add --no-cache build-base npm git

# Set working directory
RUN mkdir /app
WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set build ENV
ENV MIX_ENV=prod

# Install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only prod
RUN mix deps.compile

# Build assets
COPY assets assets
COPY priv priv
# RUN cd assets && npm install && npm run deploy ## for externally managed npm packages
RUN mix assets.deploy
RUN mix phx.digest

# Compile the application
COPY lib lib
# COPY rel rel
RUN mix compile
RUN mix phx.gen.release && mix release

# Start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM alpine:3.21 AS app
RUN apk add --no-cache libstdc++ openssl ncurses-libs

RUN mkdir /app
WORKDIR /app

EXPOSE 4000

# Set runtime ENV
ENV MIX_ENV=prod
ENV PHX_SERVER=true

# Copy the release from the build stage
COPY --from=build /app/_build/prod/rel/hangman ./

RUN chown -R nobody: /app
USER nobody

ENV HOME=/app
# Run the Phoenix app
CMD ["bin/hangman", "start"]
