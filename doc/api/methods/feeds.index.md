# feeds.index

## URL

`GET https://api.youtiao.im/v1/channels/:channel_id/feeds`

## Arguments

| Argument     | Example | Required | Description |
| ------------ | ------- | -------- | ----------- |
| `channel_id` | `1`     | Required | Channel id  |

## Response

[feed](../types/feed.md) array

## Errors

| Error | Description        |
| ----- | ------------------ |
| `400` | Invalid parameters |
| `404` | No such channel    |
