lift_sync = (f) ->
    (args...)->
        (cb) -> cb (f args...)


Cont =
    result: (v) -> (c) -> c v

    bind: (f, mv) ->
        (k) -> mv ((a)-> ((f a) k))


module.exports = {Cont, lift_sync}