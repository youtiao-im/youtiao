# Feed Stars

* [List](#list)
* [Get](#get)

## List

```
GET /feeds/:feed_id/stars
```

### Response

```json
[
    {
        "created_at": 1432103374,
        "updated_at": 1432103374,
        "user": {
            "id": "GDbvXq2O",
            "email": "zoro@straw-hat.org"
        }
    },
    {
        "created_at": 1432103374,
        "updated_at": 1432103374,
        "user": {
            "id": "XK8jOqaO",
            "email": "nami@straw-hat.org"
        }
    },
    {
        "created_at": 1432103374,
        "updated_at": 1432103374,
        "user": {
            "id": "Rj85oxAE",
            "email": "usopp@straw-hat.org"
        }
    },
    {
        "created_at": 1432103374,
        "updated_at": 1432103374,
        "user": {
            "id": "md8lOb92",
            "email": "sanji@straw-hat.org"
        }
    },
    {
        "created_at": 1432103374,
        "updated_at": 1432103374,
        "user": {
            "id": "Aeb6nb6o",
            "email": "chopper@straw-hat.org"
        }
    },
    {
        "created_at": 1432103374,
        "updated_at": 1432103374,
        "user": {
            "id": "yZbeZ8Jp",
            "email": "robin@straw-hat.org"
        }
    }
]
```

## Get

```
GET /feeds/:feed_id/stars/users/:user_id
```

### Response

```json
{
    "created_at": 1432103374,
    "updated_at": 1432103374,
    "user": {
        "id": "GDbvXq2O",
        "email": "zoro@straw-hat.org"
    }
}
```
