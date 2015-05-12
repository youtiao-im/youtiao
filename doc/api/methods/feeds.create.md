# feeds.create

## URL

`POST https://api.youtiao.im/v1/channels/:channel_id/feeds`

## Arguments

| Argument      | Example    | Required | Description |
| ------------- | ---------- | -------- | ------------------------------------------------------------- |
| `channel_id`  | `W3JBpyjd` | Required | Channel to post feed to.                                      |
| `text`        | `3D2Y`     | Required | Text of the feed. See below for an explanation of formatting. |
| `attachments` | `[]`       | Optional | Structured  attachments.                                      |

### Text formatting

The `text` argument is formatted as described in the [text formatting spec](../formatting.md).

### Attachments

The optional `attachments` argument should contain a JSON-encoded array of attachments. For more information, see the [attachments spec](../attachments.md).

## Response

```json
{
    "id": "lYMBoRda",
    "channel_id": "W3JBpyjd",
    "text": "3D2Y",
    "created_at": 1431349817,
    "updated_at": 1431349817,
    "creator_id": "GDbvXq2O",
    "checked_by_ids": [],
    "crossed_by_ids": [],
    "questioned_by_ids": [],
    "is_checked": false,
    "is_crossed": false,
    "is_questioned": false,
    "attachments": []
}
```

## Errors

**TODO:**
