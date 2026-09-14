package com.example;

public class Main {

    public static void main(String[] args) {

        System.out.println("=================================");
        System.out.println("Distroless Docker Container");
        System.out.println("Java application started");
        System.out.println("Minimal production runtime");
        System.out.println("=================================");

        while (true) {
            try {
                Thread.sleep(30000);
                System.out.println("Application is running...");
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                break;
            }
        }
    }
}