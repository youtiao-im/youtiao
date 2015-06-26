# API Methods

## Methods Overview

### groups

| Method                            | Description |
| --------------------------------- | ----------- |
| [groups.list](#groups.list)     | Lists groups user joined. |
| [groups.create](#groups.create) | Creates a group. |
| [groups.update](#groups.update) | Updates a group. |
| [groups.join](#groups.join)     | Joins a group. |

### memberships

| Method                                  | Description |
| --------------------------------------- | ----------- |
| [memberships.list](#memberships.list) | Lists memberships of a group. |

### bulletins

| Method                                  | Description |
| --------------------------------------- | ----------- |
| [bulletins.list](#bulletins.list)     | Lists bulletins of one or all groups user joined. |
| [bulletins.create](#bulletins.create) | Create a bulletin. |
| [bulletins.stamp](#bulletins.stamp)   | Stamp a bulletin. |

### stamps

| Method                        | Description |
| ----------------------------- | ----------- |
| [stamps.list](#stamps.list) | Lists stamps of a bulletin. |

### comments

| Method                                | Description |
| ------------------------------------- | ----------- |
| [comments.list](#comments.list)     | Lists comments of a bulletin. |
| [comments.create](#comments.create) | Create a comment. |



## Methods Explained

### groups.list

```
GET /groups.list
```

#### Response

```json
```


### groups.create

```
POST /groups.create
```

#### Parameters

| Name   | Type     | Description |
| ------ | -------- | ----------- |
| `name` | `string` | **Required**. Name of the group. |
| `code` | `string` | **Optional**. Unique code of the group. |

#### Response

```json
```


### groups.update

```
POST /groups.update
```

#### Parameters

| Name   | Type     | Description |
| ------ | -------- | ----------- |
| `id`   | `string` | **Required**. Id of the group. |
| `name` | `string` | **Optional**. Name of the group. |
| `code` | `string` | **Optional**. Unique code of the group. |

#### Response

```json
```


### groups.join

```
POST /groups.join
```

#### Parameters

| Name   | Type     | Description |
| ------ | -------- | ----------- |
| `code` | `string` | **Required**. Unique code of the group. |

#### Response

```json
```


### memberships.list

```
GET /memberships.list
```

#### Parameters

| Name        | Type      | Description |
| ----------- | --------- | ----------- |
| `before_id` | `string`  | **Optional**. Scopes memberships created before this one. |
| `limit`     | `integer` | **Optional**. Number of memberships to retrieve. Default to 25, max to 500. |

### Response

```json
```


### bulletins.list

```
GET /bulletins.list
```

#### Parameters

| Name        | Type      | Description |
| ----------- | --------- | ----------- |
| `group_id`  | `string`  | **Optional**. Scopes bulletins of this group. |
| `before_id` | `string`  | **Optional**. Scopes bulletins created before this one. |
| `limit`     | `integer` | **Optional**. Number of bulletins to retrieve. Default to 25, max to 500. |

#### Response

```json
```


### bulletins.create

```
POST /bulletins.create
```

#### Parameters

| Name       | Type      | Description |
| ---------- | --------- | ----------- |
| `group_id` | `string`  | **Required**. Group id of the bulletin. |
| `text`     | `string`  | **Required**. Text of the bulletin. |

#### Response

```json
```


### bulletins.stamp

```
POST /bulletins.stamp
```

#### Parameters

| Name     | Type      | Description |
| -------- | --------- | ----------- |
| `id`     | `string`  | **Required**. Id of the bulletin. |
| `symbol` | `string`  | **Required**. Symbol of the stamp. |

#### Response

```json
```


### stamps.list

```
GET /stamps.list
```

#### Parameters

| Name          | Type      | Description |
| ------------- | --------- | ----------- |
| `bulletin_id` | `string`  | **Required**. Scopes stamps of this bulletin. |
| `before_id`   | `string`  | **Optional**. Scopes stamps created before this one. |
| `limit`       | `integer` | **Optional**. Number of stamps to retrieve. Default to 25, max to 500. |

#### Response

```json
```


### comments.list

```
GET /comments.list
```

#### Parameters

| Name          | Type      | Description |
| ------------- | --------- | ----------- |
| `bulletin_id` | `string`  | **Required**. Scopes comments of this bulletin. |
| `before_id`   | `string`  | **Optional**. Scopes comments created before this one. |
| `limit`       | `integer` | **Optional**. Number of comments to retrieve. Default to 25, max to 500. |

#### Response

```json
```


### comments.create

```
GET /comments.create
```

#### Parameters

| Name          | Type      | Description |
| ------------- | --------- | ----------- |
| `bulletin_id` | `string`  | **Required**. Bulletin id of the comment. |
| `text`        | `string`  | **Required**. Text of the comment. |

#### Response

```json
```
