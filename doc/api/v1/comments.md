# Comments

* [List](#list)
* [Get](#get)
* [Create](#create)


## List

```
GET /bulletins/:bulletin_id/comments
```

### Response

```json
[
    {
        "type": "Comment",
        "id": "7293583a",
        "bulletin_id": "e52ad5a9",
        "text": "Hell yeah!",
        "created_by_type": "Membership",
        "created_by_id": "4e26a868",
        "created_at": "1434096763.962079",
        "updated_at": "1434096763.962079",
        "created_by": {
            "type": "Membership",
            "id": "4e26a868",
            "group_id": "8e2d94da",
            "user_id": "d5283a89",
            "role": "member",
            "alias": null,
            "created_at": "1434096763.687575",
            "updated_at": "1434096763.687575"
        }
    },
    ...
]
```


## Get

```
GET /comments/:id
```

### Response

```json
{
    "type": "Comment",
    "id": "7293583a",
    "bulletin_id": "e52ad5a9",
    "text": "Hell yeah!",
    "created_by_type": "Membership",
    "created_by_id": "4e26a868",
    "created_at": "1434096763.962079",
    "updated_at": "1434096763.962079",
    "created_by": {
        "type": "Membership",
        "id": "4e26a868",
        "group_id": "8e2d94da",
        "user_id": "d5283a89",
        "role": "member",
        "alias": null,
        "created_at": "1434096763.687575",
        "updated_at": "1434096763.687575"
    }
}
```


## Create

```
POST /bulletins/:bulletin_id/comments
```

### Parameters

| Name   | Type     | Description                            |
| ------ | -------- | -------------------------------------- |
| `text` | `string` | **Required**. The text of the comment. |

### Example

```json
{
    "text": "Hell yeah!"
}
```

### Response

```json
{
    "type": "Comment",
    "id": "7293583a",
    "bulletin_id": "e52ad5a9",
    "text": "Hell yeah!",
    "created_by_type": "Membership",
    "created_by_id": "4e26a868",
    "created_at": "1434096763.962079",
    "updated_at": "1434096763.962079",
    "created_by": {
        "type": "Membership",
        "id": "4e26a868",
        "group_id": "8e2d94da",
        "user_id": "d5283a89",
        "role": "member",
        "alias": null,
        "created_at": "1434096763.687575",
        "updated_at": "1434096763.687575"
    }
}
```
