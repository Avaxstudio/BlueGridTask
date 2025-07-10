FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY complete/pom.xml .
COPY complete/src/ ./src/
RUN mvn clean package -DskipTests=true

FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
