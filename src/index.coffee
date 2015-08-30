fs = require 'fs'
http = require 'http'
url = require 'url'


api = 'http://sass2stylus.com/api'
example = 'example.scss'


fs.readFile example, (err, body) ->

    boundary = '------------------------9a4e1e8f72350b69'
    api = url.parse api
    api.method = 'POST'
    api.headers =
        'Expect': '100-continue'
        'Content-Type': 'multipart/form-data; boundary=' + boundary
        'content-length': body.length
        'Accept': '*/*'
        'Connection': 'keep-alive'

    req = http.request api, (res) ->
        console.log 'STATUS: ' + res.statusCode
        console.log 'HEADERS: ' + JSON.stringify(res.headers)
        res.setEncoding 'utf8'
        res.on 'data', (chunk) ->
            console.log 'BODY: ' + chunk
        req.end()

    req.on 'error', (e) ->
        console.log 'problem with request: ' + e.message

    req.on 'continue', () ->
        console.log 'continue event received.'
        req.write boundary + '\r\nContent-Disposition: form-data; name="file"; filename="example.scss"\r\nContent-Type: application/octet-stream\r\n\r\n'
        req.write body + '\r\n\r\n' + boundary + '--'


