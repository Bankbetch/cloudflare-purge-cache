# 

![Cloudflare](https://img.shields.io/badge/Cloudflare-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white)

### Quick start

Create an API token [guide](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/).

### config environment file

- export API key

```sh
$ export CF_EMAIL=$CHANGE_ME
$ export CF_PURGE_CACHE_API_KEY=$CHANGE_ME
```

- If you want to run single ZoneId

```sh
$ export CF_ZONE_ID=$CHANGE_ME
$ bash run.sh -h "[\"https://hello.com/*\"]"
```

- If you want to run multiple ZoneId

```sh
# example
$ bash run.sh -h "[\"https://hello.com/*\"]" -z xxxxx
```
