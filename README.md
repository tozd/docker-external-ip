Run:

```
$ docker run --detach --net=host --cap-add=NET_ADMIN --cap-add=NET_RAW --volume /var/run/docker.sock:/var/run/docker.sock --volume /run/xtables.lock:/run/xtables.lock tozd/external-ip
```

After that, if any other Docker container has an environment variable `EXTERNAL_IP` set, with an IP address to use for
containers external IP, iptables will be configured to route container's traffic from that external IP.

A chain named `EXTERNAL_IP` is created in the `nat` table into which all the rules are added.
And one more empty chain is created after this one for any additional custom rules you might want
to add, named `AFTER_EXTERNAL_IP`.

Please make sure `/run/xtables.lock` exists on the host before starting the container.
If this file does not exist, Docker will incorrectly create it as a directory, which may cause issues both on the host and with the container.
