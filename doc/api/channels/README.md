# Channels

* [Get](#get)
* [Create](#create)

## Get

```
GET /channels/:channel_id
```

### Response

```json
{
    "id": "GPyYROY7",
    "name": "Going Merry",
    "memberships_count": 7,
    "created_at": 1433483148,
    "updated_at": 1433483148,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433483148,
        "updated_at": 1433483148
    },
    "membership": {
        "role": "member",
        "created_at": 1433483148,
        "updated_at": 1433483148
    }
}
```

## Create

```
POST /channels
```

### Parameters

| Name     | Type       | Description                            |
| -------- | ---------- | -------------------------------------- |
| `name`   | `string`   | **Required**. The name of the channel. |

### Example

```json
{
    "name": "Going Merry"
}
```

### Response

```json
{
    "id": "GPyYROY7",
    "name": "Going Merry",
    "memberships_count": 1,
    "created_at": 1433483148,
    "updated_at": 1433483148,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org",
        "created_at": 1433483148,
        "updated_at": 1433483148
    },
    "membership": {
        "role": "owner",
        "created_at": 1433483148,
        "updated_at": 1433483148
    }
}
```
