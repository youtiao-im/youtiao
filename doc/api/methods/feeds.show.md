# feeds.show

## URL

`GET https://api.youtiao.im/v1/channels/:channel_id/feeds/:id`

## Arguments

| Argument     | Example    | Required | Description |
| ------------ | ---------- | -------- | ----------- |
| `channel_id` | `kGzZ3eQg` | Required | Channel id  |
| `id`         | `A75gyQR2` | Required | Feed id     |

## Response

[feed](../types/feed.md)

## Errors

| Error | Description  |
| ----- | ------------ |
| `404` | No such feed |
