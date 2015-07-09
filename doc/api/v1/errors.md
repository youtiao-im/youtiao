# API Errors

For a successful API request, the server will always return `200` http status code. If any error is encountered, a proper http status code is returned to indicate various error types.

## Client Errors

### 400 Bad Request

If you see this error, you're missing required request parameters or passing invalid ones. The responded body should contain sufficient information to indicate the error type and how to fix it. If you use API properly, this error should never happen and thus should be considered as a bug.

### 401 Unauthorized

If you see this error, you are not passing a valid access token to server.

### 403 Forbidden

If you see this error, you are trying to do something not allowed to.

### 404 Not Found

If you see this error, first make sure you are accessing the correct API endpoint. If the request path is correct, it means you are accessing some non-existing resources.

### 405 Method Not Allowed

If you see this error, you are not using the correct http verb.

### 422 Unprocessable Entity

If you see this error, you are trying to create or update an entity using invalid values. Since this error can happen due to invalid user inputs, server will always return sufficient information about the error type, and clients are thus recommended to guide users to input valid values.

The response body is a JSON string formatted as below:

```json
{
    "error": "attribute:reason"
}
```

| Error Reasons | Description |
| ------------- | ----------- |
| `too_long`    | For a string field that contains too many characters. |
| `too_short`   | For a string field that contains too few characters. |
| `blank`       | Field not provided or is a blank string. |
| `invalid`     | Value contains invalid characters. |
| `taken`       | The field requires uniqueness and the given value has already been taken. |


## Server Errors

For any 5xx server errors, clients are recommended to inform users that servers are currently not functioning properly. This should happen very occasionally, and if it does happen, please kindly report it to us.
