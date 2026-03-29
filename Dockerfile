FROM rexezugedockerutils/cloudflared AS cloudflared

FROM rexezugedockerutils/health-check-go AS health-check-go

FROM alpine AS runtime

COPY --from=cloudflared /cloudflared /usr/local/bin/cloudflared

COPY --from=health-check-go /HealthCheck-Go /HealthCheck-Go

RUN apk update && apk add --no-cache curl

RUN (curl -fsSL https://tailscale.com/install.sh | sh) || true

RUN rm -rf /var/cache/apk/*

ADD overlay/ .

FROM scratch

COPY --from=runtime / /

ENTRYPOINT ["/Entrypoint.sh"]
