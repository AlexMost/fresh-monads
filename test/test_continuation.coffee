{ContM, lift_sync, _do, lift_async} = require '../index'

# sync functions
f1 = (x) -> x + 1
f2 = (x) -> x + 2
f3 = (x) -> x + 3

# async functions
f4 = (x, cb) -> cb x + 1
f5 = (x, cb) -> cb x + 2
f6 = (x, cb) -> cb x + 3


exports.test_continuation_sync_composition = (test) ->
    (_do ContM, [lift_sync(f1), lift_sync(f2), lift_sync(f3)], 1) (res) ->
        test.ok res is 7
        test.done()


exports.test_continuation_async_composition = (test) ->
    (_do ContM, [lift_async(f4), lift_async(f5), lift_async(f6)], 1) (res) ->
        test.ok res is 7
        test.done()

exports.test_sync_and_async_composition = (test) ->
    seq = [
        lift_sync(f1)
        lift_async(f5)
        lift_sync(f3)
    ]

    (_do ContM, seq, 1) (res) ->
        test.ok res is 7
        test.done()