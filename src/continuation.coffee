{is_function} = require 'libprotein'


l_async = (f) ->
    (args...) ->
        (cb) -> f (args.concat [cb])...


l_sync = (f) ->
    (args...)->
        (cb) -> cb (f args...)


ContM =
    result: (v) -> (c) -> c v

    bind: (f, mv) ->
        (c) -> 
            mv((a)-> (f a) c)


ContT = (inner) ->
    result: (v) -> (c) -> c (inner.result v)

    bind: (f, mv) ->
        (c) ->
            get_h = (v) ->
                inner_bind_res = inner.bind f, v
                if is_function inner_bind_res
                    inner_bind_res
                else
                    (c) -> c inner_bind_res

            mv ((v) -> (get_h v) c)


module.exports = {ContM, l_sync, l_async, ContT}
