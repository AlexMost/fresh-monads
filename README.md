fresh-monads
============

Implementation of monads in coffeescript (inspired by haskell).

## API functions

### _do
_do is used to bind our functions in one sequence.
Example

```coffee
_do Maybe [f1, f2, f3, f4], 1

# Maybe - instance of the Maybe monad.
# [f1, f2, f3, f4] - sequence functions that we want to compose.
# 1 - initial value that will be passed to first function in sequence.
```

### Maybe monad
Has two value constructors : Just and Nothing.

**Just** - continues computation and passes it's argument to the next function. You can access wrapped value in Just through the val property.

```coffee
j = Just 5
j.val is 5 # true
```

**Nothing** - stops computation, if some function in sequence returns Nothing - the next function will not be called.

```coffee
{_do, Maybe, Just, Nothing} = require 'fresh-monads'

func1 = (x) -> Just 1 + x
func2 = (x) -> Just 2 + x
func3 = (x) -> Just 3 + x
nothing_func (x) -> Nothing()

# To compose this function we may use _do function

res = _do Maybe, [func1, func2, func3], 1
# res = Just 7


res = _do Maybe, [func1, nothing_func, func2, func3], 1
# res = Nothing
```

### Either monad
Has two value constructors: Right and Left.

**Right** - continues computation and passes new value to the next function in sequence.

**Left** - stops computation and returns some information about the reason of interrupting computation.

```coffee
{_do, Either, Left, Right} = require 'fresh-monads'

r = Right 5
r.val is 5 # true

l = Left "some"
l.val is "some" # true

func1 = (x) -> Right 1 + x
func2 = (x) -> Right 2 + x
func3 = (x) -> Right 3 + x
left_func = (x) -> Left "stop"

res_right = _do Maybe, [func1, func2, func3], 1
# res_right = Right 7

res_left = _do Maybe, [func1, func2, left_func, func3], 1
# res_left = Left "some"
```

### Continuation monad
Executes functions in continuation passing style, also allows us to compose synchronous and asynchronous functions in one continuation.

Before including some function in a continuation - we must lift it.

**l_sync** - lifts synchronous function (without callback)

**l_async** - lifts asynchronus function (with callback)


```coffee
{_do, ContM, l_sync, l_async} = require 'fresh-monads'

# Composing synchronous functions
sync_f1 = (x) -> x + 1
sync_f2 = (x) -> x + 2
sync_f3 = (x) -> x + 3

sequence = [
    l_sync sync_f1
    l_sync sync_f2 
    l_sync sync_f3
]

(_do ContM, sequence, 1) (res) ->
        res is 7 # true

# Composing asynchronous functions
async_f1 = (x, cb) -> cb x + 1
async_f2 = (x, cb) -> cb x + 2
async_f3 = (x, cb) -> cb x + 3

sequence = [
    l_async async_f1 
    l_async async_f2
    l_async async_f3
]

(_do ContM, sequence, 1) (res) ->
        res is 7 # true


# Composing synchronous and asynchronous functions

sequence = [
    l_async async_f1
    l_sync sync_f2
    l_async async_f3
    ]

(_do ContM, sequence, 1) (res) ->
        res is 7 # true
```

### Monad Transformers
Monads are composable by their nature, you can combine them via monad transformers.

Little example :

```coffee
{_do, ContT, Either, l_sync, l_async} = require 'fresh-monads'

f1 = (x, cb) -> cb (Right x + 1)
f2 = (x) -> Right x + 2
f3 = (x, cb) -> cb (Right x + 3)

sequence = [
    l_async f1
    l_sync f2
    l_async f3
]

# As we see, we have both - continuation passing functions and either monad values
# to have an ability to control the sequence flow. 
# Let's create transformer monad that will be able to do both:
# - composes continuation functions
# - controls sequence flow through return value (Right or Left)

ContEither = ContT Either

(_do ContEither, sequence, 1) (res) ->
        res.val is 7 # true

# let's add some Left result function to our sequence

left_func = (x, cb) -> cb (Left "stop")

sequence = [
    l_async f1
    l_sync f2
    l_async left_func 
    l_async f3
]

(_do ContEither, sequence, 1) (res) ->  # returns
        res.val is "stop" # true
```
