# Your Marks

* [List](#list)
* [Get](#get)
* [Create](#create)

## List

```
GET /user/stars
```

### Response

```json
[
    {
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
GET /user/stars/feeds/:feed_id
```

### Response

```json
{
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

### Response

```json
{
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
