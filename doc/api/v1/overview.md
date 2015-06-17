# Overview

* [Root Endpoint](#root-endpoint)
* [Authentication](#authentication)

## Root Endpoint

```
https://api.youtiao.im/v1
```

## Authentication

### OAuth2 Token (sent in a header)

```bash
$ curl -H "Authorization: Bearer :OAUTH_TOKEN" https://api.youtiao.im/v1
```

### OAuth2 Token (sent in a parameter)

```bash
$ curl https://api.youtiao.im/v1?access_token=:OAUTH_TOKEN
```
