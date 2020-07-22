#include <stdio.h>
#include <cs50.h>

int main()
{
    /**
     * height - store height
     * cs50.h - provides get_int()
    */
    int height = 0;

    /* get hight until meets requirements */
    do
    {
        height = get_int("Height: ");
    }
    while ((height > 8) || (height < 1));

    /**
     * row 1 -> height - 1 spaces, 1 hashes
     * row 2 -> height - 2 spaces, 2 hashes
     * row n -> height - n spaces, n hashes
    */

    /* The Pyramid begins here */
    for (int i = 0; i < height; i++)
    {
        /**
         * The spaces part
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

        /* each line ends here */
        printf("\n");
    }

    /* returning integer */
    return 0;
}
