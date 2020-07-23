# https://hub.docker.com/_/openjdk?tab=tags&page=1&name=alpine
FROM openjdk:8-jdk-alpine
LABEL maintainer="paulcosma@gmail.com"
# https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/
ARG ALLURE_VERSION=2.13.5

# Download and extract Allure to opt folder.
RUN wget --no-check-certificate https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/${ALLURE_VERSION}/allure-commandline-${ALLURE_VERSION}.zip \
    && wget --no-check-certificate https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/${ALLURE_VERSION}/allure-commandline-${ALLURE_VERSION}.zip.sha1 \
    && echo "$(cat allure-commandline-${ALLURE_VERSION}.zip.sha1)  allure-commandline-${ALLURE_VERSION}.zip" | sha1sum -c \
    && unzip allure-commandline-${ALLURE_VERSION}.zip -d /opt/ \
    && mv /opt/allure-${ALLURE_VERSION} /opt/allure \
    && ln -s /opt/allure/bin/allure /usr/bin/allure \
    && rm -f allure-commandline-${ALLURE_VERSION}.zip \
    && rm -f allure-commandline-${ALLURE_VERSION}.zip.md5 \
    && allure --version