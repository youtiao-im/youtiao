# Feed Marks

* [List](#list)
* [Get](#get)

## List

```
GET /feeds/:feed_id/marks
```

### Response

```json
[
    {
        "symbol": "check",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "GDbvXq2O",
            "email": "zoro@straw-hat.org"
        }
    },
    {
        "symbol": "check",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "XK8jOqaO",
            "email": "nami@straw-hat.org"
        }
    },
    {
        "symbol": "check",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "Rj85oxAE",
            "email": "usopp@straw-hat.org"
        }
    },
    {
        "symbol": "check",
        "created_at": 1432100855,
        "updated_at": 1432100855,
        "user": {
            "id": "md8lOb92",
            "email": "sanji@straw-hat.org"
        }
    }
]
```

## Get

```
GET /feeds/:feed_id/marks/users/:user_id
```

### Response

```json
{
    "symbol": "check",
    "created_at": 1432100855,
    "updated_at": 1432100855,
    "user": {
        "id": "GDbvXq2O",
        "email": "zoro@straw-hat.org"
    }
}
```
