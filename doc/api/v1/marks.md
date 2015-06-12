# Marks

* [List](#list)
* [Get](#get)


## List

```
GET /bulletins/:bulletin_id/marks
```

### Response

```json
[
    {
        "type": "Mark",
        "id": "a7926392",
        "bulletin_id": "3d4a93a6",
        "symbol": "check",
        "created_by_type": "Membership",
        "created_by_id": "7d86476e",
        "created_at": "1434096763.896191",
        "updated_at": "1434096763.896191",
        "created_by": {
            "type": "Membership",
            "id": "7d86476e",
            "group_id": "ea6d69d2",
            "user_id": "d5283a89",
            "role": "member",
            "alias": null,
            "created_at": "1434096763.739882",
            "updated_at": "1434096763.739882"
        }
    },
    ...
]
```
