# Authorization

We are using *OAuth2* to protect our api endpoint. But for now, we only
provide **password grant type**, and the request will be like:
`POST https://api.youtiao.im/oauth/token?grant_type=password&username=:email&password=:password`.
