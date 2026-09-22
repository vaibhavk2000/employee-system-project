FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY src /app/src
RUN javac src/employee/*.java
CMD ["java", "-cp", "src", "employee.Main"]
