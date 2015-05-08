# channels.join

## URL

`POST https://api.youtiao.im/v1/channels/:id/join`

## Arguments

| Argument | Example | Required | Description |
| -------- | ------- | -------- | ----------- |
| `id`     | `1`     | Required | Channel id  |

## Response

[channel](../types/channel.md)

## Errors

| Error | Description     |
| ----- | --------------- |
| `404` | No such channel |
