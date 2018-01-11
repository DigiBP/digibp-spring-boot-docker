#Grab the alpine image with jdk-8
FROM openjdk:8-jre-alpine
MAINTAINER Andreas Martin <andreas.martin@andreasmartin.ch>
# Add our code
ARG JAR_FILE
ADD ${JAR_FILE} app.jar
# Expose is NOT supported by Heroku
ARG PORT=8080
ENV PORT $PORT
EXPOSE $PORT
# Run the image as a non-root user
RUN adduser -D myuser
USER myuser
# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku
CMD java -Dhttp.port=$PORT -Dspring.profiles.active=prod -jar /app.jar