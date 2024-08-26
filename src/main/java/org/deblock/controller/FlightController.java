package org.deblock.controller;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@RestController
public class FlightController {

    @GetMapping("/flights")
    public ResponseEntity<String> getFlights(
            @RequestParam String origin,
            @RequestParam String destination,
            @RequestParam String departureDate,
            @RequestParam String returnDate,
            @RequestParam int numberOfPassengers) {

        // Log the input parameters (optional, for debugging purposes)
        System.out.println("Origin: " + origin);
        System.out.println("Destination: " + destination);
        System.out.println("Departure Date: " + departureDate);
        System.out.println("Return Date: " + returnDate);
        System.out.println("Number of Passengers: " + numberOfPassengers);

        System.out.println("from file : crazy-air-a.json");

        // Load the JSON file from the classpath
        Resource resource = new ClassPathResource("crazy-air-a.json");
        try (InputStream inputStream = resource.getInputStream()) {
            // Convert InputStream to String
            String jsonResponse = StreamUtils.copyToString(inputStream, StandardCharsets.UTF_8);

            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_TYPE, "application/json");

            return new ResponseEntity<>(jsonResponse, headers, HttpStatus.OK);
        } catch (IOException e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error reading JSON file", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
