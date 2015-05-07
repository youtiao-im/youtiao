# channels.create

This method creates a new channel.


## URL

`POST https://api.youtiao.im/v1/channels`


## Arguments

| Argument | Example | Required | Description         |
| -------- | ------- | -------- | ------------------- |
| `name`   | `foo`   | Required | Name of the channel |


## Response

```json
{
  "id": 1,
  "name": "foo",
  "users": [{
    "id": 1,
    "role": "admin"
  }]
}
```


## Errors

| Error | Description        |
| ----- | ------------------ |
| `400` | Invalid parameters |
