# API reference

* [Authorization](auth.md)
* [Feed Formatting](formatting.md)
* [Methods](#methods)
* [Types](#types)


## Methods

### channels

| Method                                              | Description                      |
| --------------------------------------------------- | -------------------------------- |
| [channels.index](methods/channels.index.md)         | Lists accessible channels        |
| [channels.show](methods/channels.show.md)           | Gets information about a channel |
| [channels.create](methods/channels.create.md)       | Creates a new channel            |
| [channels.subscribe](methods/channels.subscribe.md) | Subcribes to a channel           |


### feeds

| Method                                      | Description                   |
| ------------------------------------------- | ----------------------------- |
| [feeds.index](methods/feeds.index.md)       | Lists feeds in a channel      |
| [feeds.show](methods/feeds.show.md)         | Gets information about a feed |
| [feeds.create](methods/feeds.create.md)     | Creates a new feed            |
| [feeds.feedback](methods/feeds.feedback.md) | Feedbacks to a feed           |


## Types

| Type                        | Description                   |
| --------------------------- | ----------------------------- |
| [User](types/user.md)       | A user                        |
| [Channel](types/channel.md) | A channel                     |
| [Feed](types/feed.md)       | A feed posted in some channel |
