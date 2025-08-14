
# Use official Node.js image
FROM node:18

# Create app directory
WORKDIR /usr/src/app

# Copy package.json & package-lock.json first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app source code
COPY . .

# Expose app port (8081 inside container)
EXPOSE 8081

# Start the app

FROM node:18-alpine
WORKDIR /app
COPY server.js .
EXPOSE 8081
152b61b59d4297d4f89b08668bad35f38afed753
CMD ["node", "server.js"]
