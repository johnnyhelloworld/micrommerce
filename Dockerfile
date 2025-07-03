# Utilisation d'une image de base avec OpenJDK 17
FROM openjdk:17-jdk-slim

# Définition du répertoire de travail
WORKDIR /app

# Copie du fichier pom.xml et du wrapper Maven
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .
COPY mvnw.cmd .

# Rendre le wrapper Maven exécutable
RUN chmod +x ./mvnw

# Téléchargement des dépendances (pour optimiser le cache Docker)
RUN ./mvnw dependency:go-offline -B

# Copie du code source
COPY src ./src

# Construction de l'application
RUN ./mvnw clean package -DskipTests

# Exposition du port 8080
EXPOSE 8080

# Commande pour démarrer l'application
CMD ["java", "-jar", "target/micrommerce-0.0.1-SNAPSHOT.jar"]