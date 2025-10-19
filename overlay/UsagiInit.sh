#!/UsagiInit
/usr/sbin/tailscaled -no-logs-no-support --tun=userspace-networking --socks5-server=localhost:1055 > /dev/null &
sleep 3s
/usr/bin/tailscale up --auth-key $TS_AUTHKEY
export HTTP_PROXY=socks5://127.0.0.1:1055
export HTTPS_PROXY=socks5://127.0.0.1:1055
/usr/local/bin/cloudflared tunnel --no-autoupdate --loglevel error --token $CLOUDFLARE_TOKEN > /dev/null &
