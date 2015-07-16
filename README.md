# envy-proxy

`envy-proxy` is a reverse proxy to all of your [envy](https://github.com/progrium/envy) environments. For example `http://80-app-name.example.com` will proxy to the `app` envy environment under the `name` user at port 80.

* Make sure you set the ROOT_HOST
* Make sure your root host has a wildcard dns entry for it
* If you run this on port 80, you'll need to run the envy term on another port

_:warning: `envy-proxy` currently relies on having an Envy instance with [this patch](https://github.com/progrium/envy/pull/41)
applied :warning:_

## Installation

```sh
docker run -d \
           -v /var/run/docker.sock:/tmp/docker.sock:ro \
           -e ROOT_HOST=example.com \
           -p 80:80 \
           --name envy-proxy \
           gregallen/envy-proxy
```

By default, only the `80` port will be exposed, but you can pass in a comma
separated list of ports as the`PROXY_PORTS` environmental variable to expose other
ports as well.

For example:

```sh
docker run -d \
           -v /var/run/docker.sock:/tmp/docker.sock:ro \
           -e ROOT_HOST=example.com \
           -e PROXY_PORTS='80,8080,3000' \
           -p 80:80 \
           --name envy-proxy \
           gregallen/envy-proxy
```

Will allow accessing environments from `80`, `8080` and `3000` ports.

## How does it work?

Once started, `envy-proxy` will listen to Docker events and will set up its
nginx instance to forward `http://<port>-<envy-environment>-<user>.<HOST_ROOT>`
requests to the underlying Envy environment on the corresponding port.

For example, if you run a web server on port `8080` from a `username+webapp@envy.host`
session, you'll be able to reach it on your browser using `http://8080-webapp-username.<HOST_ROOT>`
