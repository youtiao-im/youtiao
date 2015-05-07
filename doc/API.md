## API v1.0.0 alpha

* [OAuth 2](#oauth-2)
* [Types](#types)
* [Resources](#resource)


## OAuth 2



## Types

| Type      | Description                   |
| --------- | ----------------------------- |
| User      | A user in youtiao.im          |
| Channel   | A channel                     |
| Feed      | A feed posted in some channel |


## Methods

### channels

| Method             | Description                      |
| ------------------ | -------------------------------- |
| channels.index     | Lists accessible channels        |
| channels.show      | Gets information about a channel |
| channels.create    | Creates a new channel            |
| channels.subscribe | Subcribes to a channel           |


### feeds

| Method         | Description                   |
| -------------- | ----------------------------- |
| feeds.index    | Lists feeds in a channel      |
| feeds.show     | Gets information about a feed |
| feeds.create   | Creates a new feed            |
| feeds.feedback | Feedbacks to a feed           |
