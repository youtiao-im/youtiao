# Channel Feeds

* [List](list)
* [Get](get)
* [Create](create)

## List

```
GET /channels/:channel_id/feeds
```

### Response

```json
[
    {
        "id": 1,
        "text": "Advanture begins!",
        "created_at": 1431596915,
        "updated_at": 1431596915
    },
    {
        "id": 2,
        "text": "Do we need a musician on board?",
        "created_at": 1431596915,
        "updated_at": 1431596915
    }
]
```

## Get

```
GET /feeds/:feed_id
```

### Response

```json
{
    "id": 1,
    "text": "Advanture begins!",
    "created_at": 1431596915,
    "updated_at": 1431596915
}
```

## Create

```
POST /channels/:channel_id/feeds
```

### Parameters

| Name     | Type       | Description                         |
| -------- | ---------- | ----------------------------------- |
| `text`   | `string`   | **Required**. The text of the feed. |

### Example

```json
{
    "text": "Advanture begins!"
}
```

### Response

```json
{
    "id": 1,
    "text": "Advanture begins!",
    "created_at": 1431596915,
    "updated_at": 1431596915
}
```
