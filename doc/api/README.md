# API reference

* [Authorization](authorization.md)
* [Text Formatting](formatting.md)
* [Attachments](attachments.md)
* [Methods](#methods)
* [Types](#types)

## Methods

### channels

| Method                                        | Description                      |
| --------------------------------------------- | -------------------------------- |
| [channels.index](methods/channels.index.md)   | Lists accessible channels        |
| [channels.show](methods/channels.show.md)     | Gets information about a channel |
| [channels.create](methods/channels.create.md) | Creates a new channel            |
| [channels.join](methods/channels.join.md)     | Joins a channel                  |

### feeds

| Method                                  | Description                   |
| --------------------------------------- | ----------------------------- |
| [feeds.index](methods/feeds.index.md)   | Lists feeds in a channel      |
| [feeds.show](methods/feeds.show.md)     | Gets information about a feed |
| [feeds.create](methods/feeds.create.md) | Creates a new feed            |
| [feeds.stamp](methods/feeds.stamp.md)   | Stamps a feed                 |

## Types

| Type                        | Description                   |
| --------------------------- | ----------------------------- |
| [user](types/user.md)       | A user                        |
| [channel](types/channel.md) | A channel                     |
| [feed](types/feed.md)       | A feed posted in some channel |
