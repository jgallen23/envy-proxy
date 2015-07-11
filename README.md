# envy-proxy

`envy-proxy` is a reverse proxy to all of your [envy](https://github.com/progrium/envy) environments. For example `http://app.name.example.com` will proxy to the `app` envy environment under the `name` user at port 80.

* Make sure you set the ROOT_HOST
* Make sure your root host has a wildcard dns entry for it
* If you run this on port 80, you'll need to run the envy term on another port

## Usage

```
docker run -d -v /var/run/docker.sock:/tmp/docker.sock:ro -e ROOT_HOST=example.com -p 80:80 --name envy-proxy gregallen/envy-proxy
```
