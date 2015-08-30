fs = require('fs')

Client = require 'simple-request'
cli = new Client()




api_endpoint = 'http://sass2stylus.com/api'
example = 'example.scss'


fs.readFile example, (err, body) ->
    console.log 'read file done'
    console.log body.toString()

    options =
        url: api_endpoint
        method: 'POST'
        body: body.toString()

    cli.post api_endpoint, body, {}, (err, res) ->
        console.log 'request sent, response received.'
        console.log res.data
