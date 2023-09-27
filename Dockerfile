FROM node:14.15.4 As build

ENV NEXUS_URL http://nexus.banking.ops.agile.nationwide.co.uk/repository/npm/
WORKDIR /build

COPY package*.json ./
ENV NODE_OPTIONS=--max_old_space_size=8192
RUN export NODE_OPTIONS=--max_old_space_size=8192
# Uncomment below line for fresh npm install
# RUN npm cache clean --force
# npm cache clean && \
RUN echo "\n \n ======>Running npm install and starting with node -v and npm -v \n \n"

RUN apt-get update -y; exit 0
RUN apt-get install -y -q xvfb libgtk2.0-0 libxtst6 libxss1 libgconf-2-4 libnss3 libasound2 libatk-bridge2.0-0 libgtk-3.0
RUN export NODE_OPTIONS="--max_old_space_size=4096"
RUN node -v && \
    npm -v && \
    npm config set registry ${NEXUS_URL} && \
    npm install

COPY . .