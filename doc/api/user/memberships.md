# Your Memberships

* [List](#list)
* [Get](#get)
* [Create](#create)

## List

```
GET /user/memberships
```

### Response

```json
[
    {
        "role": "owner",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "channel": {
            "id": "GPyYROY7",
            "name": "Going Merry",
            "memberships_count": 7,
            "created_at": 1432100855,
            "updated_at": 1432100855,
            "created_by": {
                "id": "WM8Xnx7Q",
                "email": "luffy@straw-hat.org"
            }
        }
    },
    {
        "role": "owner",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "channel": {
            "id": "W3JBpyjd",
            "name": "Thousand Sunny",
            "memberships_count": 9,
            "created_at": 1432100855,
            "updated_at": 1432100855,
            "created_by": {
                "id": "WM8Xnx7Q",
                "email": "luffy@straw-hat.org"
            }
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
    "role": "owner",
    "created_at": 1432100855,
    "updated_at": 1432100855,
    "channel": {
        "id": "GPyYROY7",
        "name": "Going Merry",
        "memberships_count": 7,
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org"
        }
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
    "role": "member",
    "created_at": 1432100855,
    "updated_at": 1432100855,
    "channel": {
        "id": "GPyYROY7",
        "name": "Going Merry",
        "memberships_count": 7,
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org"
        }
    }
}
```
