# Channel Memberships

* [List](#list)
* [Get](#get)

## List

```
GET /channels/:channel_id/memberships
```

### Response

```json
[
    {
        "role": "owner",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 1
    },
    {
        "role": "member",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 2
    },
    {
        "role": "member",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 3
    },
    {
        "role": "member",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 4
    },
    {
        "role": "member",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 5
    },
    {
        "role": "member",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 6
    },
    {
        "role": "member",
        "created_at": 1431596915,
        "updated_at": 1431596915,
        "user_id": 7
    }
]
```

## Get

```
GET /channels/:channel_id/memberships/users/:user_id
```

### Response

```json
{
    "role": "member",
    "created_at": 1431596915,
    "updated_at": 1431596915,
    "user_id": 2
}
```
