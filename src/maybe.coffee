Just = (val) -> 
    if not(this instanceof Just)
        return new Just val
    else
        this.val = val


Nothing = ->
    if not(this instanceof Nothing)
        return new Nothing


Maybe =
    result: (v) -> Just v

    bind: (f, mv) ->
        if mv instanceof Nothing
            mv
        else if mv instanceof Just
            f mv.val
        else throw "Maybe operates only with Just or Nothing, recieved - #{mv}"


module.exports = {Maybe, Nothing, Just}