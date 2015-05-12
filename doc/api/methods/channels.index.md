# channels.index

## URL

`GET https://api.youtiao.im/v1/channels`

## Arguments

| Argument   | Example | Required | Description                 |
| ---------- | ------- | -------- | --------------------------- |
| `per_page` | `25`    | Optional | Number of channels per page |
| `page`     | `1`     | Optional | Page number                 |

## Response

```json
[
    {
        "id": "GPyYROY7",
        "name": "Going Merry",
        "created_at": 1431349817,
        "updated_at": 1431349817,
        "creator_id": "WM8Xnx7Q",
        "owner_ids": [
            "WM8Xnx7Q"
        ],
        "admin_ids": [],
        "member_ids": [
            "GDbvXq2O",
            "XK8jOqaO",
            "Rj85oxAE",
            "md8lOb92",
            "Aeb6nb6o",
            "yZbeZ8Jp"
        ],
        "is_owner": true,
        "is_admin": false,
        "is_member": false
    },
    {
        "id": "W3JBpyjd",
        "name": "Thousand Sunny",
        "created_at": 1431349817,
        "updated_at": 1431349817,
        "creator_id": "WM8Xnx7Q",
        "owner_ids": [
            "WM8Xnx7Q"
        ],
        "admin_ids": [],
        "member_ids": [
            "GDbvXq2O",
            "XK8jOqaO",
            "Rj85oxAE",
            "md8lOb92",
            "Aeb6nb6o",
            "yZbeZ8Jp",
            "L6qJoxNO",
            "BPboWbnW"
        ],
        "is_owner": true,
        "is_admin": false,
        "is_member": false
    }
]
```

## Errors

**TODO:**
