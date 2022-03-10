%option noyywrap

%{
extern "C" int fileno(FILE *stream);

#include "maths_parser.tab.hpp" //need to replace this line
%}

%%

"*"    { return T_MUL;}
"/"    { return T_DIV; } 
"+"    { return T_ADD; }
"-"    { return T_SUB; }
"\^"   { return T_EXPONENT; }
"%"    { return T_MOD; } //CHECK
"="    { return T_EQ; }
">"    { return T_LT; }
"<"    { return T_GT; } 
"+="   { return T_ADDEQ; }
"-="   { return T_SUBEQ; }
"*="   { return T_MULEQ; }
"/="   { return T_DIVEQ; }  
"%="   { return T_MODEQ; }
"=="   { return T_ISEQ; }
"!="   { return T_NOTEQ; }
">="   { return T_GTEQ; }
"<="   { return T_LTEQ; }
"&&"   { return T_LOGEQ; }
"||"   { return T_LOGOR; }
"!"    { return T_LOGNOT; }
"&"    { return T_BITAND; }
"|"    { return T_BITOR; }
"^"    { return T_BITXOR; }
"~"    { return T_BITNOT; }
"<<"   { return T_SL; }
">>"   { return T_SR; }

"("    { return T_LRBRACKET; }
")"    { return T_RRBRACKET; }
"{"    { return T_LCBRACKET; }
"}"    { return T_RCBRACKET; }
";"    { return T_SEMICOLON; } //need to think about how we parse the semicolons and interpret the end of lines etc.

"if"    { return T_IF; }
"else"  { return T_ELSE; }

"while" { return T_WHILE; } //what about semicolons? how does the compiler interpret the lines correctly + using the semicolon

"void"  { return T_VOID; }
"int"   { return T_INT; } 
"bool"  { return T_BOOL; } //there's probably more of these, add them in

[0-9]+  { yylval.number=strtod(yytext,0); return T_INTEGER;}
[0-9]+([.][0-9]*)?    { yylval.number=strtod(yytext, 0); return T_DECIMAL; }

[ \t\r\n]+    {;} //do we want to skip this or could it be useful information for the parser?

.             { fprintf(stderr, "Invalid token\n"); exit(1); }


%%

void yyerror (char const *s)
{
  fprintf (stderr, "Parse error : %s\n", s);
  exit(1);
}
