
_do = ({bind, result}, seq, init_arg) ->
   red_func = (mv, nextfunc) -> bind nextfunc, mv
   seq.reduce red_func, result init_arg


module.exports = {_do}