# feeds.index

## URL

`GET https://api.youtiao.im/v1/channels/:channel_id/feeds`

## Arguments

| Argument     | Example    | Required | Description              |
| ------------ | ---------- | -------- | ------------------------ |
| `channel_id` | `GPyYROY7` | Required | Channel id               |
| `per_page`   | `25`       | Optional | Number of feeds per page |
| `page`       | `1`        | Optional | Page number              |

## Response

```json
[
    {
        "id": "YjM4QRwb",
        "channel_id": "GPyYROY7",
        "text": "Advanture begins!",
        "created_at": 1431349817,
        "updated_at": 1431349817,
        "creator_id": "WM8Xnx7Q",
        "checked_by_ids": [
            "GDbvXq2O",
            "XK8jOqaO",
            "Rj85oxAE",
            "md8lOb92"
        ],
        "crossed_by_ids": [],
        "questioned_by_ids": [],
        "is_checked": false,
        "is_crossed": false,
        "is_questioned": false,
        "attachments": []
    },
    {
        "id": "DxrAPRBZ",
        "channel_id": "GPyYROY7",
        "text": "Do we need a musician on board?",
        "created_at": 1431349817,
        "updated_at": 1431349817,
        "creator_id": "WM8Xnx7Q",
        "checked_by_ids": [
            "XK8jOqaO",
            "md8lOb92",
            "yZbeZ8Jp"
        ],
        "crossed_by_ids": [
            "GDbvXq2O"
        ],
        "questioned_by_ids": [
            "Rj85oxAE",
            "Aeb6nb6o"
        ],
        "is_checked": false,
        "is_crossed": false,
        "is_questioned": false,
        "attachments": []
    }
]
```

## Errors

**TODO:**
