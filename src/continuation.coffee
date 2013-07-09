lift_async = (f) ->
    (args...) ->
        (cb) -> f (args.concat [cb])...


lift_sync = (f) ->
    (args...)->
        (cb) -> cb (f args...)


ContM =
    result: (v) -> (c) -> c v

    bind: (f, mv) ->
        (k) -> mv (a)-> ((f a) k)


module.exports = {ContM, lift_sync, lift_async}