{Cont, _do} = require '../index'

f1 = (x, f) -> f x + 1
f2 = (x, f) -> f x + 2
f3 = (x, f) -> f x + 3
f4 = (x, f) -> f x + 4

exports.test_continuation_pass = (test) ->
    test.done()