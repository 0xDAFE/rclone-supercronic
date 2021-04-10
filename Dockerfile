FROM rclone/rclone:latest
RUN apk add curl
# Install supercronic
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA256SUM=8d3a575654a6c93524c410ae06f681a3507ca5913627fa92c7086fd140fa12ce
RUN curl -fsSLO "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA256SUM}  ${SUPERCRONIC}" | sha256sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic
# Set entrypoint
ENTRYPOINT ["supercronic"]
# Set default argument
CMD ["/etc/supercronic/crontab"]
