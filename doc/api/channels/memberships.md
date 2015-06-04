# Channel Memberships

* [List](#list)
* [Get](#get)

## List

```
GET /channels/:channel_id/memberships
```

### Response

```json
[
    {
        "role": "owner",
        "created_at": 1433420475,
        "updated_at": 1433420475,
        "user": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org",
            "created_at": 1433420475,
            "updated_at": 1433420475
        }
    },
    {
        "role": "member",
        "created_at": 1433420475,
        "updated_at": 1433420475,
        "user": {
            "id": "GDbvXq2O",
            "email": "zoro@straw-hat.org",
            "created_at": 1433420475,
            "updated_at": 1433420475
        }
    },
    {
        "role": "member",
        "created_at": 1433420475,
        "updated_at": 1433420475,
        "user": {
            "id": "XK8jOqaO",
            "email": "nami@straw-hat.org",
            "created_at": 1433420475,
            "updated_at": 1433420475
        }
    }
]
```

## Get

```
GET /channels/:channel_id/memberships/users/:user_id
```

### Response

```json
{
    "role": "owner",
    "created_at": 1433420475,
    "updated_at": 1433420475,
    "user": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433420475,
        "updated_at": 1433420475
    }
}
```
