%option noyywrap

%{
// Avoid error "error: `fileno' was not declared in this scope"
extern "C" int fileno(FILE *stream);

#include "maths_parser.tab.hpp" //need to commnet out this line
%}
ß
%%

[*]    { return T_MUL; }
[/]    { return T_DIV;}
[+]    { return T_ADD; }
[\^]    { return T_EXPONENT; }
[-]    { return T_SUB; }
[%]    { return T_MOD; } //CHECK
[=]    { return T_EQ; }
[>]    { return T_LT; }
[<]    { return T_GT; } //there are more logical+arithmetic operations to add in. not sure whether +=, *= etc. are worth having as terminals  
[(]    { return T_LRBRACKET; }
[)]    { return T_RRBRACKET; }
[{]    { return T_LCBRACKET; }
[}]    { return T_RCBRACKET; }
[;]    { return T_SEMICOLON; } //need to think about how we parse the semicolons and interpret the end of lines etc.


//need to comment out the following lines:
log             { return T_LOG; }
exp             { return T_EXP; }
sqrt            { return T_SQRT; }


if    { return T_IF; }
else    { return T_ELSE; }
void    {return T_VOID;}
int    {return T_INT;}
bool    {return T_BOOL;} //there's probably more of these, add them in
while    {return T_WHILE;} //what about semicolons? how does the compiler interpret the lines correctly + using the semicolon

[0-9]+    {yylval.number=strtod(yytext,0); return T_INTEGER;}
[0-9]+([.][0-9]*)?    { yylval.number=strtod(yytext, 0); return T_DECIMAL; }
[A-Za-z]+    { yylval.string=new std::string(yytext); return T_VARIABLE; }

[ \t\r\n]+    {;} //do we want to skip this or could it be useful information for the parser?

.               { fprintf(stderr, "Invalid token\n"); exit(1); }


%%

void yyerror (char const *s)
{
  std::cout << "parse error: " << yytext << std::endl;
  std::cout << "line " << (row + 1) << ", column " << (column + 1 - strlen(yytext)) << std::endl;
  exit(1);
}