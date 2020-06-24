Run:

```
$ docker run --detach --net=host --cap-add=NET_ADMIN --cap-add=NET_RAW --volume /var/run/docker.sock:/var/run/docker.sock tozd/external-ip
```

After that, if any other Docker container has an environment variable `EXTERNAL_IP` set, with an IP address to use for
containers external IP, iptables will be configured to route container's traffic from that external IP.

A chain named `EXTERNAL_IP` is created in the `nat` table into which all the rules are added.
And one more empty chain is created after this one for any additional custom rules you might want
to add, named `AFTER_EXTERNAL_IP`.

### Example
 - Edit the docker-compose.yml file, with the correct external IPs needed. You can add or remove as many as you need. This external IPs must be assigned on the host interface(s)
 - Run `docker-compose up -d`
 - Run `for ID in a b c;do echo -n "$ID: "; docker-compose exec $ID curl ifconfig.me;echo;done` to show each container's external IP. Change "a b c" as needed.
