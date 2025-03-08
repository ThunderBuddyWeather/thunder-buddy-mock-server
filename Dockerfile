FROM openjdk:11-jre-slim

# Set WireMock version
ENV WIREMOCK_VERSION=2.35.0

# Install WireMock
RUN apt-get update && apt-get install -y wget \
    && wget -O /tmp/wiremock.jar https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-jre8-standalone/${WIREMOCK_VERSION}/wiremock-jre8-standalone-${WIREMOCK_VERSION}.jar \
    && mkdir -p /opt/wiremock \
    && mv /tmp/wiremock.jar /opt/wiremock/wiremock.jar \
    && apt-get remove -y wget \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /opt/wiremock

# Copy mappings directory
COPY mappings /opt/wiremock/mappings

# Copy swagger definition
COPY weatherbit-swagger.json /opt/wiremock/

# Create directory for response files
RUN mkdir -p /opt/wiremock/__files

# Expose port for WireMock
EXPOSE 8080

# Run WireMock with global response templating and verbose output
ENTRYPOINT ["java", "-jar", "/opt/wiremock/wiremock.jar", "--global-response-templating", "--verbose"]

# Allow additional arguments to be passed at runtime
CMD []