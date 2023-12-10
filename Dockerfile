FROM rclone/rclone:latest
RUN apk add --no-cache curl su-exec

# Install supercronic
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.2.28/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA256SUM=c05bb5d3494b27dfe869acd08004e4eb869bab8684b2b7a7036099d7878f8956
RUN curl -fsSLO "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA256SUM}  ${SUPERCRONIC}" | sha256sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

# Copy entrypoint script
COPY /docker-entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh
# Set entrypoint
ENV PUID=1000 PGID=1000 HOME=/data
ENTRYPOINT ["/bin/entrypoint.sh", "supercronic"]
# Set default argument
CMD ["/etc/supercronic/crontab"]
