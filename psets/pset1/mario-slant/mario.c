#include <stdio.h>
#include <cs50.h>

int main()
{
    /**
     * height - get height
     * cs50.h - provides get_int()
    */
    int height = 0;

    /* getting input until it meets criteria */
    do
    {
        height = get_int("Height: ");
    }
    while ((height > 8) || (height < 1));

    /* The Pyramid Begins here */
    for (int i = 0; i < height; i++)
    {
        /**
         * The spaces part
         * (height - 1) because nth line has (height - n - 1) spaces
        */
        for (int j = 0; (j < ((height - 1) - i)); j++)
        {
            printf(" ");
        }
        /**
         * The hashes part
         * j = number of # = i + 1 (because i starts at 0)
        */
        for (int j = i + 1; j > 0; j--)
        {
            printf("#");
        }

        /* Printing the space between the pyramids */
        printf("  ");


        /* Mirroring the pyramid */

        /* logic previously used for spaces now prints hashes */
        /* j = number of hashes = simply height - n */
        for (int j = 0; (j < (height - i)); j++)
        {
            printf("#");
        }

        /* Each line ends right here */
        printf("\n");
    }

    /* returning an integer as customs require */
    return 0;
}