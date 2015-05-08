# channels.index

## URL

`GET https://api.youtiao.im/v1/channels`

## Arguments

| Argument   | Example | Required | Description                 |
| ---------- | ------- | -------- | --------------------------- |
| `per_page` | `25`    | Optional | Number of channels per page |
| `page`     | `1`     | Optional | Page number                 |

## Response

[channel](../types/channel.md) array

## Errors

| Error | Description  |
| ----- | ------------ |
| `500` | Server error |
