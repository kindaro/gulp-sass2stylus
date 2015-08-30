fs = require 'fs'
http = require 'http'
url = require 'url'
Curl = require('node-libcurl').Curl


api = 'http://sass2stylus.com/api'
example = 'example.scss'
example_destination = example.replace /\.scss$/, '.styl'


fs.readFile example, (err, body) ->


    curl = new Curl()
    close = curl.close.bind curl

    curl.setOpt Curl.option.URL, api
    curl.setOpt Curl.option.HTTPPOST, [
        name: 'file'
        file: example
        type: 'application/octet-stream'
    ]

    curl.on 'end', (status, body) ->
        console.log 'status: ' + status
        console.log 'body length: ' + body.length
        fs.writeFile example_destination, body, () ->
            console.log 'file written: ' + example_destination

    curl.on 'error', (e) ->
        console.log 'error: ' + e

    curl.perform()
