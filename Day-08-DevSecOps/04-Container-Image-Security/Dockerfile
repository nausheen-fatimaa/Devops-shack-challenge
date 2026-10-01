FROM nginx:alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /usr/share/nginx/html

COPY tests/index.html /usr/share/nginx/html/index.html

USER appuser
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
