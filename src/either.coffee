Left = (val) -> 
    if not is_left(val)
        return new Left val
    else
        this.val = val


is_left = (val) -> val instanceof Left


Right = (val) -> 
    if not is_right(val)
        return new Right val
    else
        this.val = val


is_right = (val) -> val instanceof Right


Either =
    result: (v) -> Right v

    bind: (f, mv) ->
        if is_right(mv)
            f mv.val
        else if is_left(mv)
            mv
        else throw "Either operates only with Left or Right types, recieved - #{mv}"


module.exports = {Either, Left, Right, is_left, is_right}
