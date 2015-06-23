# Comments

* [List](#list)
* [Get](#get)
* [Create](#create)


## List

```
GET /bulletins/:bulletin_id/comments
```

The returned comments will be sorted in the order they get created.

### Parameters

| Name       | Type      | Description |
| ---------- | --------- | ----------- |
| `after_id` | `string`  | **Optional**. Returns comments created after the specified comment. |
| `limit`    | `integer` | **Optional**. The number of comments to retrieve. Default to 25, max to 500. |

### Response

```json
[
    {
        "type": "Comment",
        "id": "7293583a",
        "bulletin_id": "e52ad5a9",
        "text": "Hell yeah!",
        "created_by_id": "d5283a89",
        "created_at": "1434633475.0101671",
        "updated_at": "1434633475.0101671",
        "created_by": {
            "type": "User",
            "id": "d5283a89",
            "email": "zoro@straw-hat.org",
            "name": "zoro",
            "avatar_id": null,
            "created_at": "1434633474.332154",
            "updated_at": "1434633474.332154"
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
    "created_by_id": "d5283a89",
    "created_at": "1434633475.0101671",
    "updated_at": "1434633475.0101671",
    "created_by": {
        "type": "User",
        "id": "d5283a89",
        "email": "zoro@straw-hat.org",
        "name": "zoro",
        "avatar_id": null,
        "created_at": "1434633474.332154",
        "updated_at": "1434633474.332154"
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
    "created_by_id": "d5283a89",
    "created_at": "1434633475.0101671",
    "updated_at": "1434633475.0101671",
    "created_by": {
        "type": "User",
        "id": "d5283a89",
        "email": "zoro@straw-hat.org",
        "name": "zoro",
        "avatar_id": null,
        "created_at": "1434633474.332154",
        "updated_at": "1434633474.332154"
    }
}
```
