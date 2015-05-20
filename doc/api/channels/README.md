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
    "created_at": 1432100855,
    "updated_at": 1432100855,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org"
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
    "created_at": 1432100855,
    "updated_at": 1432100855,
    "created_by": {
        "id": "WM8Xnx7Q",
        "email": "luffy@straw-hat.org"
    }
}
```
