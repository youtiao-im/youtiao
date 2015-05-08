# feeds.create

## URL

`POST https://api.youtiao.im/v1/channels/:channel_id/feeds`

## Arguments

| Argument     | Example    | Required | Description  |
| ------------ | ---------- | -------- | ------------ |
| `channel_id` | `kGzZ3eQg` | Required | Channel id   |
| `content`    | `hello`    | Required | Feed content |

## Response

[feed](../types/feed.md)

## Errors

| Error | Description        |
| ----- | ------------------ |
| `400` | Invalid parameters |
| `404` | No such channel    |
