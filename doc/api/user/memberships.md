# Your Memberships

* [List](#list)
* [Get](#get)
* [Create](#create)

## List

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

## Get

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

## Create

```
PUT /user/memberships/channels/:channel_id
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
