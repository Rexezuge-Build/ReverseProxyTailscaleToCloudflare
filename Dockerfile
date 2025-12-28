FROM rexezugedockerutils/cloudflared AS cloudflared

FROM rexezugedockerutils/usagi-init:release AS usagi-init

FROM rexezugedockerutils/health-check-go AS health-check-go

FROM alpine AS runtime

COPY --from=cloudflared /cloudflared /usr/local/bin/cloudflared

COPY --from=usagi-init /UsagiInit /UsagiInit

COPY --from=health-check-go /HealthCheck-Go /HealthCheck-Go

RUN apk update && apk add --no-cache curl

RUN (curl -fsSL https://tailscale.com/install.sh | sh) || true

RUN apk del curl

RUN rm -rf /var/cache/apk/*

ADD overlay/ .

FROM scratch

COPY --from=runtime / /

ENV TS_AUTHKEY=REPLACE_ME

ENV CLOUDFLARE_TOKEN=REPLACE_ME

ENTRYPOINT ["/UsagiInit"]
