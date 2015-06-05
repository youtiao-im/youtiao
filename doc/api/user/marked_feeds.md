# Your Marked Feeds

* [List](#list)
* [Get](#get)
* [Create or update](#create-or-update)

## List

```
GET /user/marked_feeds
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
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "channel": {
            "id": "GPyYROY7",
            "name": "Going Merry",
            "memberships_count": 7,
            "created_at": 1433483148,
            "updated_at": 1433483148
        },
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        },
        "mark": {
            "symbol": "check",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    },
    {
        "id": "DxrAPRBZ",
        "text": "Do we need a musician on board?",
        "checks_count": 3,
        "crosses_count": 3,
        "comments_count": 1,
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "channel": {
            "id": "GPyYROY7",
            "name": "Going Merry",
            "memberships_count": 7,
            "created_at": 1433483148,
            "updated_at": 1433483148
        },
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        },
        "mark": {
            "symbol": "cross",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    },
    {
        "id": "lYMBoRda",
        "text": "3D2Y",
        "checks_count": 8,
        "crosses_count": 0,
        "comments_count": 0,
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "channel": {
            "id": "W3JBpyjd",
            "name": "Thousand Sunny",
            "memberships_count": 9,
            "created_at": 1433483148,
            "updated_at": 1433483148
        },
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        },
        "mark": {
            "symbol": "check",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    }
]
```

## Get

```
GET /user/marked_feeds/:feed_id
```

### Response

```json
{
    "id": "YjM4QRwb",
    "text": "Advanture begins!",
    "checks_count": 4,
    "crosses_count": 0,
    "comments_count": 2,
    "created_at": 1433483148,
    "updated_at": 1433483148,
    "channel": {
        "id": "GPyYROY7",
        "name": "Going Merry",
        "memberships_count": 7,
        "created_at": 1433483148,
        "updated_at": 1433483148
    },
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433483148,
        "updated_at": 1433483148
    },
    "mark": {
        "symbol": "check",
        "created_at": 1433483148,
        "updated_at": 1433483148
    }
}
```

## Create or update

```
PUT /user/marked_feeds/:feed_id
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
    "created_at": 1433483148,
    "updated_at": 1433483148,
    "channel": {
        "id": "GPyYROY7",
        "name": "Going Merry",
        "memberships_count": 7,
        "created_at": 1433483148,
        "updated_at": 1433483148
    },
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433483148,
        "updated_at": 1433483148
    },
    "mark": {
        "symbol": "check",
        "created_at": 1433483148,
        "updated_at": 1433483148
    }
}
```
