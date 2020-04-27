FROM docker.io/openjdk:8-jre

MAINTAINER Hygieia@capitalone.com

RUN mkdir /hygieia /hygieia/config

COPY hygieia/ /hygieia
COPY api-properties-builder.sh /hygieia/

RUN chmod -R a+x /hygieia
WORKDIR /hygieia
RUN sed -i -e 's/\r$//' ./api-properties-builder.sh

VOLUME ["/hygieia/logs"]

EXPOSE 8080

CMD ./api-properties-builder.sh &&
java -Djava.security.egd=file:/dev/./urandom -jar api.jar --spring.config.location=/hygieia/config/hygieia-api.properties
