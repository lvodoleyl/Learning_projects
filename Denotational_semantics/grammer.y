{
module Parser where

import Lexer
import ToPy
}

%name progFromTokens
%tokentype {Token}
%error {parseError}
%token
  function    {TokenFunc $$}
  begin       {TokenBegin $$}
  end         {TokenEnd $$}
  ":="        {TokenAssign}
  while       {TokenWhile $$}
  operBool    {TokenOperBool $$}
  operInt     {TokenOperInt $$}
  '\n'        {TokenEnter}
  '('         {TokenOB}
  ')'         {TokenCB}
  ','         {TokenComma}
  do          {TokenDo $$}
  for         {TokenFor $$}
  to          {TokenTo}
  step        {TokenStep}
  if          {TokenIf $$}
  main        {TokenMain}
  id          {TokenId $$}
  bigId       {TokenBigId $$}
  return      {TokenReturn $$}
  read        {TokenRead}
  print       {TokenPrint $$}
  numeric     {TokenNum $$}

%%

Prog: Line                                      {Prog [$1]}
  | Line Prog                                   {Prog ($1 : (returnLine $2))}
Line: function bigId '(' Arg ')' '\n'           {Line ("def "++$2++"("++(retPatStr (returnPat $4))++"):\n")}
  | do id ":=" Expr '\n'                        {Line ($1++$2++" = "++(retExprStr $4)++"\n")}
  | return '(' Expr ')' '\n'                    {Line ($1++"return "++(retExprStr $3)++"\n")}
  | for id ":=" Expr to Expr step Expr '\n'     {Line ($1++"for "++$2++" in range("++(retExprStr $4)++", "++(retExprStr $6)++", "++(retExprStr $8)++"):\n")}
  | if Expr operBool Expr '\n'                  {Line ($1++"if "++(retExprStr $2)++$3++(retExprStr $4)++":\n")}
  | while Expr operBool Expr '\n'               {Line ($1++"while "++(retExprStr $2)++$3++(retExprStr $4)++":\n")}
  | print '(' Arg ')' '\n'                      {Line ($1++"print("++(retPatStr (returnPat $3))++")\n")}
  | main '\n'                                   {Line "#MainFunction\n"}
  | begin '\n'                                  {Line ""}
  | end '\n'                                    {Line ""}
  | do bigId '(' Arg ')'                        {Line ($1++$2++"("++(retPatStr (returnPat $4))++")\n")}
  | '\n'                                        {Line "\n"}
Arg: ',' Pat                                    {Arg [$2]}
  | ',' Pat Arg                                 {Arg ($2 : (returnPat $3))}
  | ','                                         {Arg []}
Expr: read '(' ')'                              {Expr "int(input())"}
  | Pat operInt '(' Expr ')'                    {Expr ((retPatSoloStr $1)++$2++"("++(retExprStr $4)++")")}
  | '(' Expr ')' operInt '(' Expr ')'           {Expr ("("++(retExprStr $2)++")"++$4++"("++(retExprStr $6)++")")}
  | '(' Expr ')' operInt Pat                    {Expr ("("++(retExprStr $2)++")"++$4++(retPatSoloStr $5))}
  | Pat                                         {Expr (retPatSoloStr $1)}
  | '(' Expr ')'                                {Expr ("("++(retExprStr $2)++")")}
  | Pat operInt Pat                             {Expr ((retPatSoloStr $1)++$2++(retPatSoloStr $3))}
--  | Pat operInt Expr                            {Expr ((retPatSoloStr $1)++$2++(retExprStr $3))}
Pat : id                                        {Pat $1}
  | numeric                                     {Pat $1}
  | bigId '(' Arg ')'                           {Pat ($1++"("++(retPatStr (returnPat $3))++")")}

{
main :: IO ()
main = do
  code <- readFile "lab3.txt"
  res <- return $ progFromTokens (Lexer.lexer code "")
  writeFile "lab3.py" (showProg (returnLine res))
}
