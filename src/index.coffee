Cli = require('node-rest-client').Client
cli = new Cli()
fs = require('fs')

api_endpoint = 'http://sass2stylus.com/api'
example = 'example.scss'

cli.registerMethod 'go', api_endpoint, 'POST'

fs.readFile example, (err, data) ->
    console.log 'read file done'
    cli.methods.go {data: data}, (data, response) ->
        console.log 'request sent, response received.'
        console.log response
