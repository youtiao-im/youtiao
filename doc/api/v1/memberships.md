# Memberships

* [List](#list)


## List

```
GET /groups/:group_id/memberships
```

The returned memberships will be sorted in the reverse order they get created.

### Parameters

| Name        | Type      | Description |
| ----------- | --------- | ----------- |
| `before_id` | `string`  | **Optional**. Returns memberships created before the specified membership. |
| `limit`     | `integer` | **Optional**. The number of memberships to retrieve. Default to 25, max to 500. |

### Response

```json
[
    {
        "type": "Membership",
        "id": "ed767a69",
        "group_id": "8e2d94da",
        "user_id": "de58e284",
        "role": "owner",
        "alias": null,
        "created_at": "1434096763.6591308",
        "updated_at": "1434096763.6591308",
        "user": {
            "type": "User",
            "id": "de58e284",
            "email": "luffy@straw-hat.org",
            "created_at": "1434096763.077031",
            "updated_at": "1434096763.077031"
        }
    },
    ...
]
```
