fs = require('fs')
request = require 'request'


api_endpoint = 'http://sass2stylus.com/api'
example = 'example.scss'


fs.readFile example, (err, body) ->
    console.log 'read file done'
    console.log body.toString()

    options =
        url: api_endpoint
        method: 'POST'
        body: body.toString()

    request options, (error, response, body) ->
        console.log 'request sent, response received.'
        console.log body
