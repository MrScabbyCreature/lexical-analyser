cal2:	cal2.l cal2.y
	bison -d cal2.y
	flex cal2.l
	gcc -g -o $@ cal2.tab.c lex.yy.c -lfl -lm
