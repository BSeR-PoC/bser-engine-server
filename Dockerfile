#Build the Maven project
FROM maven:3.9.6-amazoncorretto-21-al2023 as builder
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN mvn clean install

#Build the Tomcat container
FROM tomcat:jre21

# Copy war file to webapps.
COPY --from=builder /usr/src/app/Keys /opt/Keys
COPY --from=builder /usr/src/app/bser-engine/target/bser-engine.war $CATALINA_HOME/webapps/ROOT.war

EXPOSE 8080
