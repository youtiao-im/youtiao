# File Uploading

We use *Qiniu* to host all user uploaded files. Before you can upload anything to Qiniu, you need to acquire an upload token first:

```
POST /blobs.token
```

With the upload token in hand, you can upload the file using [Qiniu SDKs](https://github.com/qiniu). When upload finishes, the response would be a blob object:

```json
{
    "type": "Blob",
    "id": "d3853a59",
    "data_url": "http://youtiao.qiniudn.com/Fu6K0Vvi-jUSuW-1EQ5mhhk1ByPQ",
    "created_at": "1434633474.270281",
    "updated_at": "1434633474.270281"
}
```

You can then reference the uploaded file when creating or updating other resources using blob id.
