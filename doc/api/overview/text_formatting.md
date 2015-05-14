# Text Formatting

All messages in Youtiao use the same system of escaping: feed messages, feed comments, chat messages, etc.

## Escaping

Texts can contain any displayable Unicode sequence of characters (all messages must use UTF-8 encoding), but need to be slightly escaped by clients. Before sending messages to the server, clients should make the following transforms:

| Character | Escaped |
| --------- | ------- |
| `&`       | `&amp;` |
| `<`       | `&lt;`  |
| `>`       | `&gt;`  |

For example, if user types `Hello & <world>`, the message sent to server should be `Hello &amp; &lt;world&gt;`.

This is done so that messages can contain special escaped sequences, such as [URL links](#urls), [user or channel mentions](#mentions), etc.

## URLs

For regular URL links, clients should just include the URL in the message. It is not the responsibility of individual clients to detect URLs within typed messages. For example, the following message can be sent to the server:

```
This message contains a URL http://foo.com/, so does this one: www.foo.com.
```

URL detection is performed by the server. We do this so that URL detection (a non-trivial operation) is performed consistently across multiple clients. The example message will be saved and served later to other clients as follows:

```
This message contains a URL <~http://foo.com/>, so does this one: <~http://www.foo.com|www.foo.com>.
```

In the first case, the URL is detected as-is. In the second, the full URL is included first, then a pipe character (`|`), then finally the originally typed version of the URL.

## Mentions

To mention a user or a channel in message, a client should send the following message:

```
Why not join <#kGzZ3eQg|Math>?

Hey <@NyKaRwDb|bob>, did you see my file?
```

These escaped sequences are then served to any clients while requested, and clients can format these links specially. The readable name can be included after the ID, by separating them with a pipe (`|`) character. Both of `<@NyKaRwDb>` and `<@NyKaRwDb|bob>` are valid.

## Emoji

Youtiao attempts to normalize emoji across multiple platforms using the following approach:

1. All emoji sent to Youtiao are translated into the common 'colon' format (e.g. `:smile:`)

2. At display time, Youtiao clients are encouraged to convert these colon-sequences into native Emoji where available, otherwise fallback to images.
