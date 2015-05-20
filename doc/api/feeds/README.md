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
        "questions_count": 0,
        "comments_count": 2,
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org"
        }
    },
    {
        "id": "DxrAPRBZ",
        "text": "Do we need a musician on board?",
        "checks_count": 3,
        "crosses_count": 1,
        "questions_count": 2,
        "comments_count": 1,
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org"
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
    "questions_count": 0,
    "comments_count": 2,
    "created_at": 1432100855,
    "updated_at": 1432100855,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org"
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
    "questions_count": 0,
    "comments_count": 0,
    "created_at": 1432100855,
    "updated_at": 1432100855,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org"
    }
}
```
