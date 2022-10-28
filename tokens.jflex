/*-***
 *
 * This file defines a stand-alone lexical analyzer for a subset of the Pascal
 * programming language.  This is the same lexer that will later be integrated
 * with a CUP-based parser.  Here the lexer is driven by the simple Java test
 * program in ./PascalLexerTest.java, q.v.  See 330 Lecture Notes 2 and the
 * Assignment 2 writeup for further discussion.
 *
 */


import java_cup.runtime.*;


%%
/*-*
 * LEXICAL FUNCTIONS:
 */

%cup
%line
%column
%unicode
%class Lexer

%{

/**
 * Return a new Symbol with the given token id, and with the current line and
 * column numbers.
 */
Symbol newSym(int tokenId) {
    return new Symbol(tokenId, yyline, yycolumn);
}

/**
 * Return a new Symbol with the given token id, the current line and column
 * numbers, and the given token value.  The value is used for tokens such as
 * identifiers and numbers.
 */
Symbol newSym(int tokenId, Object value) {
    return new Symbol(tokenId, yyline, yycolumn, value);
}

%}


/*-*
 * PATTERN DEFINITIONS:
 */


/**
 * Implement patterns as regex here
 */
integer = -?[0-9]+
float = -?[0-9]+\.[0-9]+
id = [a-zA-Z][a-zA-Z0-9]*
letter = [[[^\n]&&[^\t]]&&[[^\\][^\"]]]|\\\\|\\\"
oneLineComment = \\\\[^\n]*\n
multiLineComment = \\\*[[^]|\n]*\*\\
char = \'{letter}\'
string = \"{letter}*\"
whitespace = [ \n\t\r]



%%
/**
 * LEXICAL RULES:
 */
 
class          {return newSym(sym.CLASS, "class");}
"{"            {return newSym(sym.OPENBRACE, "{");}
"}"            {return newSym(sym.CLOSEBRACE, "}");}
";"            {return newSym(sym.SEMI, ";");}
"["            {return newSym(sym.OPENBRACKET, "[");}
"]"            {return newSym(sym.CLOSEBRACKET, "]");}
"("            {return newSym(sym.OPENPAREN, "(");}
")"            {return newSym(sym.CLOSEPAREN, ")");}
final          {return newSym(sym.FINAL, "final");}
void           {return newSym(sym.VOID, "void");}
int            {return newSym(sym.INT, "int");}
char           {return newSym(sym.CHAR, "char");}
bool           {return newSym(sym.BOOL, "bool");}
float          {return newSym(sym.FLOAT, "float");}
","            {return newSym(sym.COMMA, ",");}
if             {return newSym(sym.IF, "if");}
else           {return newSym(sym.ELSE, "else");}
while          {return newSym(sym.WHILE, "while");}
read           {return newSym(sym.READ, "read");}
print          {return newSym(sym.PRINT, "print");}
printline      {return newSym(sym.PRINTLINE, "printline");}
return         {return newSym(sym.RETURN, "return");}
"++"           {return newSym(sym.PLUSPLUS, "++");}
"--"           {return newSym(sym.MINUSMINUS, "--");}
true           {return newSym(sym.TRUE, "true");}
false          {return newSym(sym.FALSE, "false");}
"~"            {return newSym(sym.SQUIGGLY, "~");}
"+"            {return newSym(sym.PLUS, "+");}
"-"            {return newSym(sym.MINUS, "-");}
"*"            {return newSym(sym.MULTIPLY, "*");}
"/"            {return newSym(sym.DIVIDE, "/");}
"=="           {return newSym(sym.EQUALEQUAL, "==");}
">="           {return newSym(sym.GREATEREQUAL, ">=");}
"<="           {return newSym(sym.LESSEQUAL, "<=");}
"<>"           {return newSym(sym.NOTEQUAL, "<>");}
">"            {return newSym(sym.GREATER, ">");}
"<"            {return newSym(sym.LESS, "<");}
"||"           {return newSym(sym.OR, "||");}
"&&"           {return newSym(sym.AND, "&&");}
"="            {return newSym(sym.EQUALS, "=");}
"?"            {return newSym(sym.QUESTION, "?");}
":"            {return newSym(sym.COLON, ":");}
 
{id}           {return newSym(sym.ID, yytext());}
{integer}      {return newSym(sym.INTLIT, new Integer(yytext()));}
{char}         {return newSym(sym.CHARLIT, yytext());}
{string}       {return newSym(sym.STRLIT, yytext());}
{float}        {return newSym(sym.FLOATLIT, new Float(yytext()));}
{oneLineComment}   { /* Ignore */}
{multiLineComment}   { /* Ignore */}

{whitespace}    { /* Ignore whitespace. */ }
.               { System.out.println("Illegal char, '" + yytext() +
                    "' line: " + yyline + ", column: " + yychar); } 