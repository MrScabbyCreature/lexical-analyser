%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int fact(int aa);
//double num;
%}


%union {
    double num;
}

/*
 * declare tokens
 */

/*%type<num> exp calclist operand trig_function function;*/
%token NUMBER
/* %token ADD SUB MUL POW DIV FACT*/
%token SQRT
%token SIN COS TAN
/* %token<num> OPara CPara */
%token EOL


/* Precedence Order */
%left '+' '-' '*' '/'


%%
calclist:
     exp
    | calclist exp EOL { $<num>$ = $<num>2; printf("\n\n");}
;

exp:
    | sum
;

sum:
     product
    | sum '+' sum { $<num>$ = $<num>1 + $<num>3; printf("ADD %f + %f = %f \n", $<num>1, $<num>3, $<num>$);}
    | sum '-' sum { $<num>$ = $<num>1 - $<num>3; printf("SUB %f - %f = %f \n", $<num>1, $<num>3, $<num>$); }
;

product:
       exponent
      | product '*' product { $<num>$ = $<num>1 * $<num>3; printf("MUL %f * %f = %f \n", $<num>1, $<num>3, $<num>$);}
      | product '/' product { if ($<num>3 == 0) { yyerror("Cannot divide by zero"); exit(1); } else $<num>$ = $<num>1 / $<num>3; printf("DIV %f * %f = %f \n", $<num>1, $<num>3, $<num>$);}
;

exponent:
       factorial
      | exponent '^' exponent { $<num>$ = pow($<num>1, $<num>3); printf("EXP %f ^ %f = %f \n", $<num>1, $<num>3, $<num>$);}
;

factorial:
       brackets
      | factorial '!' { $<num>$ = fact($<num>1); printf("FACT %f! = %f \n", $<num>1, $<num>$); }
;

brackets:
       operand
      | function
      | '(' exp ')' { $<num>$ = $<num>2; }
;


function:
     SQRT '(' exp ')' { $<num>$ = sqrt($<num>3); printf("Square root of %f is %f\n", $<num>3, $<num>$); }
    | SIN '(' exp ')' { $<num>$ = sin($<num>3); printf("SIN %f\n", $<num>$); }
    | COS '(' exp ')' { $<num>$ = cos($<num>3); printf("COS %f\n", $<num>$);  }
    | TAN '(' exp ')' { $<num>$ = tan($<num>3); printf("TAN %f\n", $<num>$); }
;

operand:
    NUMBER { $<num>$ = $<num>1; }
;
%%
int fact(int aa);
int main(int argc, char **argv)
{
  yyparse();
}
int temp[100];
int fact(int aa) {

    if (aa == 0 || aa == 1) {
        return 1;
    } else {
        if (temp[aa] != 0)
            return temp[aa];
        else
            return temp[aa] = (aa * fact(aa - 1));
    }

}

int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
