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

<<<<<<< HEAD
# Copy the built jar file to the Docker image
COPY build/libs/flights-service-crazy-air-0.0.1-SNAPSHOT.jar flightservice-crazyair.jar
=======
# Copy the built jar file from the build stage
COPY --from=build /app/build/libs/flights-service-crazy-air-0.0.1-SNAPSHOT.jar flightservice.jar
>>>>>>> 9cfb154905f5bcb544c192ddc6a1053a1547076b

# Expose the port that the service will run on
EXPOSE 8082

# Set the entry point to run the jar file
<<<<<<< HEAD
ENTRYPOINT ["java", "-jar", "flightservice-crazyair.jar"]
=======
ENTRYPOINT ["java", "-jar", "flightservice.jar"]
>>>>>>> 9cfb154905f5bcb544c192ddc6a1053a1547076b
