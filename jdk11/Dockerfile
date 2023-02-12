FROM eclipse-temurin:11.0.18_10-jre-alpine
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN apk update \
    && apk upgrade \
    && apk add --no-cache ca-certificates tzdata curl fontconfig ttf-dejavu \
    && update-ca-certificates \
    && rm -rf /ca-certificates \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache

 RUN addgroup -g ${GROUP_ID} javarun \
     && adduser -u ${USER_ID} -S -G javarun javarun \
     && mkdir -p /home/javarun \
     && chown -R javarun:javarun /home/javarun

ENV JAVA_CACERTS=$JAVA_HOME/lib/security/cacerts \
    TZ=Asia/Shanghai \
    HOME=/home/javarun \
    JAVA_OPTS="-Dsecurerandom.source=file:/dev/urandom"

WORKDIR /home/javarun

USER ${USER_ID}
