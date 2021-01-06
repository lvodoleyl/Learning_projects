{-# OPTIONS_GHC -w #-}
module Parser where

import Lexer
import ToPy
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn t4 t5 t6 t7 t8
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,131) ([38656,10648,38656,10648,0,0,0,1024,32768,0,32768,0,0,22017,0,0,0,1536,0,512,0,22017,32768,0,0,1,0,1,0,0,38656,10648,0,0,0,4,0,22017,0,0,8192,0,16384,0,0,22017,0,0,0,1,0,1,0,0,2048,0,2048,0,0,1,8192,0,0,0,0,0,0,1,0,4,0,22017,0,4,0,22017,0,22017,0,2,0,4,0,2,0,17921,0,22017,0,2,0,2,0,17920,0,4,32768,0,32768,0,32768,0,0,0,0,22017,16384,0,0,2,0,0,0,32,32768,0,0,2,32768,0,0,2,32768,0,0,0,0,0,0,0,0,22017,0,0,0,17921,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,22017,0,64,0,0,0,22017,0,2,0,0,32768,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_progFromTokens","Prog","Line","Arg","Expr","Pat","function","begin","end","\":=\"","while","operBool","operInt","'\\n'","'('","')'","','","do","for","to","step","if","main","id","bigId","return","read","print","numeric","%eof"]
        bit_start = st * 32
        bit_end = (st + 1) * 32
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..31]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (9) = happyShift action_3
action_0 (10) = happyShift action_4
action_0 (11) = happyShift action_5
action_0 (13) = happyShift action_6
action_0 (16) = happyShift action_7
action_0 (20) = happyShift action_8
action_0 (21) = happyShift action_9
action_0 (24) = happyShift action_10
action_0 (25) = happyShift action_11
action_0 (28) = happyShift action_12
action_0 (30) = happyShift action_13
action_0 (4) = happyGoto action_14
action_0 (5) = happyGoto action_15
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (9) = happyShift action_3
action_1 (10) = happyShift action_4
action_1 (11) = happyShift action_5
action_1 (13) = happyShift action_6
action_1 (16) = happyShift action_7
action_1 (20) = happyShift action_8
action_1 (21) = happyShift action_9
action_1 (24) = happyShift action_10
action_1 (25) = happyShift action_11
action_1 (28) = happyShift action_12
action_1 (30) = happyShift action_13
action_1 (5) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyFail (happyExpListPerState 2)

action_3 (27) = happyShift action_33
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (16) = happyShift action_32
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (16) = happyShift action_31
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (17) = happyShift action_22
action_6 (26) = happyShift action_23
action_6 (27) = happyShift action_24
action_6 (29) = happyShift action_25
action_6 (31) = happyShift action_26
action_6 (7) = happyGoto action_30
action_6 (8) = happyGoto action_21
action_6 _ = happyFail (happyExpListPerState 6)

action_7 _ = happyReduce_14

action_8 (26) = happyShift action_28
action_8 (27) = happyShift action_29
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (26) = happyShift action_27
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (17) = happyShift action_22
action_10 (26) = happyShift action_23
action_10 (27) = happyShift action_24
action_10 (29) = happyShift action_25
action_10 (31) = happyShift action_26
action_10 (7) = happyGoto action_20
action_10 (8) = happyGoto action_21
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (16) = happyShift action_19
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (17) = happyShift action_18
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (17) = happyShift action_17
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (32) = happyAccept
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (9) = happyShift action_3
action_15 (10) = happyShift action_4
action_15 (11) = happyShift action_5
action_15 (13) = happyShift action_6
action_15 (16) = happyShift action_7
action_15 (20) = happyShift action_8
action_15 (21) = happyShift action_9
action_15 (24) = happyShift action_10
action_15 (25) = happyShift action_11
action_15 (28) = happyShift action_12
action_15 (30) = happyShift action_13
action_15 (4) = happyGoto action_16
action_15 (5) = happyGoto action_15
action_15 _ = happyReduce_1

action_16 _ = happyReduce_2

action_17 (19) = happyShift action_46
action_17 (6) = happyGoto action_45
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (17) = happyShift action_22
action_18 (26) = happyShift action_23
action_18 (27) = happyShift action_24
action_18 (29) = happyShift action_25
action_18 (31) = happyShift action_26
action_18 (7) = happyGoto action_44
action_18 (8) = happyGoto action_21
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_10

action_20 (14) = happyShift action_43
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (15) = happyShift action_42
action_21 _ = happyReduce_22

action_22 (17) = happyShift action_22
action_22 (26) = happyShift action_23
action_22 (27) = happyShift action_24
action_22 (29) = happyShift action_25
action_22 (31) = happyShift action_26
action_22 (7) = happyGoto action_41
action_22 (8) = happyGoto action_21
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_25

action_24 (17) = happyShift action_40
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (17) = happyShift action_39
action_25 _ = happyFail (happyExpListPerState 25)

action_26 _ = happyReduce_26

action_27 (12) = happyShift action_38
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (12) = happyShift action_37
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (17) = happyShift action_36
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (14) = happyShift action_35
action_30 _ = happyFail (happyExpListPerState 30)

action_31 _ = happyReduce_12

action_32 _ = happyReduce_11

action_33 (17) = happyShift action_34
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (19) = happyShift action_46
action_34 (6) = happyGoto action_60
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (17) = happyShift action_22
action_35 (26) = happyShift action_23
action_35 (27) = happyShift action_24
action_35 (29) = happyShift action_25
action_35 (31) = happyShift action_26
action_35 (7) = happyGoto action_59
action_35 (8) = happyGoto action_21
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (19) = happyShift action_46
action_36 (6) = happyGoto action_58
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (17) = happyShift action_22
action_37 (26) = happyShift action_23
action_37 (27) = happyShift action_24
action_37 (29) = happyShift action_25
action_37 (31) = happyShift action_26
action_37 (7) = happyGoto action_57
action_37 (8) = happyGoto action_21
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (17) = happyShift action_22
action_38 (26) = happyShift action_23
action_38 (27) = happyShift action_24
action_38 (29) = happyShift action_25
action_38 (31) = happyShift action_26
action_38 (7) = happyGoto action_56
action_38 (8) = happyGoto action_21
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (18) = happyShift action_55
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (19) = happyShift action_46
action_40 (6) = happyGoto action_54
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (18) = happyShift action_53
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (17) = happyShift action_52
action_42 (26) = happyShift action_23
action_42 (27) = happyShift action_24
action_42 (31) = happyShift action_26
action_42 (8) = happyGoto action_51
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (17) = happyShift action_22
action_43 (26) = happyShift action_23
action_43 (27) = happyShift action_24
action_43 (29) = happyShift action_25
action_43 (31) = happyShift action_26
action_43 (7) = happyGoto action_50
action_43 (8) = happyGoto action_21
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (18) = happyShift action_49
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (18) = happyShift action_48
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (26) = happyShift action_23
action_46 (27) = happyShift action_24
action_46 (31) = happyShift action_26
action_46 (8) = happyGoto action_47
action_46 _ = happyReduce_17

action_47 (19) = happyShift action_46
action_47 (6) = happyGoto action_72
action_47 _ = happyReduce_15

action_48 (16) = happyShift action_71
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (16) = happyShift action_70
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (16) = happyShift action_69
action_50 _ = happyFail (happyExpListPerState 50)

action_51 _ = happyReduce_24

action_52 (17) = happyShift action_22
action_52 (26) = happyShift action_23
action_52 (27) = happyShift action_24
action_52 (29) = happyShift action_25
action_52 (31) = happyShift action_26
action_52 (7) = happyGoto action_68
action_52 (8) = happyGoto action_21
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (15) = happyShift action_67
action_53 _ = happyReduce_23

action_54 (18) = happyShift action_66
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_18

action_56 (22) = happyShift action_65
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (16) = happyShift action_64
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (18) = happyShift action_63
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (16) = happyShift action_62
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (18) = happyShift action_61
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (16) = happyShift action_77
action_61 _ = happyFail (happyExpListPerState 61)

action_62 _ = happyReduce_8

action_63 _ = happyReduce_13

action_64 _ = happyReduce_4

action_65 (17) = happyShift action_22
action_65 (26) = happyShift action_23
action_65 (27) = happyShift action_24
action_65 (29) = happyShift action_25
action_65 (31) = happyShift action_26
action_65 (7) = happyGoto action_76
action_65 (8) = happyGoto action_21
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_27

action_67 (17) = happyShift action_75
action_67 (26) = happyShift action_23
action_67 (27) = happyShift action_24
action_67 (31) = happyShift action_26
action_67 (8) = happyGoto action_74
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (18) = happyShift action_73
action_68 _ = happyFail (happyExpListPerState 68)

action_69 _ = happyReduce_7

action_70 _ = happyReduce_5

action_71 _ = happyReduce_9

action_72 _ = happyReduce_16

action_73 _ = happyReduce_19

action_74 _ = happyReduce_21

action_75 (17) = happyShift action_22
action_75 (26) = happyShift action_23
action_75 (27) = happyShift action_24
action_75 (29) = happyShift action_25
action_75 (31) = happyShift action_26
action_75 (7) = happyGoto action_79
action_75 (8) = happyGoto action_21
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (23) = happyShift action_78
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_3

action_78 (17) = happyShift action_22
action_78 (26) = happyShift action_23
action_78 (27) = happyShift action_24
action_78 (29) = happyShift action_25
action_78 (31) = happyShift action_26
action_78 (7) = happyGoto action_81
action_78 (8) = happyGoto action_21
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (18) = happyShift action_80
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_20

action_81 (16) = happyShift action_82
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_6

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Prog [happy_var_1]
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Prog (happy_var_1 : (returnLine happy_var_2))
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happyReduce 6 5 happyReduction_3
happyReduction_3 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenBigId happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Line ("def "++happy_var_2++"("++(retPatStr (returnPat happy_var_4))++"):\n")
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 5 5 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	(HappyTerminal (TokenDo happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Line (happy_var_1++happy_var_2++" = "++(retExprStr happy_var_4)++"\n")
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 5 5 happyReduction_5
happyReduction_5 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenReturn happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Line (happy_var_1++"return "++(retExprStr happy_var_3)++"\n")
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 9 5 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenId happy_var_2)) `HappyStk`
	(HappyTerminal (TokenFor happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Line (happy_var_1++"for "++happy_var_2++" in range("++(retExprStr happy_var_4)++", "++(retExprStr happy_var_6)++", "++(retExprStr happy_var_8)++"):\n")
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 5 5 happyReduction_7
happyReduction_7 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	(HappyTerminal (TokenOperBool happy_var_3)) `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	(HappyTerminal (TokenIf happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Line (happy_var_1++"if "++(retExprStr happy_var_2)++happy_var_3++(retExprStr happy_var_4)++":\n")
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 5 5 happyReduction_8
happyReduction_8 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	(HappyTerminal (TokenOperBool happy_var_3)) `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	(HappyTerminal (TokenWhile happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Line (happy_var_1++"while "++(retExprStr happy_var_2)++happy_var_3++(retExprStr happy_var_4)++":\n")
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 5 5 happyReduction_9
happyReduction_9 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenPrint happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Line (happy_var_1++"print("++(retPatStr (returnPat happy_var_3))++")\n")
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_2  5 happyReduction_10
happyReduction_10 _
	_
	 =  HappyAbsSyn5
		 (Line "#MainFunction\n"
	)

happyReduce_11 = happySpecReduce_2  5 happyReduction_11
happyReduction_11 _
	_
	 =  HappyAbsSyn5
		 (Line ""
	)

happyReduce_12 = happySpecReduce_2  5 happyReduction_12
happyReduction_12 _
	_
	 =  HappyAbsSyn5
		 (Line ""
	)

happyReduce_13 = happyReduce 5 5 happyReduction_13
happyReduction_13 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenBigId happy_var_2)) `HappyStk`
	(HappyTerminal (TokenDo happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Line (happy_var_1++happy_var_2++"("++(retPatStr (returnPat happy_var_4))++")\n")
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_1  5 happyReduction_14
happyReduction_14 _
	 =  HappyAbsSyn5
		 (Line "\n"
	)

happyReduce_15 = happySpecReduce_2  6 happyReduction_15
happyReduction_15 (HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (Arg [happy_var_2]
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  6 happyReduction_16
happyReduction_16 (HappyAbsSyn6  happy_var_3)
	(HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (Arg (happy_var_2 : (returnPat happy_var_3))
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  6 happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn6
		 (Arg []
	)

happyReduce_18 = happySpecReduce_3  7 happyReduction_18
happyReduction_18 _
	_
	_
	 =  HappyAbsSyn7
		 (Expr "int(input())"
	)

happyReduce_19 = happyReduce 5 7 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenOperInt happy_var_2)) `HappyStk`
	(HappyAbsSyn8  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Expr ((retPatSoloStr happy_var_1)++happy_var_2++"("++(retExprStr happy_var_4)++")")
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 7 7 happyReduction_20
happyReduction_20 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenOperInt happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Expr ("("++(retExprStr happy_var_2)++")"++happy_var_4++"("++(retExprStr happy_var_6)++")")
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 5 7 happyReduction_21
happyReduction_21 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyTerminal (TokenOperInt happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Expr ("("++(retExprStr happy_var_2)++")"++happy_var_4++(retPatSoloStr happy_var_5))
	) `HappyStk` happyRest

happyReduce_22 = happySpecReduce_1  7 happyReduction_22
happyReduction_22 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (Expr (retPatSoloStr happy_var_1)
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  7 happyReduction_23
happyReduction_23 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (Expr ("("++(retExprStr happy_var_2)++")")
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  7 happyReduction_24
happyReduction_24 (HappyAbsSyn8  happy_var_3)
	(HappyTerminal (TokenOperInt happy_var_2))
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (Expr ((retPatSoloStr happy_var_1)++happy_var_2++(retPatSoloStr happy_var_3))
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  8 happyReduction_25
happyReduction_25 (HappyTerminal (TokenId happy_var_1))
	 =  HappyAbsSyn8
		 (Pat happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  8 happyReduction_26
happyReduction_26 (HappyTerminal (TokenNum happy_var_1))
	 =  HappyAbsSyn8
		 (Pat happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happyReduce 4 8 happyReduction_27
happyReduction_27 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenBigId happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (Pat (happy_var_1++"("++(retPatStr (returnPat happy_var_3))++")")
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 32 32 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenFunc happy_dollar_dollar -> cont 9;
	TokenBegin happy_dollar_dollar -> cont 10;
	TokenEnd happy_dollar_dollar -> cont 11;
	TokenAssign -> cont 12;
	TokenWhile happy_dollar_dollar -> cont 13;
	TokenOperBool happy_dollar_dollar -> cont 14;
	TokenOperInt happy_dollar_dollar -> cont 15;
	TokenEnter -> cont 16;
	TokenOB -> cont 17;
	TokenCB -> cont 18;
	TokenComma -> cont 19;
	TokenDo happy_dollar_dollar -> cont 20;
	TokenFor happy_dollar_dollar -> cont 21;
	TokenTo -> cont 22;
	TokenStep -> cont 23;
	TokenIf happy_dollar_dollar -> cont 24;
	TokenMain -> cont 25;
	TokenId happy_dollar_dollar -> cont 26;
	TokenBigId happy_dollar_dollar -> cont 27;
	TokenReturn happy_dollar_dollar -> cont 28;
	TokenRead -> cont 29;
	TokenPrint happy_dollar_dollar -> cont 30;
	TokenNum happy_dollar_dollar -> cont 31;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 32 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
progFromTokens tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


main :: IO ()
main = do
  code <- readFile "lab3.txt"
  let res = progFromTokens (Lexer.lexer code "")
  writeFile "lab3.py" (showProg (returnLine res))
{-# LINE 1 "templates\GenericTemplate.hs" #-}
{-# LINE 1 "templates\\\\GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "D:/GitHub/haskell-platform/build/ghc-bindist/local/lib/include/ghcversion.h" #-}















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "F:/Users/randy/AppData/Local/Temp/ghc1900_0/ghc_2.h" #-}


























































































































































































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates\\\\GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates\\\\GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates\\\\GenericTemplate.hs" #-}

{-# LINE 75 "templates\\\\GenericTemplate.hs" #-}

{-# LINE 84 "templates\\\\GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates\\\\GenericTemplate.hs" #-}

{-# LINE 147 "templates\\\\GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates\\\\GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates\\\\GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
