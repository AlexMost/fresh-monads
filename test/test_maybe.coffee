{Maybe, _do, Just, Nothing} = require '../index'

f1 = (x) -> Just 1 + x
f2 = (x) -> Just 1 + x
f3 = (x) -> Just 2 + x
f4 = (x) -> Nothing()
f5= (x) -> 5


exports.test_maybe_success_computation = (test) ->
    res = _do Maybe, [f1, f2, f3], 1
    test.ok res.val is 5, "Result expected - #{5}, recieved - #{res.val}"
    test.done()


exports.test_maybe_failure_computation = (test) ->
    res = _do Maybe, [f1, f4, f2, f3], 1
    test.ok (res instanceof Nothing), "Expected result is Nothign, recieved - #{res}"
    test.done()


exports.test_throws_error_when_function_returns_not_maybe_type = (test) ->
    test.throws(
          (_do Maybe, [f1, f4, f5, f2, f3], 1)
        , Error
        , "Throw error when sequence function returns not maybe type")
    test.done()
