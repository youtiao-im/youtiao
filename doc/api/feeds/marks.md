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
        "created_at": 1433420476,
        "updated_at": 1433420476,
        "user": {
            "id": "GDbvXq2O",
            "email": "zoro@straw-hat.org",
            "created_at": 1433420475,
            "updated_at": 1433420475
        }
    },
    {
        "symbol": "check",
        "created_at": 1433420476,
        "updated_at": 1433420476,
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
GET /feeds/:feed_id/marks/users/:user_id
```

### Response

```json
{
    "symbol": "check",
    "created_at": 1433420476,
    "updated_at": 1433420476,
    "user": {
        "id": "GDbvXq2O",
        "email": "zoro@straw-hat.org",
        "created_at": 1433420475,
        "updated_at": 1433420475
    }
}
```
