{ContM, ContT, l_sync, _do, l_async
Left, Right, Either, is_right, is_left} = require '../index'

# sync functions
f1 = (x) -> x + 1
f2 = (x) -> x + 2
f3 = (x) -> x + 3

# async functions
f4 = (x, cb) -> cb x + 1
f5 = (x, cb) -> cb x + 2
f6 = (x, cb) -> cb x + 3

# continuation transformer functions with either monad
f7 = (x) -> Right x + 1
f8 = (x) -> Right x + 2
f9 = (x, cb) -> cb (Right x + 3)
f10 = (x, cb) -> cb (Left "some error occured")


exports.test_continuation_sync_composition = (test) ->
    (_do ContM, [l_sync(f1), l_sync(f2), l_sync(f3)], 1) (res) ->
        test.ok res is 7
        test.done()


exports.test_continuation_async_composition = (test) ->
    (_do ContM, [l_async(f4), l_async(f5), l_async(f6)], 1) (res) ->
        test.ok res is 7
        test.done()


exports.test_sync_and_async_composition = (test) ->
    seq = [
        l_sync f1
        l_async f5
        l_sync f3
    ]

    (_do ContM, seq, 1) (res) ->
        test.ok res is 7
        test.done()


exports.test_continuation_transformer_either = (test) ->
    res_monad = ContT Either

    seq1 = [
        l_sync f7
        l_sync f8
        l_async f9
    ]

    seq2 = [
        l_sync f7
        l_async f10
        l_async f9
    ]

    (_do res_monad, seq1, 1) (res) ->
        test.ok is_right res
        test.ok res.val is 7

        (_do res_monad, seq2, 1) (res) ->
            test.ok is_left res
            test.ok res.val is "some error occured"
            test.done()
