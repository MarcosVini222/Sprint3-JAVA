# Etapa de build
FROM gradle:8.7.0-jdk21 AS BUILD
WORKDIR /usr/app

COPY . .
RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

# Etapa de execução
FROM eclipse-temurin:21-jdk
WORKDIR /app

# Copia o .jar gerado dinamicamente, qualquer que seja o nome
COPY --from=BUILD /usr/app/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
