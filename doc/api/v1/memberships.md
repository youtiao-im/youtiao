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
        "id": "3246856d",
        "group_id": "8e2d94da",
        "user_id": "d658b98a",
        "role": "member",
        "created_at": "1435209293.0905359",
        "updated_at": "1435209293.0905359",
        "user": {
            "type": "User",
            "id": "d658b98a",
            "email": "robin@straw-hat.org",
            "name": "robin",
            "avatar_id": null,
            "avatar": null,
            "created_at": "1435209292.628777",
            "updated_at": "1435209292.628777"
        }
    },
    ...
]
```
