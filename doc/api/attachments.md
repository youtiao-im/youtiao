# Attachments

## Attachment structure

Feeds can have zero or more attachments, defined as an array. Each hash in that array will contain multiple properties:

```json
{
    "attachments": [
        {
            "title": "Youtiao API Documentation",
            "link": "https://youtiao.im/api.pdf",
            "image_url": "http://my-website.com/path/to/image.jpg"
        }
    ]
}
```

### title

The `title` is a recognizable name for the attachment. When the attachment is referenced in message without an optional readable name, clients are recommended to display `title` as the readable name.

### link

This can be a URL to a file uploaded to Youtiao, or some external resource.

### image_url

A valid URL to an image file that will be displayed inside a message attachment. We currently support the following formats: JPEG and PNG.

Large images will be resized to a maximum width of 400px or a maximum height of 500px, while still maintaining the original aspect ratio.

## Uploading

**TODO: qiniu upload**
