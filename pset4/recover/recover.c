#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef uint8_t BYTE;

/* this function determines if the block passed to it is a jpeg header */
int is_jpeg_header(BYTE buffer[]);

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
    /* checking if we got a valid pointer */
    if (file == NULL)
    {
        printf("The file %s could not be opened\n", argv[1]);
        return 1;
    }

    /* this variable will keep track of file name */
    int counter = 0;
    /**
     * this variable will store current file name
     * it typically has three numbers for name and 4 extra characters for extension (. j p g)
    */
    char name[3 * sizeof(int) + 4];
    /* this is the buffer to store a block */
    BYTE buffer[512];
    sprintf(name, "%03i.jpg", counter);
    
    while (!feof(file))
    {
        if (is_jpeg_header(buffer) == 1)
        {
            FILE *picture = fopen(name, "w");
            do
            {
                fwrite(buffer, 512, 1, picture);
                fread(buffer, 512, 1, file);
            }
            while ((is_jpeg_header(buffer) != 1) && !feof(file));
            fclose(picture);
            counter += 1;
            sprintf(name, "%03i.jpg", counter);
            continue;
        }
        fread(buffer, 512, 1, file);
    }
    fclose(file);
}


/* returns 1 if it is a header and 0 otherwise */
int is_jpeg_header(BYTE buffer[])
{
    /**
     * the idea is that first three bytes of a jpeg are always 0xff 0xd8 and 0xff
     * and the fourth byte always begins with 0xe - ie. anything between 0xe0 to 0xef (inclusive)
    */
    if ((buffer[0] == 0xff) && (buffer[1] == 0xd8) && (buffer[2] == 0xff))
    {
        /* do not know much about bitwise operators but this is what was suggested */
        /* essentially it converts the remaining bits to 0 - I do not know how */
        if ((buffer[3] & 0xf0) == 0xe0)
        {
            return 1;
        }
    }
    return 0;
}
