#include <stdio.h>
#define GRACE() do{FILE*f=fopen("Grace_kid.c","w");fprintf(f,SRC,10,34,34,34,34,10,10,34,SRC,34,10,10);fclose(f);}while(0)
#define MAIN int main(){GRACE();return 0;}
#define SRC "#include <stdio.h>%c#define GRACE() do{FILE*f=fopen(%cGrace_kid.c%c,%cw%c);fprintf(f,SRC,10,34,34,34,34,10,10,34,SRC,34,10,10);fclose(f);}while(0)%c#define MAIN int main(){GRACE();return 0;}%c#define SRC %c%s%c%c/* Grace quine that writes to Grace_kid.c */%cMAIN"
/* Grace quine that writes to Grace_kid.c */
MAIN