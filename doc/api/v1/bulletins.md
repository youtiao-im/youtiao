# Bulletins

* [List](#list)
* [Get](#get)
* [Create](#create)
* [Stamp](#stamp)


## List

```
GET /bulletins
GET /groups/:group_id/bulletins
```

The returned bulletins will be sorted in the reverse order they get created.

### Parameters

| Name        | Type      | Description |
| ----------- | --------- | ----------- |
| `before_id` | `string`  | **Optional**. Returns bulletins created before the specified bulletin. |
| `limit`     | `integer` | **Optional**. The number of bulletins to retrieve. Default to 25, max to 500. |

### Response

```json
[
    {
        "type": "Bulletin",
        "id": "3d4a93a6",
        "group_id": "ea6d69d2",
        "text": "3D2Y",
        "created_by_id": "de58e284",
        "checks_count": 8,
        "crosses_count": 0,
        "comments_count": 0,
        "created_at": "1434633474.884896",
        "updated_at": "1434633474.884896",
        "group": {
            "type": "Group",
            "id": "ea6d69d2",
            "name": "Thousand Sunny",
            "code": "thousand-sunny#2543",
            "memberships_count": 9,
            "created_at": "1434633474.775358",
            "updated_at": "1434633474.775358"
        },
        "created_by": {
            "type": "User",
            "id": "de58e284",
            "email": "luffy@straw-hat.org",
            "name": "luffy",
            "avatar_id": null,
            "created_at": "1434633474.270281",
            "updated_at": "1434633474.270281"
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
    "created_by_id": "de58e284",
    "checks_count": 8,
    "crosses_count": 0,
    "comments_count": 0,
    "created_at": "1434633474.884896",
    "updated_at": "1434633474.884896",
    "group": {
        "type": "Group",
        "id": "ea6d69d2",
        "name": "Thousand Sunny",
        "code": "thousand-sunny#2543",
        "memberships_count": 9,
        "created_at": "1434633474.775358",
        "updated_at": "1434633474.775358"
    },
    "created_by": {
        "type": "User",
        "id": "de58e284",
        "email": "luffy@straw-hat.org",
        "name": "luffy",
        "avatar_id": null,
        "created_at": "1434633474.270281",
        "updated_at": "1434633474.270281"
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
    "created_by_id": "de58e284",
    "checks_count": 0,
    "crosses_count": 0,
    "comments_count": 0,
    "created_at": "1434633474.884896",
    "updated_at": "1434633474.884896",
    "group": {
        "type": "Group",
        "id": "ea6d69d2",
        "name": "Thousand Sunny",
        "code": "thousand-sunny#2543",
        "memberships_count": 9,
        "created_at": "1434633474.775358",
        "updated_at": "1434633474.775358"
    },
    "created_by": {
        "type": "User",
        "id": "de58e284",
        "email": "luffy@straw-hat.org",
        "name": "luffy",
        "avatar_id": null,
        "created_at": "1434633474.270281",
        "updated_at": "1434633474.270281"
    }
}
```


## Stamp

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
    "created_by_id": "de58e284",
    "checks_count": 9,
    "crosses_count": 0,
    "comments_count": 0,
    "created_at": "1434633474.884896",
    "updated_at": "1434633474.884896",
    "group": {
        "type": "Group",
        "id": "ea6d69d2",
        "name": "Thousand Sunny",
        "code": "thousand-sunny#2543",
        "memberships_count": 9,
        "created_at": "1434633474.775358",
        "updated_at": "1434633474.775358"
    },
    "created_by": {
        "type": "User",
        "id": "de58e284",
        "email": "luffy@straw-hat.org",
        "name": "luffy",
        "avatar_id": null,
        "created_at": "1434633474.270281",
        "updated_at": "1434633474.270281"
    },
    "stamp": {
        "type": "Stamp",
        "id": "7d567952",
        "bulletin_id": "3d4a93a6",
        "symbol": "check",
        "created_by_id": "de58e284",
        "created_at": "1434634816.8099551",
        "updated_at": "1434634816.8099551"
    }
}
```
