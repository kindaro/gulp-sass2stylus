fs = require 'fs'
http = require 'http'
url = require 'url'


api = 'http://sass2stylus.com/api'
example = 'example.scss'


fs.readFile example, (err, body) ->

    newline = '\r\n'
    blank_line = newline + newline

    boundary = '------------------------we-are-the-void--------------------------'
    body_header =
        newline + 'Content-Disposition: form-data; name="file"; filename="example.scss"' +
        newline + 'Content-Type: application/octet-stream' +
        blank_line

    full_body = [ boundary, body_header, body, blank_line, boundary, '--' ] .join ''
    full_body_a = [ boundary, body_header ] .join ''
    full_body_b = [ body, blank_line, boundary, '--' ] .join ''


    api = url.parse api
    api.method = 'POST'
    api.headers =
        'Expect': '100-continue'
        'Content-Type': 'multipart/form-data; boundary=' + boundary
        'content-length': full_body.length + 1
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
        req.write full_body_a
        req.write full_body_b


