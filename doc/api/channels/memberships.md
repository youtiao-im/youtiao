# Memberships

* [List channel memberships](list-channel-memberships)
* [Get a channel membership](get-a-channel-membership)
* [Create a channel membership*](Create-a-channel-membership)
* [List your channel memberships](list-your-channel-memberships)

## List channel memberships

```
GET /channels/:channel_id/memberships
```

### Response

```json
[
    {
        "role": "admin",
        "user": { TODO: }
    }
]
```

## Get a channel membership

```
GET /channels/:channel_id/memberships/:user_id
```

### Response

```json
{
    "role": "admin",
    "user": { TODO: }
}
```

## Create a channel membership

```
PUT /channels/:channel_id/memberships/:user_id
```

## List your channel memberships

```
GET /user/memberships/channels
```

### Response

```json
[
    {
        "role": "admin",
        "channel": { TODO: }
    }
]
```
