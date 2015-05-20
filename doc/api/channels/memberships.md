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
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org"
        }
    },
    {
        "role": "member",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "GDbvXq2O",
            "email": "zoro@straw-hat.org"
        }
    },
    {
        "role": "member",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "XK8jOqaO",
            "email": "nami@straw-hat.org"
        }
    },
    {
        "role": "member",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "Rj85oxAE",
            "email": "usopp@straw-hat.org"
        }
    },
    {
        "role": "member",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "md8lOb92",
            "email": "sanji@straw-hat.org"
        }
    },
    {
        "role": "member",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "Aeb6nb6o",
            "email": "chopper@straw-hat.org"
        }
    },
    {
        "role": "member",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "yZbeZ8Jp",
            "email": "robin@straw-hat.org"
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
    "created_at": 1432100855,
    "updated_at": 1432100855,
    "user": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org"
    }
}
```
