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
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 2
    },
    {
        "symbol": "check",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 3
    },
    {
        "symbol": "check",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 4
    },
    {
        "symbol": "check",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 5
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
    "created_at": 1431596915,
    "updated_at": 1431596915,
    "user_id": 2
}
```
