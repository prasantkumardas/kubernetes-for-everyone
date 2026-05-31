# Fetch the relavent node image from docker hub
FROM node:20-alpine AS build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies in the container
RUN npm install

# Copy the source code to the container
COPY . .

# Set placeholder values so Vite bakes them into the bundle.
# The docker-entrypoint.sh script replaces these with real K8s env-var values
# at container startup, making the image reusable across environments.
ENV VITE_AUTH0_DOMAIN=VITE_AUTH0_DOMAIN_PLACEHOLDER
ENV VITE_AUTH0_AUDIENCE=VITE_AUTH0_AUDIENCE_PLACEHOLDER
ENV VITE_AUTH0_FO_CLIENT_ID=VITE_AUTH0_FO_CLIENT_ID_PLACEHOLDER
ENV VITE_AUTH0_CLIENT_ID=VITE_AUTH0_CLIENT_ID_PLACEHOLDER
ENV VITE_AUTH0_CLIENT_SECRET=VITE_AUTH0_CLIENT_SECRET_PLACEHOLDER
ENV VITE_LOCAL_API_URL=VITE_LOCAL_API_URL_PLACEHOLDER
ENV VITE_STRIPE_PUBLIC_KEY=VITE_STRIPE_PUBLIC_KEY_PLACEHOLDER

# Build the application
RUN npm run build

# Fetch the nginx image from docker hub
FROM nginx:alpine

# Copy the build files to the nginx server
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy and enable the runtime env-substitution entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Expose port 80
EXPOSE 80

# Substitute env vars at startup, then hand off to nginx
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
