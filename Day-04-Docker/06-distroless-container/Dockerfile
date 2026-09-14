# =========================
# Stage 1: Build
# =========================

FROM maven:3.9-eclipse-temurin-17 AS builder

WORKDIR /build

COPY pom.xml .

COPY src ./src

RUN mvn clean package -DskipTests


# =========================
# Stage 2: Distroless
# =========================

FROM gcr.io/distroless/java17-debian12:nonroot

WORKDIR /app

COPY --from=builder /build/target/distroless-demo-1.0.0.jar app.jar

USER nonroot:nonroot

ENTRYPOINT ["java", "-jar", "/app/app.jar"]