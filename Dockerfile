FROM elixir:latest

MAINTAINER Juha Lehtonen

ENV REFRESHED_AT 2017-03-24
# 2017-03-24 update to elixir latest

# Install hex
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force && \
    /usr/local/bin/mix hex.info

WORKDIR /app
COPY . .

RUN mix deps.get

CMD ["bash"]