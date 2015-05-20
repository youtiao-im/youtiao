# Comments

* [List](#list)
* [Get](#get)
* [Create](#create)

## List

```
GET /feeds/:feed_id/comments
```

### Response

```json
[
    {
        "id": "AxlAJnRG",
        "text": "Hell yeah!",
        "created_at": 1432101578,
        "updated_at": 1432101578,
        "created_by": {
            "id": "GDbvXq2O",
            "email": "zoro@straw-hat.org"
        }
    },
    {
        "id": "6V2rN2XO",
        "text": "Need a map?",
        "created_at": 1432101578,
        "updated_at": 1432101578,
        "created_by": {
            "id": "Rj85oxAE",
            "email": "usopp@straw-hat.org"
        }
    }
]
```

## Get

```
GET /comments/:comment_id
```

### Response

```json
{
    "id": "AxlAJnRG",
    "text": "Hell yeah!",
    "created_at": 1432101578,
    "updated_at": 1432101578,
    "created_by": {
        "id": "GDbvXq2O",
        "email": "zoro@straw-hat.org"
    }
}
```

## Create

```
POST /feeds/:feed_id/comments
```

### Parameters

| Name     | Type       | Description                            |
| -------- | ---------- | -------------------------------------- |
| `text`   | `string`   | **Required**. The text of the comment. |

### Example

```json
{
    "text": "Hell yeah!"
}
```

### Response

```json
{
    "id": "AxlAJnRG",
    "text": "Hell yeah!",
    "created_at": 1432101578,
    "updated_at": 1432101578,
    "created_by": {
        "id": "GDbvXq2O",
        "email": "zoro@straw-hat.org"
    }
}
```
