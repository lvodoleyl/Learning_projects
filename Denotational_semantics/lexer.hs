module Lexer where
import Data.Char

data Token = TokenAssign | TokenOperBool String
  | TokenOperInt String
  | TokenComma | TokenOB
  | TokenCB | TokenEnter
  | TokenFunc String | TokenBegin String
  | TokenEnd String | TokenWhile String
  | TokenFor String | TokenPrint String
  | TokenRead | TokenTo
  | TokenStep | TokenIf String
  | TokenMain | TokenReturn String
  | TokenId String
  | TokenBigId String
  | TokenNum String
  | TokenDo String
  deriving Show

lexer :: String -> String -> [Token]
lexer [] _ = []
lexer ('>':'=':t) str = TokenOperBool ">=" : lexer t str
lexer ('<':'=':t) str = TokenOperBool "<=" : lexer t str
lexer (':':'=':t) str = TokenAssign : lexer t str
lexer ('>':t) str = TokenOperBool ['>'] : lexer t str
lexer ('<':t) str = TokenOperBool ['<'] : lexer t str
lexer ('=':t) str = TokenOperBool "==" : lexer t str
lexer ('!':'=':t) str = TokenOperBool "!=" : lexer t str
lexer ('+':t) str = TokenOperInt "+" : lexer t str
lexer ('-':t) str = TokenOperInt "-" : lexer t str
lexer ('*':t) str = TokenOperInt "*" : lexer t str
lexer (',':t) str = TokenComma : lexer t str
lexer ('(':t) str = TokenOB : lexer t str
lexer (')':t) str = TokenCB : lexer t str
lexer ('\n':t) str = TokenEnter : lexer t str
lexer (h:t) str
  |isSpace h = lexer t str
  |isAlpha h = checklexem (span isAlpha (h:t)) str
  |isDigit h = checklexem (span isDigit (h:t)) str

checklexem :: (String, String) -> String -> [Token]
checklexem ("function", str) gun = TokenFunc gun: lexer str gun
checklexem ("begin", str) gun = TokenBegin (gun++"    "): lexer str (gun++"    ")
checklexem ("end", str) (' ':' ':' ':' ':t) = TokenEnd t: lexer str t
checklexem ("while", str) gun= TokenWhile gun: lexer str gun
checklexem ("div", str) gun = TokenOperInt "//" : lexer str gun
checklexem ("mod", str) gun = TokenOperInt "%" : lexer str gun
checklexem ("read", str) gun = TokenRead : lexer str gun
checklexem ("print", str) gun = TokenPrint gun: lexer str gun
checklexem ("for", str) gun = TokenFor gun: lexer str gun
checklexem ("to", str) gun = TokenTo : lexer str gun
checklexem ("step", str) gun = TokenStep : lexer str gun
checklexem ("if", str) gun = TokenIf gun: lexer str gun
checklexem ("main", str) gun = TokenMain : lexer str ""
checklexem ("return", str) gun = TokenReturn gun: lexer str gun
checklexem ("do", str) gun = TokenDo gun : lexer str gun
checklexem (id, str) gun
  | isLower (head id) = TokenId id: lexer str gun
  | isDigit (head id) = TokenNum id: lexer str gun
  | otherwise = TokenBigId id: lexer str gun

parseError :: [Token] -> a
parseError p = error (show p)
