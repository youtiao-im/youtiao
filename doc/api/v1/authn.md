# Authentication

Unless additionally specified, all API requires authentication.

## Acquire OAuth2 Access Token

### OAuth2 Password Grant Flow

```
POST https://youtiao.im/oauth/token?grant_type=password&username=:email&password=:password
```


## Using OAuth2 Access Token

### Sent Using Header

```bash
$ curl -H "Authorization: Bearer :OAUTH_TOKEN" https://api.youtiao.im/v1
```

### Sent Using Parameter

```bash
$ curl https://api.youtiao.im/v1?access_token=:OAUTH_TOKEN
```
