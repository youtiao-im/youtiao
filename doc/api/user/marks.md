# Your Marks

* [List marked feeds](#list-marked-feeds)
* [Get a marked feed](#get-a-marked-feed)
* [Mark a feed](#mark-a-feed)

## List marked feeds

```
GET /user/marks/feeds
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
        "channel": {
            "id": "GPyYROY7",
            "name": "Going Merry",
            "memberships_count": 7,
            "created_at": 1433420475,
            "updated_at": 1433420475
        },
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

## Get a marked feed

```
GET /user/marks/feeds/:feed_id
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
    "channel": {
        "id": "GPyYROY7",
        "name": "Going Merry",
        "memberships_count": 7,
        "created_at": 1433420475,
        "updated_at": 1433420475
    },
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

## Mark a feed

```
PUT /user/marks/feeds/:feed_id
```

### Parameters

| Name     | Type       | Description                           |
| -------- | ---------- | ------------------------------------- |
| `symbol` | `string`   | **Required**. The symbol of the mark. |

### Example

```json
{
    "symbol": "check"
}
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
    "channel": {
        "id": "GPyYROY7",
        "name": "Going Merry",
        "memberships_count": 7,
        "created_at": 1433420475,
        "updated_at": 1433420475
    },
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
