# Create image based on the official Node 6 image from dockerhub
FROM node:6

ARG GMAIL_PASSWORD=local
ENV GMAIL_PASSWORD ${GMAIL_PASSWORD}
ARG MONGO_USERNAME=local
ENV MONGO_USERNAME ${MONGO_USERNAME}
ARG MONGO_PASSWORD=local
ENV MONGO_PASSWORD ${MONGO_PASSWORD}
ARG MONGO_CONNECTION=local
ENV MONGO_CONNECTION ${MONGO_CONNECTION}
ARG MONGO_DOMAIN=local
ENV MONGO_DOMAIN ${MONGO_DOMAIN}
ARG NODE_PORT=local
ENV NODE_PORT ${NODE_PORT}
ARG APP_ROOT=${PWD}

# Basics
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y git vim

# Python + AWS CLI
RUN apt-get install -y python3-pip && \
    apt-get -y update
RUN pip3 install awscli

RUN git clone https://github.com/canaantt/oncoscape-user-data-uploading
# Create a directory where our app will be placed
RUN mkdir -p oncoscape-user-data-uploading/uploads
RUN chmod +x oncoscape-user-data-uploading/uploads
WORKDIR oncoscape-user-data-uploading/server
# RUN mkdir -p /usr/src/oncoscape-user-data-uploading/uploads
# RUN chmod +x /usr/src/oncoscape-user-data-uploading/uploads
# WORKDIR /usr/src/oncoscape-user-data-uploading/server

# Install dependecies
RUN npm install
RUN npm install pm2 -g

# RUN npm install aws-sdk -g 
# COPY server/. /usr/src/app/server
# WORKDIR /usr/src/app

# pm2 start ec2_app.js --node-args="--max-old-space-size=7000"  
# CMD ["node", "EC2_server.js", "--max-old-space-size=7000"]

EXPOSE 7776
CMD ["node", "app.js"]
