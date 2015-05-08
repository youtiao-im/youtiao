# feeds.show

## URL

`POST https://api.youtiao.im/v1/channels/:channel_id/feeds/:id/stamp`

## Arguments

| Argument     | Example    | Required | Description |
| ------------ | ---------- | -------- | ----------- |
| `channel_id` | `kGzZ3eQg` | Required | Channel id  |
| `id`         | `A75gyQR2` | Required | Feed id     |
| `kind`       | `check`    | Required | Stamp kind  |

## Response

*empty*

## Errors

| Error | Description  |
| ----- | ------------ |
| `404` | No such feed |
