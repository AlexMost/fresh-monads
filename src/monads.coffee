
_do = (monad, seq, init_arg) ->
   red_func = (mv, nextfunc) -> monad.bind nextfunc, mv
   seq.reduce red_func, monad.result init_arg


module.exports = {_do}