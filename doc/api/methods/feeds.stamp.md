# feeds.show

## URL

`POST https://api.youtiao.im/v1/channels/:channel_id/feeds/:id/stamp`

## Arguments

| Argument     | Example    | Required | Description |
| ------------ | ---------- | -------- | ----------- |
| `channel_id` | `W3JBpyjd` | Required | Channel id  |
| `id`         | `lYMBoRda` | Required | Feed id     |
| `kind`       | `check`    | Required | Stamp kind  |

## Response

```json
{
    "id": "lYMBoRda",
    "channel_id": "W3JBpyjd",
    "text": "3D2Y",
    "created_at": 1431349817,
    "updated_at": 1431349817,
    "creator_id": "GDbvXq2O",
    "checked_by_ids": [
        "GDbvXq2O",
        "XK8jOqaO",
        "Rj85oxAE",
        "md8lOb92",
        "Aeb6nb6o",
        "yZbeZ8Jp",
        "L6qJoxNO",
        "BPboWbnW"
    ],
    "crossed_by_ids": [],
    "questioned_by_ids": [],
    "is_checked": true,
    "is_crossed": false,
    "is_questioned": false,
    "attachments": []
}
```

## Errors

**TODO:**
