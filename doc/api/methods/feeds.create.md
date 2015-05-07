# feeds.create

This method creates a new feed in a channel.


## URL

`POST https://api.youtiao.im/v1/channels/:channel_id/feeds`


## Arguments

| Argument     | Example | Required | Description         |
| ------------ | ------- | -------- | ------------------- |
| `channel_id` | `1`     | Required | Id of the channel   |
| `content`    | `hello` | Required | Content of the feed |


## Response

```json
{
    "id": 1,
    "content": "hello",
    "creator_id": "1"
}
```


## Errors

| Error | Description        |
| ----- | ------------------ |
| `400` | Invalid parameters |
| `404` | No such channel    |
