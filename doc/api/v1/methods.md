# API Methods

## Methods Overview

### users

| Method                                       | Description |
| -------------------------------------------- | ----------- |
| [users.sign_up](#userssign_up)               | Sign up a new user. |
| [user.info](#userinfo)                       | Get current user. |
| [user.update](#userupdate)                   | Update current user. |
| [user.change_password](#userchange_password) | Change password of current user. |

### groups

| Method                         | Description |
| ------------------------------ | ----------- |
| [groups.list](#groupslist)     | Lists groups user joined. |
| [groups.create](#groupscreate) | Creates a group. |
| [groups.update](#groupsupdate) | Updates a group. |
| [groups.join](#groupsjoin)     | Joins a group. |

### memberships

| Method                               | Description |
| ------------------------------------ | ----------- |
| [memberships.list](#membershipslist) | Lists memberships of a group. |

### bulletins

| Method                               | Description |
| ------------------------------------ | ----------- |
| [bulletins.list](#bulletinslist)     | Lists bulletins of one or all groups user joined. |
| [bulletins.create](#bulletinscreate) | Create a bulletin. |
| [bulletins.stamp](#bulletinsstamp)   | Stamp a bulletin. |

### stamps

| Method                     | Description |
| -------------------------- | ----------- |
| [stamps.list](#stampslist) | Lists stamps of a bulletin. |

### comments

| Method                             | Description |
| ---------------------------------- | ----------- |
| [comments.list](#commentslist)     | Lists comments of a bulletin. |
| [comments.create](#commentscreate) | Create a comment. |



## Methods Explained

### users.sign_up

```
POST /users.sign_up
```

#### Parameters

| Name       | Type     | Description |
| ---------- | -------- | ----------- |
| `email`    | `string` | **Required**. Email of user. |
| `password` | `string` | **Required**. Password of user. |
| `name`     | `string` | **Optional**. Name of user. |

#### Response

```json
{
    "id": "de58e284",
    "type": "User",
    "created_at": "1435548611.256135",
    "updated_at": "1435548611.256135",
    "email": "luffy@straw-hat.org",
    "name": "luffy",
    "avatar_id": null,
    "avatar": null
}
```


### user.info

```
GET /user.info
```

#### Response

```json
{
    "id": "de58e284",
    "type": "User",
    "created_at": "1435548611.256135",
    "updated_at": "1435548611.256135",
    "email": "luffy@straw-hat.org",
    "name": "luffy",
    "avatar_id": null,
    "avatar": null
}
```


### user.update

```
POST /user.update
```

#### Parameters

| Name        | Type     | Description |
| ----------- | -------- | ----------- |
| `name`      | `string` | **Optional**. Name of current user. |
| `avatar_id` | `string` | **Optional**. Avatar id of current user. |

#### Response

```json
{
    "id": "de58e284",
    "type": "User",
    "created_at": "1435548611.256135",
    "updated_at": "1435548611.256135",
    "email": "luffy@straw-hat.org",
    "name": "luffy",
    "avatar_id": null,
    "avatar": null
}
```


### user.change_password

```
POST /user.change_password
```

#### Parameters

| Name           | Type     | Description |
| -------------- | -------- | ----------- |
| `password`     | `string` | **Required**. Password of current user. |
| `new_password` | `string` | **Required**. New password of current user. |

#### Response

```json
{
    "id": "de58e284",
    "type": "User",
    "created_at": "1435548611.256135",
    "updated_at": "1435548611.256135",
    "email": "luffy@straw-hat.org",
    "name": "luffy",
    "avatar_id": null,
    "avatar": null
}
```


### groups.list

```
GET /groups.list
```

#### Response

```json
[
    {
        "id": "8e2d94da",
        "type": "Group",
        "created_at": "1435548611.757163",
        "updated_at": "1435548611.757163",
        "name": "Going Merry",
        "code": "going-merry",
        "memberships_count": 7,
        "current_membership": {
            "id": "ed767a69",
            "type": "Membership",
            "created_at": "1435548611.7686899",
            "updated_at": "1435548611.7686899",
            "role": "owner",
            "group_id": "8e2d94da",
            "user_id": "de58e284"
        }
    },
    ...
]
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
{
    "id": "8e2d94da",
    "type": "Group",
    "created_at": "1435548611.757163",
    "updated_at": "1435548611.757163",
    "name": "Going Merry",
    "code": "going-merry",
    "memberships_count": 1,
    "current_membership": {
        "id": "ed767a69",
        "type": "Membership",
        "created_at": "1435548611.7686899",
        "updated_at": "1435548611.7686899",
        "role": "owner",
        "group_id": "8e2d94da",
        "user_id": "de58e284"
    }
}
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
{
    "id": "8e2d94da",
    "type": "Group",
    "created_at": "1435548611.757163",
    "updated_at": "1435548611.757163",
    "name": "Going Merry",
    "code": "going-merry",
    "memberships_count": 7,
    "current_membership": {
        "id": "ed767a69",
        "type": "Membership",
        "created_at": "1435548611.7686899",
        "updated_at": "1435548611.7686899",
        "role": "owner",
        "group_id": "8e2d94da",
        "user_id": "de58e284"
    }
}
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
{
    "id": "8e2d94da",
    "type": "Group",
    "created_at": "1435548611.757163",
    "updated_at": "1435548611.757163",
    "name": "Going Merry",
    "code": "going-merry",
    "memberships_count": 7,
    "current_membership": {
        "id": "ed767a69",
        "type": "Membership",
        "created_at": "1435548611.7686899",
        "updated_at": "1435548611.7686899",
        "role": "owner",
        "group_id": "8e2d94da",
        "user_id": "de58e284"
    }
}
```


### memberships.list

```
GET /memberships.list
```

#### Parameters

| Name        | Type       | Description |
| ----------- | ---------- | ----------- |
| `group_id`  | `string`   | **Required**. Scopes memberships of this group. |

#### Response

```json
[
    {
        "id": "3246856d",
        "type": "Membership",
        "created_at": "1435548611.800355",
        "updated_at": "1435548611.800355",
        "role": "member",
        "group_id": "8e2d94da",
        "user_id": "d658b98a",
        "user": {
            "id": "d658b98a",
            "type": "User",
            "created_at": "1435548611.627708",
            "updated_at": "1435548611.627708",
            "email": "robin@straw-hat.org",
            "name": "robin",
            "avatar_id": null,
            "avatar": null
        }
    },
    ...
]
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
[
    {
        "id": "3d4a93a6",
        "type": "Bulletin",
        "created_at": "1435548611.8673868",
        "updated_at": "1435548611.8673868",
        "text": "3D2Y",
        "checks_count": 8,
        "crosses_count": 0,
        "comments_count": 0,
        "group_id": "ea6d69d2",
        "created_by_id": "de58e284",
        "group": {
            "id": "ea6d69d2",
            "type": "Group",
            "created_at": "1435548611.759491",
            "updated_at": "1435548611.759491",
            "name": "Thousand Sunny",
            "code": "thousand-sunny",
            "memberships_count": 9,
            "current_membership": {
                "id": "b4e69a67",
                "type": "Membership",
                "created_at": "1435561553.257601",
                "updated_at": "1435561553.257601",
                "role": "owner",
                "group_id": "ea6d69d2",
                "user_id": "de58e284"
            }
        },
        "created_by": {
            "id": "de58e284",
            "type": "User",
            "created_at": "1435548611.256135",
            "updated_at": "1435548611.256135",
            "email": "luffy@straw-hat.org",
            "name": "luffy",
            "avatar_id": null,
            "avatar": null
        },
        "current_stamp": null
    },
    ...
]
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
{
    "id": "3d4a93a6",
    "type": "Bulletin",
    "created_at": "1435548611.8673868",
    "updated_at": "1435548611.8673868",
    "text": "3D2Y",
    "checks_count": 0,
    "crosses_count": 0,
    "comments_count": 0,
    "group_id": "ea6d69d2",
    "created_by_id": "de58e284",
    "group": {
        "id": "ea6d69d2",
        "type": "Group",
        "created_at": "1435548611.759491",
        "updated_at": "1435548611.759491",
        "name": "Thousand Sunny",
        "code": "thousand-sunny",
        "memberships_count": 9,
        "current_membership": {
            "id": "b4e69a67",
            "type": "Membership",
            "created_at": "1435561553.257601",
            "updated_at": "1435561553.257601",
            "role": "owner",
            "group_id": "ea6d69d2",
            "user_id": "de58e284"
        }
    },
    "created_by": {
        "id": "de58e284",
        "type": "User",
        "created_at": "1435548611.256135",
        "updated_at": "1435548611.256135",
        "email": "luffy@straw-hat.org",
        "name": "luffy",
        "avatar_id": null,
        "avatar": null
    },
    "current_stamp": null
}
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
{
    "id": "3d4a93a6",
    "type": "Bulletin",
    "created_at": "1435548611.8673868",
    "updated_at": "1435548611.8673868",
    "text": "3D2Y",
    "checks_count": 9,
    "crosses_count": 0,
    "comments_count": 0,
    "group_id": "ea6d69d2",
    "created_by_id": "de58e284",
    "group": {
        "id": "ea6d69d2",
        "type": "Group",
        "created_at": "1435548611.759491",
        "updated_at": "1435548611.759491",
        "name": "Thousand Sunny",
        "code": "thousand-sunny",
        "memberships_count": 9,
        "current_membership": {
            "id": "b4e69a67",
            "type": "Membership",
            "created_at": "1435561553.257601",
            "updated_at": "1435561553.257601",
            "role": "owner",
            "group_id": "ea6d69d2",
            "user_id": "de58e284"
        }
    },
    "created_by": {
        "id": "de58e284",
        "type": "User",
        "created_at": "1435548611.256135",
        "updated_at": "1435548611.256135",
        "email": "luffy@straw-hat.org",
        "name": "luffy",
        "avatar_id": null,
        "avatar": null
    },
    "current_stamp": {
        "id": "7d567952",
        "type": "Stamp",
        "created_at": "1435549074.442284",
        "updated_at": "1435549074.442284",
        "symbol": "check",
        "bulletin_id": "3d4a93a6",
        "created_by_id": "de58e284"
    }
}
```


### stamps.list

```
GET /stamps.list
```

#### Parameters

| Name          | Type       | Description |
| ------------- | ---------- | ----------- |
| `bulletin_id` | `string`   | **Required**. Scopes stamps of this bulletin. |
| `symbols`     | `string[]` | **Optional**. Scopes stamps with specific symbols. |
| `before_id`   | `string`   | **Optional**. Scopes stamps created before this one. |
| `limit`       | `integer`  | **Optional**. Number of stamps to retrieve. Default to 25, max to 500. |

#### Response

```json
[
    {
        "id": "a325de58",
        "type": "Stamp",
        "created_at": "1435548611.933444",
        "updated_at": "1435548611.933444",
        "symbol": "check",
        "bulletin_id": "265a75a3",
        "created_by_id": "d658b98a",
        "created_by": {
            "id": "d658b98a",
            "type": "User",
            "created_at": "1435548611.627708",
            "updated_at": "1435548611.627708",
            "email": "robin@straw-hat.org",
            "name": "robin",
            "avatar_id": null,
            "avatar": null
        }
    },
    ...
]
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
[
    {
        "id": "e4a3eb39",
        "type": "Comment",
        "created_at": "1435548611.989644",
        "updated_at": "1435548611.989644",
        "text": "I have a candidate.",
        "bulletin_id": "265a75a3",
        "created_by_id": "2de8da87",
        "created_by": {
            "id": "2de8da87",
            "type": "User",
            "created_at": "1435548611.5049229",
            "updated_at": "1435548611.5049229",
            "email": "sanji@straw-hat.org",
            "name": "sanji",
            "avatar_id": null,
            "avatar": null
        }
    },
    ...
]
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
{
    "id": "e4a3eb39",
    "type": "Comment",
    "created_at": "1435548611.989644",
    "updated_at": "1435548611.989644",
    "text": "I have a candidate.",
    "bulletin_id": "265a75a3",
    "created_by_id": "2de8da87",
    "created_by": {
        "id": "2de8da87",
        "type": "User",
        "created_at": "1435548611.5049229",
        "updated_at": "1435548611.5049229",
        "email": "sanji@straw-hat.org",
        "name": "sanji",
        "avatar_id": null,
        "avatar": null
    }
}
```
