# Etapa 1: build con Maven
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests


# Etapa 2: runtime
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Copia el jar generado
COPY --from=build /app/target/product-management-0.0.1-SNAPSHOT.jar app.jar

# Puerto dinámico para Render
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]