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
