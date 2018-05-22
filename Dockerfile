FROM devth/helm:2.8.2

ENV PLUGIN_VERSION 0.6.1

MAINTAINER Hugh McManus <hmcmanus@gmail.com>

WORKDIR /

RUN apk add --update make
# This is required because I couldn't figure out how to set the region in the S3 URL
RUN mkdir ~/.aws/
RUN printf "[default]\nregion=ap-southeast-2" > ~/.aws/credentials

RUN helm plugin install https://github.com/hypnoglow/helm-s3.git --version ${PLUGIN_VERSION}
