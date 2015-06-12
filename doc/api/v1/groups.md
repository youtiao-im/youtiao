# Groups

* [List](#list)
* [Get](#get)
* [Create](#create)
* [Join](#join)


## List

```
GET /groups
```

### Response

```json
[
    {
        "type": "Group",
        "id": "8e2d94da",
        "name": "Going Merry",
        "memberships_count": 7,
        "created_at": "1434096763.641664",
        "updated_at": "1434096763.641664",
        "membership": {
            "type": "Membership",
            "id": "ed767a69",
            "group_id": "8e2d94da",
            "user_id": "de58e284",
            "role": "owner",
            "alias": null,
            "created_at": "1434096763.6591308",
            "updated_at": "1434096763.6591308"
        }
    },
    ...
]
```


## Get

```
GET /groups/:id
```

### Response

```json
{
    "type": "Group",
    "id": "8e2d94da",
    "name": "Going Merry",
    "memberships_count": 7,
    "created_at": "1434096763.641664",
    "updated_at": "1434096763.641664",
    "membership": {
        "type": "Membership",
        "id": "ed767a69",
        "group_id": "8e2d94da",
        "user_id": "de58e284",
        "role": "owner",
        "alias": null,
        "created_at": "1434096763.6591308",
        "updated_at": "1434096763.6591308"
    }
}
```


## Create

```
POST /groups
```

### Parameters

| Name   | Type     | Description                          |
| ------ | -------- | ------------------------------------ |
| `name` | `string` | **Required**. The name of the group. |

### Example

```json
{
    "name": "Going Merry"
}
```

### Response

```json
{
    "type": "Group",
    "id": "8e2d94da",
    "name": "Going Merry",
    "memberships_count": 1,
    "created_at": "1434096763.641664",
    "updated_at": "1434096763.641664",
    "membership": {
        "type": "Membership",
        "id": "ed767a69",
        "group_id": "8e2d94da",
        "user_id": "de58e284",
        "role": "owner",
        "alias": null,
        "created_at": "1434096763.6591308",
        "updated_at": "1434096763.6591308"
    }
}
```


## Join

```
POST /groups/:id/join
```

### Response

```json
{
    "type": "Group",
    "id": "8e2d94da",
    "name": "Going Merry",
    "memberships_count": 7,
    "created_at": "1434096763.641664",
    "updated_at": "1434096763.641664",
    "membership": {
        "type": "Membership",
        "id": "ed767a69",
        "group_id": "8e2d94da",
        "user_id": "de58e284",
        "role": "member",
        "alias": null,
        "created_at": "1434096763.6591308",
        "updated_at": "1434096763.6591308"
    }
}
```
