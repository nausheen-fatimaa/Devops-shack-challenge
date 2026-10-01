FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY target/day8-demo-app-1.0.0.jar app.jar
USER 10001
ENTRYPOINT ["java", "-jar", "app.jar"]
