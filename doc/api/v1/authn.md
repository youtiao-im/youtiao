# Authentication

Unless additionally specified, all API requires authentication.


## Acquire OAuth2 Access Token

### OAuth2 Password Grant Flow

```
$ curl -X POST -d "grant_type=password&username=:email&password=:password" https://youtiao.im/oauth/token
```


## Use OAuth2 Access Token

### Sent Using Header

```bash
$ curl -H "Authorization: Bearer :OAUTH_TOKEN" https://api.youtiao.im/v1
```

### Sent Using Parameter

```bash
$ curl https://api.youtiao.im/v1?access_token=:OAUTH_TOKEN
```


## Revoke OAuth2 Access Token

### Sent Using Form Data

```
$ curl -X POST -H "Authorization: Bearer :OAUTH_TOKEN" -F token=:OAUTH_TOKEN https://youtiao.im/oauth/revoke
```

### Sent Using JSON Body

Instead of passing `token` in form data, you can as well pass it in JSON formatted body. In this case, please **DO** set `Content-Type` header to `application/json`.
