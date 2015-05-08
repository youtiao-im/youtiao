# feeds.index

## URL

`GET https://api.youtiao.im/v1/channels/:channel_id/feeds`

## Arguments

| Argument     | Example | Required | Description              |
| ------------ | ------- | -------- | ------------------------ |
| `channel_id` | `1`     | Required | Channel id               |
| `per_page`   | `25`    | Optional | Number of feeds per page |
| `page`       | `1`     | Optional | Page number              |

## Response

[feed](../types/feed.md) array

## Errors

| Error | Description        |
| ----- | ------------------ |
| `404` | No such channel    |
