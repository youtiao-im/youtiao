# Stamps

* [List](#list)
* [Get](#get)


## List

```
GET /bulletins/:bulletin_id/stamps
```

The returned stamps will be sorted in the reverse order they get created.

### Parameters

| Name        | Type      | Description |
| ----------- | --------- | ----------- |
| `before_id` | `string`  | **Optional**. Returns stamps created before the specified stamp. |
| `limit`     | `integer` | **Optional**. The number of stamps to retrieve. Default to 25, max to 500. |

### Response

```json
[
    {
        "type": "Stamp",
        "id": "7d567952",
        "bulletin_id": "3d4a93a6",
        "symbol": "check",
        "created_by_id": "de58e284",
        "created_at": "1435209376.498585",
        "updated_at": "1435209376.498585",
        "created_by": {
            "type": "User",
            "id": "de58e284",
            "email": "luffy@straw-hat.org",
            "name": "luffy",
            "avatar_id": null,
            "avatar": null,
            "created_at": "1435209292.265453",
            "updated_at": "1435209292.265453"
        }
    },
    ...
]
```
