#!/UsagiInit
/HealthCheck-Go > /dev/null 2> /dev/null &
/usr/sbin/tailscaled -no-logs-no-support --tun=userspace-networking --socks5-server=localhost:1055
sleep 10s
/usr/bin/tailscale up --auth-key $TS_AUTHKEY --accept-dns=false --accept-routes=false
export HTTP_PROXY=socks5://127.0.0.1:1055
export HTTPS_PROXY=socks5://127.0.0.1:1055
/usr/local/bin/cloudflared tunnel --no-autoupdate --loglevel error run --token $CLOUDFLARE_TOKEN
