Just = (val) -> 
    if not(this instanceof Just)
        return new Just val
    else
        this.val = val


is_nothing = (v) -> v instanceof Nothing


Nothing = -> return new Nothing() if not is_nothing(this)


Maybe =
    result: (v) -> Just v

    bind: (f, mv) ->
        if is_nothing mv
            mv
        else unless is_nothing mv
            f mv.val
        else throw "Maybe operates only with Just or Nothing, recieved - #{mv}"


module.exports = {Maybe, Nothing, Just, is_nothing}