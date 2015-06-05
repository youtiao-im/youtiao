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
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "user": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    },
    {
        "role": "member",
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "user": {
            "id": "GDbvXq2O",
            "email": "zoro@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    },
    {
        "role": "member",
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "user": {
            "id": "XK8jOqaO",
            "email": "nami@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    },
    {
        "role": "member",
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "user": {
            "id": "Rj85oxAE",
            "email": "usopp@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    },
    {
        "role": "member",
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "user": {
            "id": "md8lOb92",
            "email": "sanji@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    },
    {
        "role": "member",
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "user": {
            "id": "Aeb6nb6o",
            "email": "chopper@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
        }
    },
    {
        "role": "member",
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "user": {
            "id": "yZbeZ8Jp",
            "email": "robin@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
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
    "created_at": 1433483148,
    "updated_at": 1433483148,
    "user": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433483148,
        "updated_at": 1433483148
    }
}
```
