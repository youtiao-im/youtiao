# Attachments

## Attachment structure

*MAY CHANGE LATER*

Feeds can have zero or more attachments, defined as an array. Each hash in that array will contain multiple properties:

```json
{
    "attachments": [
        {
            "text": "Youtiao API Documentation",
            "url": "https://youtiao.im/api.pdf"
        }
    ]
}
```

## Uploading

### Qiniu

Refer to [Qiniu documentation](http://developer.qiniu.com/) for further info.

Roughly speaking, you need to acquire an *uptoken* from `GET https://api.youtiao.im/v1/uploads/qiniu`, which is then used while uploading to Qiniu. Qiniu would respond with a URL of the uploaded file, which you should provide it as the attachment URL.
