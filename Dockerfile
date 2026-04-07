FROM rexezugedockerutils/cloudflared AS cloudflared

FROM rexezugedockerutils/health-check-go AS health-check-go

FROM rexezugedockerutils/tailscale AS tailscale

FROM alpine AS runtime

COPY --from=cloudflared /cloudflared /usr/local/bin/cloudflared

COPY --from=health-check-go /HealthCheck-Go /HealthCheck-Go

RUN apk update && apk add --no-cache curl

COPY --from=tailscale /usr/sbin/tailscaled /usr/sbin/tailscaled

COPY --from=tailscale /usr/bin/tailscale /usr/bin/tailscale

RUN rm -rf /var/cache/apk/*

ADD overlay/ .

FROM scratch

COPY --from=runtime / /

ENTRYPOINT ["/Entrypoint.sh"]
