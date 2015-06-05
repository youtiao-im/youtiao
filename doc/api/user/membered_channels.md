# Your Membered Channels

* [List](#list)
* [Get](#get)
* [Create](#create)

## List

```
GET /user/membered_channels
```

### Response

```json
[
    {
        "id": "GPyYROY7",
        "name": "Going Merry",
        "memberships_count": 7,
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        },
        "membership": {
            "role": "member",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    },
    {
        "id": "W3JBpyjd",
        "name": "Thousand Sunny",
        "memberships_count": 9,
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        },
        "membership": {
            "role": "member",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    }
]
```

## Get

```
GET /user/membered_channels/:channel_id
```

### Response

```json
{
    "id": "GPyYROY7",
    "name": "Going Merry",
    "memberships_count": 7,
    "created_at": 1433483148,
    "updated_at": 1433483148,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433483148,
        "updated_at": 1433483148
    },
    "membership": {
        "role": "member",
        "created_at": 1433483148,
        "updated_at": 1433483148
    }
}
```

## Create

```
PUT /user/membered_channels/:channel_id
```

### Response

```json
{
    "id": "GPyYROY7",
    "name": "Going Merry",
    "memberships_count": 7,
    "created_at": 1433483148,
    "updated_at": 1433483148,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433483148,
        "updated_at": 1433483148
    },
    "membership": {
        "role": "member",
        "created_at": 1433483148,
        "updated_at": 1433483148
    }
}
```
