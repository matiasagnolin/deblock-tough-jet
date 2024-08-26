# Stage 1: Build the application
FROM gradle:7.5.1-jdk17 AS build

# Set the working directory inside the Docker container
WORKDIR /app

# Copy the Gradle wrapper and build files
COPY gradlew .
COPY gradle gradle
COPY build.gradle .
COPY settings.gradle .

# Copy the source code
COPY src src

# Build the application
RUN ./gradlew build --no-daemon

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim

# Set the working directory inside the Docker container
WORKDIR /app

# Copy the built jar file from the build stage
COPY --from=build /app/build/libs/flights-service-crazy-air-0.0.1-SNAPSHOT.jar flightservice.jar

# Expose the port that the service will run on
EXPOSE 8081

# Set the entry point to run the jar file
ENTRYPOINT ["java", "-jar", "flightservice.jar"]