lift_async = (f) ->
    (args...) ->
        (cb) -> f (args.concat [cb])...


lift_sync = (f) ->
    (args...)->
        (cb) -> cb (f args...)


ContM =
    result: (v) -> (c) -> c v

    bind: (f, mv) ->
        (c) -> mv((a)-> (f a) c)


module.exports = {ContM, lift_sync, lift_async}
