{Cont, lift_sync, _do} = require '../index'


f1 = (x) -> x + 1
f2 = (x) -> x + 2
f3 = (x) -> x + 3


exports.test_continuation_pass = (test) ->
    (_do Cont, [lift_sync(f1), lift_sync(f2), lift_sync(f3)], 1) (res) ->
        test.ok res is 7
        test.done()