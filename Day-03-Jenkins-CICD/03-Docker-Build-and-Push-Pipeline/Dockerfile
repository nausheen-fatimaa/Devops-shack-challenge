FROM eclipse-temurin:17-jre

WORKDIR /app

COPY 01-Basic-Application-CI-Pipeline/target/ai-notepad-1.0.0.jar app.jar

EXPOSE 8082

ENTRYPOINT ["java", "-jar", "app.jar"]