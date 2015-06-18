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
        "id": "6d75875e",
        "bulletin_id": "e52ad5a9",
        "symbol": "check",
        "created_by_id": "2de8da87",
        "created_at": "1434633474.912439",
        "updated_at": "1434633474.912439",
        "created_by": {
            "type": "User",
            "id": "2de8da87",
            "email": "sanji@straw-hat.org",
            "name": "sanji",
            "avatar_id": null,
            "created_at": "1434633474.516248",
            "updated_at": "1434633474.516248"
        }
    },
    ...
]
```
