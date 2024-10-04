#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

void my_signal(int sig)
{
    if (sig == SIGTERM) {
        printf("\nПолучен сигнал SIGTERM. Завершение работы.\n");
        fflush(stdout);
        exit(0);
    } else if (sig == SIGINT) {
        printf("\nПолучен сигнал SIGINT. Завершение работы.\n");
        fflush(stdout);
        exit(0);
    }
}

int main()
{
    signal(SIGINT, my_signal);
    signal(SIGTERM, my_signal);

    printf("Стартуем и выполняемся.\n");
    fflush(stdout);

    while (1) {
        sleep(1);
    }

    return 0;
}
