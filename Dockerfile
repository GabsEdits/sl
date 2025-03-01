# Use the official Deno base image
FROM denoland/deno:2.0.0

# Set the working directory
WORKDIR /app

# Copy project files
COPY . .

# Set up environment variables (will be provided at runtime)
ENV VITE_PASSWORD_KEY=""
ENV VITE_LINK1=""
ENV VITE_LINK2=""
ENV VITE_LINK3=""
ENV VITE_LINK4=""

# Install dependencies
RUN deno task build

# Expose the port that VitePress serves on
EXPOSE 4173

# Start the VitePress preview server
CMD ["deno", "task", "preview"]
