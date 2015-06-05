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
        "symbol": "check",
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
        "symbol": "check",
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
        "symbol": "check",
        "created_at": 1433483148,
        "updated_at": 1433483148,
        "user": {
            "id": "md8lOb92",
            "email": "sanji@straw-hat.org",
            "created_at": 1433483148,
            "updated_at": 1433483148
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
    "created_at": 1433483148,
    "updated_at": 1433483148,
    "user": {
        "id": "GDbvXq2O",
        "email": "zoro@straw-hat.org",
        "created_at": 1433483148,
        "updated_at": 1433483148
    }
}
```
