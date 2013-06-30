-- The Monad Typeclass

-- Maybe.hs
class Monad m where
  -- chain
  (>>=) :: m a -> (a -> m b) -> m b
  -- inject
  return :: a -> m a
  
  (>>) :: m a -> m b -> m b  
  a >> f = a >>= \_ -> f
  
-- Parse.hs
instance Monad Parse where
  return = identity
  (>>=) = (==>)
  fail = bail
  
-- Beckman
x:int
f:int->int

x:a
x:a->a
g:a->a

f(g(a))
g(f(a))

g a
f (g a)
g (f a)

functions
monoids
functions
monads

composability

f : a -> Ma
g : a -> Ma
h : a -> Ma

\a -> ...

-- Compositionality is the way
-- to control complexity

\a -> (fa) >>= \a -> (g a)