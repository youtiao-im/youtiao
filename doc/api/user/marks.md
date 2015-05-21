# Your Marks

* [List](#list)
* [Get](#get)
* [Create](#create)
* [Update](#update)

## List

```
GET /user/marks
```

### Response

```json
[
    {
        "symbol": "check",
        "created_at": 1432105686,
        "updated_at": 1432105686,
        "feed": {
            "id": "YjM4QRwb",
            "text": "Advanture begins!",
            "checks_count": 4,
            "crosses_count": 0,
            "questions_count": 0,
            "comments_count": 2,
            "created_at": 1432105686,
            "updated_at": 1432105686,
            "mark": {
                "symbol": "check",
                "created_at": 1432105686,
                "updated_at": 1432105686
            },
            "star": {
                "created_at": 1432105686,
                "updated_at": 1432105686
            },
            "created_by": {
                "id": "WM8Xnx7Q",
                "email": "luffy@straw-hat.org"
            }
        }
    },
    {
        "symbol": "cross",
        "created_at": 1432105686,
        "updated_at": 1432105686,
        "feed": {
            "id": "DxrAPRBZ",
            "text": "Do we need a musician on board?",
            "checks_count": 3,
            "crosses_count": 1,
            "questions_count": 2,
            "comments_count": 1,
            "created_at": 1432105686,
            "updated_at": 1432105686,
            "mark": {
                "symbol": "cross",
                "created_at": 1432105686,
                "updated_at": 1432105686
            },
            "created_by": {
                "id": "WM8Xnx7Q",
                "email": "luffy@straw-hat.org"
            }
        }
    },
    {
        "symbol": "check",
        "created_at": 1432105686,
        "updated_at": 1432105686,
        "feed": {
            "id": "lYMBoRda",
            "text": "3D2Y",
            "checks_count": 8,
            "crosses_count": 0,
            "questions_count": 0,
            "comments_count": 0,
            "created_at": 1432105686,
            "updated_at": 1432105686,
            "mark": {
                "symbol": "check",
                "created_at": 1432105686,
                "updated_at": 1432105686
            },
            "star": {
                "created_at": 1432105686,
                "updated_at": 1432105686
            },
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
GET /user/marks/feeds/:feed_id
```

### Response

```json
{
    "symbol": "check",
    "created_at": 1432105686,
    "updated_at": 1432105686,
    "feed": {
        "id": "YjM4QRwb",
        "text": "Advanture begins!",
        "checks_count": 4,
        "crosses_count": 0,
        "questions_count": 0,
        "comments_count": 2,
        "created_at": 1432105686,
        "updated_at": 1432105686,
        "mark": {
            "symbol": "check",
            "created_at": 1432105686,
            "updated_at": 1432105686
        },
        "star": {
            "created_at": 1432105686,
            "updated_at": 1432105686
        },
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org"
        }
    }
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

### Example

```json
{
    "symbol": "check"
}
```

### Response

```json
{
    "symbol": "check",
    "created_at": 1432105686,
    "updated_at": 1432105686,
    "feed": {
        "id": "YjM4QRwb",
        "text": "Advanture begins!",
        "checks_count": 4,
        "crosses_count": 0,
        "questions_count": 0,
        "comments_count": 2,
        "created_at": 1432105686,
        "updated_at": 1432105686,
        "mark": {
            "symbol": "check",
            "created_at": 1432105686,
            "updated_at": 1432105686
        },
        "star": {
            "created_at": 1432105686,
            "updated_at": 1432105686
        },
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org"
        }
    }
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
    "created_at": 1432105686,
    "updated_at": 1432105686,
    "feed": {
        "id": "YjM4QRwb",
        "text": "Advanture begins!",
        "checks_count": 4,
        "crosses_count": 0,
        "questions_count": 0,
        "comments_count": 2,
        "created_at": 1432105686,
        "updated_at": 1432105686,
        "mark": {
            "symbol": "cross",
            "created_at": 1432105686,
            "updated_at": 1432105686
        },
        "star": {
            "created_at": 1432105686,
            "updated_at": 1432105686
        },
        "created_by": {
            "id": "WM8Xnx7Q",
            "email": "luffy@straw-hat.org"
        }
    }
}
```
