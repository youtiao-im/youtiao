# Feeds

* [List](#list)
* [Get](#get)
* [Create](#create)

## List

```
GET /channels/:channel_id/feeds
```

### Response

```json
[
    {
        "id": "YjM4QRwb",
        "text": "Advanture begins!",
        "checks_count": 4,
        "crosses_count": 0,
        "comments_count": 2,
        "created_at": 1433420476,
        "updated_at": 1433420476,
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org",
            "created_at": 1433420475,
            "updated_at": 1433420475
        },
        "mark": {
            "symbol": "check",
            "created_at": 1433420476,
            "updated_at": 1433420476
        }
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
    "id": "YjM4QRwb",
    "text": "Advanture begins!",
    "checks_count": 4,
    "crosses_count": 0,
    "comments_count": 2,
    "created_at": 1433420476,
    "updated_at": 1433420476,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433420475,
        "updated_at": 1433420475
    },
    "mark": {
        "symbol": "check",
        "created_at": 1433420476,
        "updated_at": 1433420476
    }
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
    "id": "YjM4QRwb",
    "text": "Advanture begins!",
    "checks_count": 0,
    "crosses_count": 0,
    "comments_count": 0,
    "created_at": 1433420476,
    "updated_at": 1433420476,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433420475,
        "updated_at": 1433420475
    }
}
```
