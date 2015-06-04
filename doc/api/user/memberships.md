# Your Memberships

* [List joined channels](#list-joined-channel)
* [Get a joined channel](#get-a-joined-channel)
* [Join a channel](#join-a-channel)

## List joined channels

```
GET /user/memberships/channels
```

### Response

```json
[
    {
        "id": "GPyYROY7",
        "name": "Going Merry",
        "memberships_count": 7,
        "created_at": 1433420475,
        "updated_at": 1433420475,
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org",
            "created_at": 1433420475,
            "updated_at": 1433420475
        },
        "membership": {
            "role": "member",
            "created_at": 1433420475,
            "updated_at": 1433420475
        }
    }
]
```

## Get a joined channel

```
GET /user/memberships/channels/:channel_id
```

### Response

```json
{
    "id": "GPyYROY7",
    "name": "Going Merry",
    "memberships_count": 7,
    "created_at": 1433420475,
    "updated_at": 1433420475,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433420475,
        "updated_at": 1433420475
    },
    "membership": {
        "role": "member",
        "created_at": 1433420475,
        "updated_at": 1433420475
    }
}
```

## Join a channel

```
POST /user/memberships/channels/:channel_id
```

### Response

```json
{
    "id": "GPyYROY7",
    "name": "Going Merry",
    "memberships_count": 7,
    "created_at": 1433420475,
    "updated_at": 1433420475,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433420475,
        "updated_at": 1433420475
    },
    "membership": {
        "role": "member",
        "created_at": 1433420475,
        "updated_at": 1433420475
    }
}
```
