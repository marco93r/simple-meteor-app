# Verwende das Node.js-Image als Basis, da Meteor darauf aufbaut
FROM node:14

# Setze das Arbeitsverzeichnis im Container
WORKDIR /app

# Kopiere die Anwendungsdateien in das Arbeitsverzeichnis im Container
COPY . .

# Installiere Meteor
RUN curl https://install.meteor.com/ | sh

# Installiere die Abhängigkeiten
RUN meteor npm install

# Baue die Meteor-Anwendung
RUN meteor build --directory /app/build --server-only

# Setze das Arbeitsverzeichnis auf das Verzeichnis der gebauten Anwendung
WORKDIR /app/build/bundle

# Installiere die Abhängigkeiten der gebauten Anwendung
RUN (cd programs/server && npm install)

# Setze die Umgebungsvariable für den Port
ENV PORT=3000

# Exponiere den Port
EXPOSE 3000

# Startbefehl für die Anwendung
CMD ["node", "main.js"]
