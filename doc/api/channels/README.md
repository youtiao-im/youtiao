# Channels

* [List your channels](list-your-channels)
* [Get a channel](get-a-channel)
* [Create a channel](create-a-channel)

## List your channels

```
GET /user/channels
```

### Response

```json
TODO: fill in json
```

## Get a channel

```
GET /channels/:channel_id
```

### Response

```json
{
    "id": "GPyYROY7",
    "name": "Going Merry",
    "created_at": 1431349817,
    "updated_at": 1431349817,
    "created_by": { TODO: },
    "members_count": 7
}
```

## Create a channel

```
POST /channels
```

### Parameters

| Name     | Type       | Description                            |
| -------- | ---------- | -------------------------------------- |
| `name`   | `string`   | **Required**. The name of the channel. |

### Example

```json
TODO: fill in json
```

### Response

```json
TODO: fill in json
```
