# LiveViewDropzoneTest

This is just a quick test or proof of concept for uploading large (video) files via signed urls to S3.

Here's how it works:

To initialte uploads, it uses the [phoenix_live_view_dropzone](https://github.com/JonRowe/phoenix_live_view_dropzone) component by [Jon Rowe](https://github.com/JonRowe).
Once you add a file from your computer, the dropzone comoponent fires off the `generate-url` event to the LiveView process. In the Uploads Module is a little function that, via ExAws.S3, creates a signed upload URL with the `file_name` from the Dropzone.
This URL we hand back to the Dropzone component, which then starts the upload and returns progress information until it's done.

When the upload is done, we get a signed GET url from the Uploads Module, so that we can actually look at the uploaded file.
I created this with videos in mind, so that's why I'm just showing a standard video player at the end.

This is just the short version. Overall it's pretty straightforward, but I might write up detailed step-by-step in the future as well.
I will also keep working a bit on this. Something I want to play with for example is the encoding after uploading and the whole back and forth
between asynchronous AWS services. Also, a data store. Anyway,

To start the app

- Install dependencies with `mix deps.get`
- Install Node.js dependencies with `npm install` inside the `assets` directory
- Add your S3 secrets to `config/dev.secret.exs` (gets importet into `config/dev.exs`)
    ```
    config :ex_aws, 
      access_key_id: "ACCESS_KEY_ID", 
      secret_access_key: "SECRET_ACCESS_KEY", 
      region: "AWS_REGION", 
      bucket: "BUCKET"
    ```
- Start Phoenix with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
