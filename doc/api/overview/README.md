# Overview

* [Current Version](#current-version)
* [Root Endpoint](#root-endpoint)
* [Authentication](#authentication)
* [Pagination](#pagination)

## Current Version

By default, all requests receive the **v1** version of the API.

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

## Pagination

Requests that return multiple items will be paginated to 25 items by default. You can specify further pages with the `?page` parameter. You can also set a custom page size up to 100 with the `?per_page` parameter.

### Link Header

The pagination info is included in the Link header. It is important to follow these Link header values instead of constructing your own URLs.

```
TODO: fill in
```

The possible `rel` values are:

| Name    | Description                                    |
| ------- | ---------------------------------------------- |
| `next`  | URL of the immediate next page of results.     |
| `last`  | URL of the last page of results.               |
| `first` | URL of the first page of results.              |
| `prev`  | URL of the immediate previous page of results. |
