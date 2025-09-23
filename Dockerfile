# Runtime stage
FROM alpine:3.21

# Set timezone
ENV TZ=Asia/Tokyo

WORKDIR /app

# Install dependencies and filebrowser
RUN apk add --no-cache curl sudo shadow bash && \
    curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# Copy startup script
COPY start.sh entrypoint.sh /app
RUN chmod +x /app/start.sh && \
    chmod +x /app/entrypoint.sh

# Run the startup script
CMD ["/app/entrypoint.sh", "/app/start.sh"]