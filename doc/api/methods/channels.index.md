# channels.index

This method lists all channels that are accessible to the user.


## URL

`GET https://api.youtiao.im/v1/channels`


## Arguments

| Argument | Example | Required | Description       |
| -------- | ------- | -------- | ----------------- |
| `page`   | `1`     | Optional | Paginate channels |


## Response

```json
[{
    "id": 1,
    "name": "foo"
}, {
    "id": 2,
    "name": "bar"
}, ...]
```


## Errors

| Error | Description  |
| ----- | ------------ |
| `500` | Server error |
