# channels.subscribe

This method subscribes to a channel.


## URL

`POST https://api.youtiao.im/v1/channels/subscribe`


## Arguments

| Argument | Example | Required | Description                    |
| -------- | ------- | -------- | ------------------------------ |
| `code`   | `1234`  | Required | The unique code of the channel |


## Response

```json
{
    "id": 1,
    "name": "foo",
    "users": [{
        "id": 1,
        "role": "admin"
    }, {
        "id": 2,
        "role": "subscriber"
    }, ...]
}
```


## Errors

| Error | Description     |
| ----- | --------------- |
| `404` | No such channel |
