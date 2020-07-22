#include <stdio.h>
#include <cs50.h>
#include <stdlib.h>


/* a function o do the conversion */
char convert(char character, int key);


/**
 * argc - argument count - number of arguents provided
 * argv - arguments themselves - in string form
 * stdlib - provides atoi (ascii to integer)
*/
int main(int argc, string argv[])
{
    /**
     * the first argument supplied is always the name of the program
     * hence if a real argument exists it must be at position 2
    */
    if (argc != 2)
    {
        /* simply return with an error code */
        printf("Usage; ./caesar key\n");
        return 1;
    }
    /* iterate through the argument to check the key */
    int i = 0;
    while (argv[1][i] != '\0')
    {
        /* is not a number */
        if ((argv[1][i] < '0') || (argv[1][i] > '9'))
        {
            printf("Usage: ./caesar key\n");
            return 1;
        }
        /* don't forget to increment it */
        i = i + 1;
    }
    /* above loop ensured that the key is a number */
    /* converting it to an integer */
    int key = atoi(argv[1]);

    /* getting user input */
    string plaintext = get_string("plaintext: ");
    string ciphertext = plaintext;

    /* looping through the string to transform it */
    i = 0;
    while (plaintext[i] != '\0')
    {
        /* calling the function that transforms */
        ciphertext[i] = convert(plaintext[i], key);
        /* don't forget to increment it */
        i = i + 1;
    }

    /* displaying the results */
    printf("ciphertext: %s\n", ciphertext);

    /* the traitions speak */
    return 0;
}

/* function definition */ 
char convert(char character, int key)
{
    /* if there is no need for conversion */
    if (key %  26 == 0)
    {
        return character;
    }

    /* actual conversion - for lower case */
    if ((character >= 'a') && (character <= 'z'))
    {
        /**
         * base + key = new alphabet
         * but we treat it as integers
         * a = 97 (so subtracting 96 because we want to keep a itself)
         * we don't want the 96 to meddle when we round up the character around
         * hence we subtract it                                                                      
        */
        int converted = character + key - 96;
        /* all characters are encompassed within 26 letters */
        /* if our output is greater than that - we need to cyclicaly restore it */
        if (converted > 26)
        {
            /* if not subtracted earlier the 96 would cause trouble here */
            converted = converted % 26;
        }
        /* giving back what was once taken */
        converted = converted + 96;
        return converted;
    }

    /* conversion - upper cases */
    else if ((character >= 'A') && (character <= 'Z'))
    {
        /* 
        logic same as above
        A = 65 in integer (ASCII) 
        */
        int converted = character + key - 64;
        /* again the same logic as above */
        if (converted > 26)
        {
            converted = converted % 26;
        }
        /* a debt absolved */
        converted = converted + 64;
        return converted;
    }

    /* else do nothing */
    return character;
}
