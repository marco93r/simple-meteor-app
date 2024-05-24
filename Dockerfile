# Use the official Meteor base image
FROM geoffreybooth/meteor-base:2.7

# Set working directory
WORKDIR /app

# Copy the application code to the container
COPY . .

# Install application dependencies
RUN meteor npm install

# Build the application
RUN meteor build --directory /app/build

# Set the working directory to the build directory
WORKDIR /app/build/bundle

# Install server dependencies
RUN (cd programs/server && npm install)

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["node", "main.js"]
