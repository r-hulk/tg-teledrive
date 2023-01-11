# syntax = docker/dockerfile:1.2
FROM node:16.3.0-alpine as build
ARG REACT_APP_TG_API_ID
ARG REACT_APP_TG_API_HASH

WORKDIR /apps

COPY yarn.lock .
COPY package.json .
COPY api/package.json api/package.json
COPY web/package.json web/package.json
# COPY docker/.env .
# ADD https://gist.githubusercontent.com/r-hulk/f0cfe61fa78b2b656d14b49612b6a13c/raw/.env .
# RUN --mount=type=secret,id=_env,dst=/etc/secrets/.env cat /etc/secrets/.env
# COPY /etc/secrets/.env .
RUN yarn cache clean
RUN yarn install --network-timeout 1000000
COPY . .
RUN yarn workspaces run build