# Stage 1: Build the application - Use Oracle's official minimal base image with Java 17
FROM maven:3.6.3-openjdk-17-slim AS builder
WORKDIR /app
COPY . /app
RUN mvn clean package -DskipTests

# Stage 2: Production image
FROM eclipse-temurin:17-jre-alpine
# Set working directory
WORKDIR /app
# Copy built jar from the builder stage
COPY --from=builder /app/target/united-airlines-api-1.0.0.jar app.jar
# Expose port
EXPOSE 8080
# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]