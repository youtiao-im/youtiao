# API

* [Overview](#overview)
  * [Root Endpoint](#root-endpoint)
  * [Schema](#schema)
  * [Parameters](#parameters)
  * [Authentication](#authentication)
  * [Errors](#errors)
* [Text Formatting](text_formatting.md)
* [File Uploading](#file-uploading)
* [Resources](#resources)


## Overview

### Root Endpoint

```
https://api.youtiao.im/v1
```

### Schema

All API access is over HTTPS, and accessed from the `api.youtiao.im` domain. All data is sent and received as JSON.

Blank fields are included as `null` instead of being ommitted.

All timestamps are returned in seconds since epoch:

```
1434633474.270281
```

### Parameters

Many API methods take optional parameters. For GET requests, any parameters not specified as a segment in the path can be passed as an HTTP query string parameter.

For POST, PATCH, PUT, and DELETE requests, parameters not included in the URL should be encoded as JSON with a Content-Type of `application/json`.

### Authentication

Unless additionally specified, all API requires authentication.

#### OAuth2 Password Grant Flow

```
POST https://youtiao.im/oauth/token?grant_type=password&username=:email&password=:password
```

#### OAuth2 Token (sent in a header)

```bash
$ curl -H "Authorization: Bearer :OAUTH_TOKEN" https://api.youtiao.im/v1
```

#### OAuth2 Token (sent in a parameter)

```bash
$ curl https://api.youtiao.im/v1?access_token=:OAUTH_TOKEN
```

### Errors

| HTTP Status Code | Description |
| ---------------- | ----------- |
| `400`            | Missing required parameter / Invalid parameter |
| `401`            | Not authenticated |
| `403`            | Permission denied |
| `404`            | Resource not found / No route |
| `422`            | Unprocessable entity |
| `5xx`            | Server error |


## File Uploading

We use *Qiniu* to host all user uploaded files. Before you can upload anything to Qiniu, you need to acquire an upload token first:

```
POST /blobs/token
```

With the upload token in hand, you can upload the file using [Qiniu SDKs](https://github.com/qiniu). When upload finishes, the response would be a blob object:

```json
{
    "type": "Blob",
    "id": "d3853a59",
    "data_url": "http://youtiao.qiniudn.com/Fu6K0Vvi-jUSuW-1EQ5mhhk1ByPQ",
    "created_at": "1434633474.270281",
    "updated_at": "1434633474.270281"
}
```

You can then reference the uploaded file when creating or updating other resources using blob id.


## Resources

* [Users](users.md)
* [Groups](groups.md)
* [Memberships](memberships.md)
* [Bulletins](bulletins.md)
* [Stamps](stamps.md)
* [Comments](comments.md)
