FROM gcr.io/distroless/java17-debian11

WORKDIR /app
COPY target/*.jar app.jar

EXPOSE 8080
CMD ["app.jar"]

