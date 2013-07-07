{Either, _do, Left, Right} = require '../index'

f1 = (x) -> Right 1 + x
f2 = (x) -> Right 1 + x
f3 = (x) -> Right 2 + x
f4 = (x) -> Left "Computation failure"
f5= (x) -> 5


exports.test_either_right = (test) ->
    res = _do Either, [f1, f2, f3], 1
    test.ok res.val is 5, "Result expected - #{5}, recieved - #{res.val}"
    test.done()


exports.test_eigher_left = (test) ->
    res = _do Either, [f1, f4, f2, f3], 1
    test.ok (res instanceof Left), "Expected result is Left, recieved - #{res}"
    test.ok res.val is "Computation failure", "Left value must be - 'Computation failure', recieved - #{res.val}"
    test.done()