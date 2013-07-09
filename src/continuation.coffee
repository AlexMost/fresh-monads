lift_sync = (f) ->
    (args...)->
        (cb) -> cb (f args...)


Cont =
    result: (v) -> (c) -> c v

    bind: (f, mv) ->
        (c) -> mv((a)-> (f a) c)


module.exports = {Cont, lift_sync}
