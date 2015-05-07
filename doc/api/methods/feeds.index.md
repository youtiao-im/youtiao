# feeds.index

This method lists all feeds in a channel.


## URL

`GET https://api.youtiao.im/v1/channels/:channel_id/feeds`


## Arguments

| Argument     | Example | Required | Description         |
| ------------ | ------- | -------- | ------------------- |
| `channel_id` | `1`     | Required | Id of the channel   |


## Response

```json
[{
    "id": 1,
    "content": "hello",
    "creator_id": "1"
}, {
    "id": 2,
    "content": "world",
    "creator_id": "1"
}, ...]
```


## Errors

| Error | Description        |
| ----- | ------------------ |
| `400` | Invalid parameters |
| `404` | No such channel    |
