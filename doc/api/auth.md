# Authorization

We are using *OAuth2* to protect our api endpoint. And for now, we only provide
the **password grant flow**:

`POST https://api.youtiao.im/oauth/token?grant_type=password&username=:email&password=:password`
