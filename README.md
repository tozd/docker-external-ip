Run:

```
$ docker run --detach --net=host --cap-add=NET_ADMIN --cap-add=NET_RAW --volume /var/run/docker.sock:/var/run/docker.sock tozd/external-ip
```

After that, if any other Docker container has an environment variable `EXTERNAL_IP` set, with an IP address to use for
containers external IP, iptables will be configured to route container's traffic from that external IP.

A chain named `EXTERNAL_IP` is created in the `nat` table into which all the rules are added.
And one more empty chain is created after this one for any additional custom rules you might want
to add, named `AFTER_EXTERNAL_IP`.

### docker-compose example:
```
version: '3'

services:
  nat_manager:
    image: tozd/external-ip
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    network_mode: host
    cap_add:
      - NET_ADMIN
      - NET_RAW
    restart: unless-stopped

  a:
    image: darnt80/alpine-curl:arm # arm|x86
    command: 'http://www.myip.ch'
    environment:
      EXTERNAL_IP: XX.XX.XX.XX
    restart: unless-stopped

  b:
    image: darnt80/alpine-curl:arm # arm|x86
    command: 'http://www.myip.ch'
    environment:
      EXTERNAL_IP: YY.YY.YY.YY
    restart: unless-stopped

networks:
  default:
    driver_opts:
      com.docker.network.bridge.enable_ip_masquerade: "false"
```
where XX.XX.XX.XX / YY.YY.YY.YY - your external IP address
