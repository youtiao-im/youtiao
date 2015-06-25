# Groups

* [List](#list)
* [Get](#get)
* [Create](#create)
* [Update](#update)
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
        "code": "going-merry#2500",
        "memberships_count": 7,
        "created_at": "1435209292.760114",
        "updated_at": "1435209292.760114",
        "membership": {
            "type": "Membership",
            "id": "ed767a69",
            "group_id": "8e2d94da",
            "user_id": "de58e284",
            "role": "owner",
            "created_at": "1435209293.049273",
            "updated_at": "1435209293.049273"
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
    "code": "going-merry#2500",
    "memberships_count": 7,
    "created_at": "1435209292.760114",
    "updated_at": "1435209292.760114",
    "membership": {
        "type": "Membership",
        "id": "ed767a69",
        "group_id": "8e2d94da",
        "user_id": "de58e284",
        "role": "owner",
        "created_at": "1435209293.049273",
        "updated_at": "1435209293.049273"
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
| `code` | `string` | **Optional**. The code of the group. |

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
    "code": "going-merry#2500",
    "memberships_count": 1,
    "created_at": "1435209292.760114",
    "updated_at": "1435209292.760114",
    "membership": {
        "type": "Membership",
        "id": "ed767a69",
        "group_id": "8e2d94da",
        "user_id": "de58e284",
        "role": "owner",
        "created_at": "1435209293.049273",
        "updated_at": "1435209293.049273"
    }
}
```


## Update

```
PATCH /groups/:id
```

### Parameters

| Name   | Type     | Description                          |
| ------ | -------- | ------------------------------------ |
| `name` | `string` | **Optional**. The name of the group. |
| `code` | `string` | **Optional**. The code of the group. |

### Example

```json
{
    "name": "Going Merry II"
}
```

### Response

```json
{
    "type": "Group",
    "id": "8e2d94da",
    "name": "Going Merry II",
    "code": "going-merry#2500",
    "memberships_count": 7,
    "created_at": "1435209292.760114",
    "updated_at": "1435209292.760114",
    "membership": {
        "type": "Membership",
        "id": "ed767a69",
        "group_id": "8e2d94da",
        "user_id": "de58e284",
        "role": "owner",
        "created_at": "1435209293.049273",
        "updated_at": "1435209293.049273"
    }
}
```


## Join

```
POST /groups/join
```

### Parameters

| Name   | Type     | Description                          |
| ------ | -------- | ------------------------------------ |
| `code` | `string` | **Required**. The code of the group. |

### Response

```json
{
    "type": "Group",
    "id": "8e2d94da",
    "name": "Going Merry",
    "code": "going-merry#2500",
    "memberships_count": 7,
    "created_at": "1435209292.760114",
    "updated_at": "1435209292.760114",
    "membership": {
        "type": "Membership",
        "id": "ed767a69",
        "group_id": "8e2d94da",
        "user_id": "de58e284",
        "role": "owner",
        "created_at": "1435209293.049273",
        "updated_at": "1435209293.049273"
    }
}
```
