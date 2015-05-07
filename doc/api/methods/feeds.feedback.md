# feeds.feedback

This method creates/updates a feedback to a feed.


## URL

`POST https://api.youtiao.im/v1/channels/:channel_id/feeds/:id/feedback`


## Arguments

| Argument     | Example | Required | Description             |
| ------------ | ------- | -------- | ----------------------- |
| `channel_id` | `1`     | Required | Id of the channel       |
| `id`         | `1`     | Required | Id of the feed          |
| `sticker`    | `cross` | Required | Sticker of the feedback |


## Response

```json
```


## Errors

| Error | Description        |
| ----- | ------------------ |
| `400` | Invalid parameters |
| `404` | No such feed       |
