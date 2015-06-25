# Comments

* [List](#list)
* [Get](#get)
* [Create](#create)


## List

```
GET /bulletins/:bulletin_id/comments
```

The returned comments will be sorted in the reverse order they get created.

### Parameters

| Name        | Type      | Description |
| ----------- | --------- | ----------- |
| `before_id` | `string`  | **Optional**. Returns comments created before the specified comment. |
| `limit`     | `integer` | **Optional**. The number of comments to retrieve. Default to 25, max to 500. |

### Response

```json
[
    {
        "type": "Comment",
        "id": "d423863e",
        "bulletin_id": "e52ad5a9",
        "text": "Need a map?",
        "created_by_id": "43a82582",
        "created_at": "1435209293.27758",
        "updated_at": "1435209293.27758",
        "created_by": {
            "type": "User",
            "id": "43a82582",
            "email": "usopp@straw-hat.org",
            "name": "usopp",
            "avatar_id": null,
            "avatar": null,
            "created_at": "1435209292.448469",
            "updated_at": "1435209292.448469"
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
    "id": "d423863e",
    "bulletin_id": "e52ad5a9",
    "text": "Need a map?",
    "created_by_id": "43a82582",
    "created_at": "1435209293.27758",
    "updated_at": "1435209293.27758",
    "created_by": {
        "type": "User",
        "id": "43a82582",
        "email": "usopp@straw-hat.org",
        "name": "usopp",
        "avatar_id": null,
        "avatar": null,
        "created_at": "1435209292.448469",
        "updated_at": "1435209292.448469"
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
    "text": "Need a map?"
}
```

### Response

```json
{
    "type": "Comment",
    "id": "d423863e",
    "bulletin_id": "e52ad5a9",
    "text": "Need a map?",
    "created_by_id": "43a82582",
    "created_at": "1435209293.27758",
    "updated_at": "1435209293.27758",
    "created_by": {
        "type": "User",
        "id": "43a82582",
        "email": "usopp@straw-hat.org",
        "name": "usopp",
        "avatar_id": null,
        "avatar": null,
        "created_at": "1435209292.448469",
        "updated_at": "1435209292.448469"
    }
}
```
