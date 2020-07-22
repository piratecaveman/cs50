#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    /* the first argument is always the program name - second is what user inputs */
    if (argc != 2)
    {
        printf("Usage: ./recover [file name]\n");
        return 1;
    }

    /* creating a file object pointer to access the file */
    FILE *file = fopen(argv[1], "r");
    
}
