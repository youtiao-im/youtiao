# Your Memberships

* [List](#list)
* [Get](#get)
* [Create](#create)

## List

```
GET /user/memberships
```

### Response

```json
[
    {
        "role": "member",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "channel_id": 1
    },
    {
        "role": "member",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "channel_id": 2
    }
]
```

## Get

```
GET /user/memberships/channels/:channel_id
```

### Response

```json
{
    "role": "member",
    "created_at": 1431596915,
    "updated_at": 1431596915,
    "channel_id": 1
}
```

## Create

```
PUT /user/memberships/channels/:channel_id
```

### Response

```json
{
    "role": "member",
    "created_at": 1431596915,
    "updated_at": 1431596915,
    "channel_id": 1
}
```
