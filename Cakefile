{exec} = require 'child_process'

task 'test', 'Run tests', ->
    exec "nodeunit test", {}, (error, stdout, stderr) ->
        console.log stdout if stdout
        console.log stderr if stderr
