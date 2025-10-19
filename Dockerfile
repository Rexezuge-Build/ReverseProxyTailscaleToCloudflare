FROM rexezugedockerutils/cloudflared AS cloudflared

FROM rexezugedockerutils/usagi-init:release AS usagi-init

FROM debian:12-slim AS runtime

COPY --from=cloudflared /cloudflared /usr/local/bin/cloudflared

COPY --from=usagi-init /UsagiInit /UsagiInit

RUN apt update && apt install -y --no-install-recommends curl ca-certificates

RUN curl -fsSL https://tailscale.com/install.sh | sh

RUN apt clean \
 && apt autoremove --purge -y curl\
 && apt autoremove --purge apt --allow-remove-essential -y \
 && rm -rf /var/log/apt /etc/apt \
 && rm -rf /var/lib/{apt,dpkg,cache,log}/

ADD overlay/ .

FROM scratch

COPY --from=runtime / /

ENTRYPOINT ["/UsagiInit"]
