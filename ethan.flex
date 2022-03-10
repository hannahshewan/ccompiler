%option noyywrap

%{
extern "C" int fileno(FILE *stream);

%}

%%


else { return T_ELSE; }
if {  return T_IF; }
int {  return T_INT; }
while { count(); return T_WHILE; }

"+" { return T_ADD; }
"-" { return T_SUB; }
"*" { return T_MUL; }
"/" { return T_DIV; }
"%" { return T_MOD; }
"<<" { return T_LSHIFT; }
">>" { return T_RSHIFT; }

"<" { return T_LESS_THAN; }
">" { return T_GREATER_THAN; }
"<=" { return T_LESS_THAN_EQ; }
">=" { return T_GREATER_THAN_EQ; }
"==" { return T_EQ_EQ; }
"!=" { return T_NOT_EQ; }
"&" { return T_AND; }
"&&" { return T_AND_AND; }
"|" { return T_OR; }
"||" { return T_OR_OR; }
"^" { return T_XOR; }

"=" { return T_EQ; }
"+=" { return T_PLUS_EQ; }
"-=" { return T_MINUS_EQ; }
"*=" { return T_MULTIPLY_EQ; }
"/=" { return T_DIVIDE_EQ; }
"%=" { return T_MODULO_EQ; }
"&=" { return T_AND_EQ; }
"|=" { return T_OR_EQ; }
"^=" { return T_XOR_EQ; }
"<<=" { return T_LSHIFT_EQ; }
">>=" { return T_RSHIFT_EQ; }

";" {  return T_SEMICOLON; }


"(" { return T_LRBRACKET; }
")" { return T_RRBRACKET; }
"{" { return T_LCBRACKET; }
"}" { return T_RCBRACKET; }

"!" { return T_NOT; }
"++" { return T_PLUS_PLUS; }
"--" { return T_MINUS_MINUS; }

[ \t\v\n\f]		{ }
.			{ }

%%



void yyerror (char const *s)
{
  fprintf(stderr,"Parse error : %s\n", s);
 
  exit(1);
}
