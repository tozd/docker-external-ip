Run:

```
$ docker run --detach --net=host --cap-add=NET_ADMIN --cap-add=NET_RAW --volume /var/run/docker.sock:/var/run/docker.sock tozd/external-ip
```
