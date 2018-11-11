%{
#include "cal2.tab.h"
%}


%%
"("|")"|"+"|"-"|"*"|"^"|"/"|"!" { return yytext[0]; }
"sqrt" { return SQRT; }
"sin" { return SIN; }
"cos" { return COS; }
"tan" { return TAN; }
[0-9]+|[0-9]*\.[0-9*] { yylval.num = atof(yytext); return NUMBER; }
\n     { return EOL; }
[ \t]  { /* ignore whitespace */ }
.      { printf("Mystery character %c\n", *yytext); }
%%
