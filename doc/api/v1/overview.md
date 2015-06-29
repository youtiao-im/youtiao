# Overview

## Root Endpoint

```
https://api.youtiao.im/v1
```

## Schema

All API access is over HTTPS, and accessed from the `api.youtiao.im` domain. All data is sent and received as JSON.

Blank fields are included as `null` instead of being ommitted.

All timestamps are returned in seconds since epoch:

```
1434633474.270281
```

## Parameters

Many API methods take optional parameters. For GET requests, any parameters not specified as a segment in the path can be passed as an HTTP query string parameter.

For POST, PATCH, PUT, and DELETE requests, parameters not included in the URL should be encoded as JSON with a Content-Type of `application/json`.
