module Main where

import Data.List (intersperse, permutations, sortOn)

main :: IO ()
main = print $ solution [75,4,2,2,1,10] 511

data Op a = Op { name :: String, operator :: a -> a -> a}

instance Show (Op a) where
    show (Op n _) = n

ops :: [Op Integer]
ops = [Op "Plus" (+), Op "Minus" (-), Op "Times" (*)]

opsv :: [(Op Integer, Op Integer, Op Integer, Op Integer, Op Integer)]
opsv = do
    a <- ops
    b <- ops
    c <- ops
    d <- ops
    e <- ops
    return (a,b,c,d,e)

numbers :: [Integer]
numbers = [75,1,3,1,3,6]

combine :: Monad m => m a -> m b -> m (a, b)
combine ops nums = do
    o <- ops
    ns <- nums
    return (o,ns)

display :: Show a5 => ((Op a, Op a1, Op a2, Op a3, Op a4), [a5]) -> [Char]
display ((o1, o2, o3, o4, o5),[a,b,c,d,e,f]) = concat
    $ intersperse " "
    $ [show a, name o1, show b, name o2, show c, name o3, show d, name o4, show e, name o5, show f]

-- The operators have no precedence over each other
calcDiff :: Num a => a -> (Op a, Op a, Op a, Op a, Op a) -> [a] -> a
calcDiff target ((Op _ o1),(Op _ o2),(Op _ o3),(Op _ o4),(Op _ o5)) [a,b,c,d,e,f] =
    abs $ ((-) target) $ a `o1` b `o2` c `o3` d `o4` e `o5` f

-- > solution [75,4,2,2,1,10] 511
-- ("75 Minus 10 Times 2 Minus 2 Times 4 Minus 1",0)
solution :: [Integer] -> Integer -> ([Char], Integer)
solution nums target = head
    $ sortOn snd
    $ map (\x -> (display x, calcDiff target (fst x) (snd x))) (combine opsv $ permutations nums)

