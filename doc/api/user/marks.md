# Your Marks

* [List](list)
* [Get](get)
* [Create](create)
* [Update](update)

## List

```
GET /user/marks
```

### Response

```json
[
    {
        "symbol": "check",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "feed_id": 1
    },
    {
        "symbol": "cross",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "feed_id": 2
    },
    {
        "symbol": "check",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "feed_id": 3
    }
]
```

## Get

```
GET /user/marks/feeds/:feed_id
```

### Response

```json
{
    "symbol": "check",
    "created_at": 1431596915,
    "updated_at": 1431596915,
    "feed_id": 1
}
```

## Create

```
PUT /user/marks/feeds/:feed_id
```

### Parameters

| Name     | Type       | Description                           |
| -------- | ---------- | ------------------------------------- |
| `symbol` | `string`   | **Required**. The symbol of the mark. |

### Response

```json
{
    "symbol": "check",
    "created_at": 1431596915,
    "updated_at": 1431596915,
    "feed_id": 1
}
```

## Update

```
PATCH /user/marks/feeds/:feed_id
```

### Parameters

| Name     | Type       | Description                           |
| -------- | ---------- | ------------------------------------- |
| `symbol` | `string`   | **Required**. The symbol of the mark. |

### Example

```json
{
    "symbol": "cross"
}
```

### Response

```json
{
    "symbol": "cross",
    "created_at": 1431596915,
    "updated_at": 1431596915,
    "feed_id": 1
}
```
