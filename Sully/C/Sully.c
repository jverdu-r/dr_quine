#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <string.h>
#include <sys/wait.h>

#define NEWLINE 10
#define DQUOTE 34

int compile(char *input, char *output);
int run(char *filename);

int main(void)
{
    char input[] = "Sully_X.c";
    char output[] = "Sully_X";
    int x = 5;

    if (strstr(__FILE__, "Sully.c") == NULL)
        x--;
    input[6] = output[6] = '0' + x;

    if (x < 0)
        return 0;
    FILE *f = fopen(input, "w");
    if (!f)
        return 1;
    char *model = "#include <stdio.h>%1$c#include <stdlib.h>%1$c#include <unistd.h>%1$c#include <sys/types.h>%1$c#include <string.h>%1$c#include <sys/wait.h>%1$c%1$c#define NEWLINE 10%1$c#define DQUOTE 34%1$c%1$cint compile(char *input, char *output);%1$cint run(char *filename);%1$c%1$cint main(void)%1$c{%1$c    char input[] = %2$cSully_X.c%2$c;%1$c    char output[] = %2$cSully_X%2$c;%1$c    int x = %4$d;%1$c%1$c    if (strstr(__FILE__, %2$cSully.c%2$c) == NULL)%1$c        x--;%1$c    input[6] = output[6] = '0' + x;%1$c%1$c    if (x < 0)%1$c        return 0;%1$c    FILE *f = fopen(input, %2$cw%2$c);%1$c    if (!f)%1$c        return 1;%1$c    char *model = %2$c%3$s%2$c;%1$c    fprintf(f, model, NEWLINE, DQUOTE, model, x);%1$c    fclose(f);%1$c    if (compile(input, output) != EXIT_SUCCESS)%1$c        return 2;%1$c    return run(output);%1$c}%1$c%1$cint compile(char *input, char *output)%1$c{%1$c    char compiler_path[] = %2$c/usr/bin/cc%2$c;%1$c    if (!input)%1$c        return EXIT_FAILURE;%1$c%1$c    pid_t pid = fork();%1$c    if (pid < 0)%1$c        return EXIT_FAILURE;%1$c    if (pid == 0)%1$c        return execlp(compiler_path, compiler_path, input, %2$c-o%2$c, output, NULL);%1$c    int status;%1$c    waitpid(pid, &status, 0);%1$c    if (WIFEXITED(status) && WEXITSTATUS(status) == 0)%1$c        return EXIT_SUCCESS;%1$c    return EXIT_FAILURE;%1$c}%1$c%1$cint run(char *filename)%1$c{%1$c    pid_t pid;%1$c    int status;%1$c    char path[256];%1$c    if (!filename)%1$c        return EXIT_FAILURE;%1$c    snprintf(path, sizeof(path), %2$c./%%s%2$c, filename);%1$c    pid = fork();%1$c    if (pid < 0)%1$c        return EXIT_FAILURE;%1$c    if (pid == 0) {%1$c        execlp(path, path, NULL);%1$c        _exit(127);%1$c    }%1$c    waitpid(pid, &status, 0);%1$c    if (WIFEXITED(status))%1$c        return WEXITSTATUS(status);%1$c    return EXIT_FAILURE;%1$c}%1$c";
    fprintf(f, model, NEWLINE, DQUOTE, model, x);
    fclose(f);
    if (compile(input, output) != EXIT_SUCCESS)
        return 2;
    return run(output);
}

int compile(char *input, char *output)
{
    char compiler_path[] = "/usr/bin/cc";
    if (!input)
        return EXIT_FAILURE;

    pid_t pid = fork();
    if (pid < 0)
        return EXIT_FAILURE;
    if (pid == 0)
        return execlp(compiler_path, compiler_path, input, "-o", output, NULL);
    int status;
    waitpid(pid, &status, 0);
    if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
        return EXIT_SUCCESS;
    return EXIT_FAILURE;
}

int run(char *filename)
{
    pid_t pid;
    int status;
    char path[256];
    if (!filename)
        return EXIT_FAILURE;
    snprintf(path, sizeof(path), "./%s", filename);
    pid = fork();
    if (pid < 0)
        return EXIT_FAILURE;
    if (pid == 0) {
        execlp(path, path, NULL);
        _exit(127); /* exec failed */
    }
    waitpid(pid, &status, 0);
    if (WIFEXITED(status))
        return WEXITSTATUS(status);
    return EXIT_FAILURE;
}