FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app/complete
COPY complete/pom.xml .
RUN mvn clean install -DskipTests
COPY complete/ .
RUN mvn clean package -DskipTests

FROM gcr.io/distroless/java17-debian11
WORKDIR /app/complete
COPY --from=build /app/complete/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar", "--server.address=0.0.0.0"]
