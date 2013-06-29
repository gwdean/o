Function Composition

> x :: a
> f :: a -> b
> g :: b -> c

> g (f x)

Operator for Function Composition

> (.) :: (b -> c) -> (a -> b) -> (a -> c) 
> g . f = \x -> g (f x)

Reverse Function Composition Operator
> (>.>) :: (a -> b) -> (b -> c) -> (a -> c)
> f >.> g = \x -> x >$> f >$> g

Even simpler
> (>.>) :: (a -> b) -> (b -> c) -> (a -> c)
> f >.> g = g . f

