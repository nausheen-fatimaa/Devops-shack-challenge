package com.ai.notepad;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestClient;

import java.util.Map;

@RestController
@RequestMapping("/api/ai")
@CrossOrigin
public class GeminiController {

    @Value("${gemini.api-key}")
    private String apiKey;

    @Value("${gemini.model}")
    private String model;
    
    


    private final ObjectMapper objectMapper = new ObjectMapper();

    @PostMapping("/ask")
    public Map<String, String> askGemini(
            @RequestBody Map<String, String> request) {

        String prompt = request.get("prompt");

        if (prompt == null || prompt.isBlank()) {
            return Map.of(
                    "error",
                    "Prompt cannot be empty"
            );
        }
        
        if (apiKey == null || apiKey.isBlank()) {
            return Map.of(
                    "error",
                    "Gemini API key is not configured."
            );
        }

        try {

            RestClient client = RestClient.builder()
                    .baseUrl("https://generativelanguage.googleapis.com")
                    .build();

            String response = client.post()
                    .uri(
                        "/v1beta/models/{model}:generateContent",
                        model)
                    .header("x-goog-api-key", apiKey)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(
                        Map.of(
                            "contents",
                            new Object[]{
                                Map.of(
                                    "parts",
                                    new Object[]{
                                        Map.of(
                                            "text",
                                            prompt
                                        )
                                    }
                                )
                            }
                        )
                    )
                    .retrieve()
                    .body(String.class);

            JsonNode root =
                    objectMapper.readTree(response);

            JsonNode text =
                    root.path("candidates")
                        .path(0)
                        .path("content")
                        .path("parts")
                        .path(0)
                        .path("text");

            if (text.isMissingNode()) {
                return Map.of(
                        "error",
                        "Gemini returned an unexpected response."
                );
            }

            return Map.of(
                    "text",
                    text.asText()
            );

        } catch (Exception e) {

            return Map.of(
                    "error",
                    "Gemini request failed: " +
                    e.getMessage()
            );
        }
    }
}