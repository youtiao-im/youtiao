# Channels

* [Get](get)
* [Create](create)

## Get

```
GET /channels/:channel_id
```

### Response

```json
{
    "id": 1,
    "name": "Going Merry",
    "created_at": 1431596915,
    "updated_at": 1431596915
}
```

## Create

```
POST /channels
```

### Parameters

| Name     | Type       | Description                            |
| -------- | ---------- | -------------------------------------- |
| `name`   | `string`   | **Required**. The name of the channel. |

### Example

```json
{
    "name": "Going Merry"
}
```

### Response

```json
{
    "id": 1,
    "name": "Going Merry",
    "created_at": 1431596915,
    "updated_at": 1431596915
}
```
