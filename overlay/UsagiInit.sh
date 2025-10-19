/usr/sbin/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 > /dev/null &
sleep 10s
/usr/bin/tailscale up --auth-key $TS_AUTHKEY
export ALL_PROXY=socks5://localhost:1055
/usr/local/bin/cloudflared tunnel --no-autoupdate run --token $CLOUDFLARE_TOKEN > /dev/null &
