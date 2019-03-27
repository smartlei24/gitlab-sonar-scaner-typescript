FROM openjdk:8-jdk-alpine

ENV SONAR_SCANNER_VERSION 3.3.0.1492
ENV PHANTOMJS_VERSION 2.1.1

ADD https://bintray.com/sonarsource/SonarQube/download_file?file_path=org%2Fsonarsource%2Fscanner%2Fcli%2Fsonar-scanner-cli%2F${SONAR_SCANNER_VERSION}%2Fsonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip /tmp/sonar-scanner.zip

WORKDIR /tmp

RUN \
    unzip /tmp/sonar-scanner.zip && \
    mv -fv /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/bin && \
    mv -fv /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}/lib/* /usr/lib

RUN \
    apk add --no-cache nodejs nodejs-npm && \
    ls -lha /usr/bin/sonar* && \
    ln -s /usr/bin/sonar-scanner-run.sh /usr/bin/gitlab-sonar-scanner

WORKDIR /usr/bin

RUN \
    npm install -g typescript eslint

ENV NODE_PATH "/usr/lib/node_modules/"


RUN apk add --no-cache curl && \
    curl -k -Ls "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" | tar -jxf - && \
    cp ./phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs && \
    rm -fR phantomjs-${PHANTOMJS_VERSION}-linux-x86_64 && \
    apk del curl 

COPY server.js /tmp

EXPOSE 8910

CMD ["phantomjs", "/tmp/server.js"]
