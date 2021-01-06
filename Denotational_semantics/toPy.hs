module ToPy where

data Prog = Prog [Line] deriving Show
data Line = Line String deriving Show
data Expr = Expr String deriving Show
data Pat = Pat String deriving Show
data Arg = Arg [Pat] deriving Show

showProg :: [Line] -> String
showProg [] = ""
showProg ((Line l):t) = l++(showProg t)

returnLine :: Prog -> [Line]
returnLine (Prog a) = a

returnPat :: Arg -> [Pat]
returnPat (Arg a) = a

retPatStr :: [Pat] -> String
retPatStr [] = ""
retPatStr ((Pat a):[]) = a
retPatStr ((Pat a):t) = a++", "++(retPatStr t)

retExprStr :: Expr -> String
retExprStr (Expr l) = l
retExprStr _ = ""

retPatSoloStr :: Pat -> String
retPatSoloStr (Pat l) = l
retPatSoloStr _ = ""
