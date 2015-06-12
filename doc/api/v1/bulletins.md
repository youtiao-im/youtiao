# Bulletins

* [List](#list)
* [Get](#get)
* [Create](#create)
* [Stamp](#stamp)


## List

```
GET /bulletins
```

### Response

```json
[
    {
        "type": "Bulletin",
        "id": "3d4a93a6",
        "group_id": "ea6d69d2",
        "text": "3D2Y",
        "created_by_id": "b4e69a67",
        "created_by_type": "Membership",
        "checks_count": 8,
        "crosses_count": 0,
        "comments_count": 0,
        "created_at": "1434096763.816247",
        "updated_at": "1434096763.816247",
        "group": {
            "type": "Group",
            "id": "ea6d69d2",
            "name": "Thousand Sunny",
            "memberships_count": 9,
            "created_at": "1434096763.6460018",
            "updated_at": "1434096763.6460018"
        },
        "created_by": {
            "type": "Membership",
            "id": "b4e69a67",
            "group_id": "ea6d69d2",
            "user_id": "de58e284",
            "role": "owner",
            "alias": null,
            "created_at": "1434096763.729186",
            "updated_at": "1434096763.729186"
        }
    },
    ...
]
```


## Get

```
GET /bulletins/:id
```

### Response

```json
{
    "type": "Bulletin",
    "id": "3d4a93a6",
    "group_id": "ea6d69d2",
    "text": "3D2Y",
    "created_by_id": "b4e69a67",
    "created_by_type": "Membership",
    "checks_count": 8,
    "crosses_count": 0,
    "comments_count": 0,
    "created_at": "1434096763.816247",
    "updated_at": "1434096763.816247",
    "group": {
        "type": "Group",
        "id": "ea6d69d2",
        "name": "Thousand Sunny",
        "memberships_count": 9,
        "created_at": "1434096763.6460018",
        "updated_at": "1434096763.6460018"
    },
    "created_by": {
        "type": "Membership",
        "id": "b4e69a67",
        "group_id": "ea6d69d2",
        "user_id": "de58e284",
        "role": "owner",
        "alias": null,
        "created_at": "1434096763.729186",
        "updated_at": "1434096763.729186"
    }
}
```


## Create

```
POST /groups/:group_id/bulletins
```

### Parameters

| Name   | Type     | Description                             |
| ------ | -------- | --------------------------------------- |
| `text` | `string` | **Required**. The text of the bulletin. |

### Example

```json
{
    "text": "3D2Y"
}
```

### Response

```json
{
    "type": "Bulletin",
    "id": "3d4a93a6",
    "group_id": "ea6d69d2",
    "text": "3D2Y",
    "created_by_id": "b4e69a67",
    "created_by_type": "Membership",
    "checks_count": 0,
    "crosses_count": 0,
    "comments_count": 0,
    "created_at": "1434096763.816247",
    "updated_at": "1434096763.816247",
    "group": {
        "type": "Group",
        "id": "ea6d69d2",
        "name": "Thousand Sunny",
        "memberships_count": 9,
        "created_at": "1434096763.6460018",
        "updated_at": "1434096763.6460018"
    },
    "created_by": {
        "type": "Membership",
        "id": "b4e69a67",
        "group_id": "ea6d69d2",
        "user_id": "de58e284",
        "role": "owner",
        "alias": null,
        "created_at": "1434096763.729186",
        "updated_at": "1434096763.729186"
    }
}
```


## Mark

```
POST /bulletins/:id/stamp
```

### Parameters

| Name     | Type     | Description                            |
| -------- | -------- | -------------------------------------- |
| `symbol` | `string` | **Required**. The symbol of the stamp. |

### Example

```json
{
    "symbol": "check"
}
```

### Response

```json
{
    "type": "Bulletin",
    "id": "3d4a93a6",
    "group_id": "ea6d69d2",
    "text": "3D2Y",
    "created_by_id": "b4e69a67",
    "created_by_type": "Membership",
    "checks_count": 9,
    "crosses_count": 0,
    "comments_count": 0,
    "created_at": "1434096763.816247",
    "updated_at": "1434096763.816247",
    "group": {
        "type": "Group",
        "id": "ea6d69d2",
        "name": "Thousand Sunny",
        "memberships_count": 9,
        "created_at": "1434096763.6460018",
        "updated_at": "1434096763.6460018"
    },
    "created_by": {
        "type": "Membership",
        "id": "b4e69a67",
        "group_id": "ea6d69d2",
        "user_id": "de58e284",
        "role": "owner",
        "alias": null,
        "created_at": "1434096763.729186",
        "updated_at": "1434096763.729186"
    },
    "stamp": {
        "type": "Stamp",
        "id": "eb9d6e93",
        "bulletin_id": "3d4a93a6",
        "symbol": "check",
        "created_by_type": "Membership",
        "created_by_id": "b4e69a67",
        "created_at": "1434099779.701934",
        "updated_at": "1434099779.701934"
    }
}
```
