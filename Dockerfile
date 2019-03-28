FROM openjdk:8-jdk-alpine

ENV SONAR_SCANNER_VERSION 3.3.0.1492
ENV PHANTOMJS_VERSION 2.1.1
ENV NODE_PATH "/usr/lib/node_modules/"

WORKDIR /tmp

ADD https://bintray.com/sonarsource/SonarQube/download_file?file_path=org%2Fsonarsource%2Fscanner%2Fcli%2Fsonar-scanner-cli%2F${SONAR_SCANNER_VERSION}%2Fsonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip /tmp/sonar-scanner.zip
RUN \
    unzip /tmp/sonar-scanner.zip && \
    mv -fv /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/bin && \
    mv -fv /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}/lib/* /usr/lib

WORKDIR /usr/bin

RUN \
    apk add --no-cache nodejs nodejs-npm curl && \
    ls -lha /usr/bin/sonar* && \
    ln -s /usr/bin/sonar-scanner-run.sh /usr/bin/gitlab-sonar-scanner

RUN curl -Ls "https://github.com/dustinblackman/phantomized/releases/download/${PHANTOMJS_VERSION}/dockerized-phantomjs.tar.gz" | tar xz -C / \
    && apk del curl

ENV NPM_CONFIG_PREFIX=/home/node/.npm-global
ENV PATH=$PATH:/home/node/.npm-global/bin

RUN \
    npm install -g typescript eslint
