#include <stdio.h>
#include <cs50.h>
#include <stdlib.h>

char convert(char base, string key);
int is_capital(char base);

/**
 * argc - argument count - number of arguments
 * argv - array of strings - the arguments as strings
 * argv[0] - the name of the program
*/
int main(int argc, string argv[])
{
    /* checking for argument */
    if (argc != 2)
    {
        /* not acceptable arguments - just simply exit */
        printf("Usage: ./substitution key\n");
        return 1;
    }

    /* checking the arguments */
    int i = 0;
    /* check to the end of the string */
    while (argv[1][i] != '\0')
    {
        /* if it is simply not an alphabet */
        if ((argv[1][i] > 'z') || (argv[1][i] < 'A'))
        {
            printf("Usage: ./substitution key\n");
            return 1;
        }
        /* between Z and 'a' there are no alpabets */
        else if ((argv[1][i] > 'Z') && (argv[1][i] < 'a'))
        {
            printf("Usage: ./substitution key\n");
            return 1;
        }
        /* else do nothing */

        /* don't forget to increment it */
        i = i + 1;
    }
    printf("%i\n", i);

    /* key's length check */
    if (i != 26)
    {
        printf("Key must contain 26 characters.\n");
        return 1;
    }

    /* checking for duplicates in the key */
    /* for each character in the key - */
    for (i = 0; i < 26; i = i + 1)
    {
        /* - check all the characters to the right of it */
        for (int j = i + 1; j < 26; j = j + 1)
        {
            /* if the character matches to any other */
            if (argv[1][j] == argv[1][i])
            {
                /* reject the key */
                printf("Duplicate characters in the key\n");
                return 1;
            }
            /* else do nothing */
        }
    }

    /* all key tests have been completed */
    string key = argv[1];

    /* get plaintext - using get_sring provided by cs50 library */
    string plaintext = get_string("plaintext: ");
    /* placeholder for cipher text which matches plaintext exactly */
    string ciphertext = plaintext;

    /* now to merely run the loop */
    i = 0;
    while (plaintext[i] != '\0')
    {   
        /* and convert it */
        ciphertext[i] = convert(plaintext[i], key);
        /* don't you forget to increment it */
        i = i + 1;
    }
    /* show off the result */
    printf("ciphertext: %s\n", ciphertext);

    /* tradition */
    return 0;
}

/* a simple function that converts the given character based on key provided */
char convert(char base, string key)
{
    int converted;
    /* if lowercase character */
    if (is_capital(base) == 0)
    {
        /* substitute it with the one in key */
        converted = key[base - 97];
        /* if it becomes uppercase after substitutution */
        if (is_capital(converted) == 1)
        {
            /* Z = 65 and 'a' = 97 ==> 97-65 = 32 is the difference */
            /* if we add the 32 it converts to lowercase */
            converted = converted + 32;
        }
        /* return once the job is done */
        return converted;
    }
    /* else if it is uppercase */
    else if (is_capital(base) == 1)
    {
        /* substituting it with character from a key */
        converted = key[base - 65];
        /* restore the original case if changed */
        if (is_capital(converted) == 0)
        {
            /* logic same as above */
            converted = converted - 32;
        }
        /* the job is done */
        return converted;
    }
    /* else return the character as is */
    else
    {
        return base;
    }
}

/* check if it is upper or lower case */
int is_capital(char base)
{
    /* if lowercase */
    if ((base >= 'a') && (base <= 'z'))
    {
        /* return false */
        return 0;
    }
    /* if uppercase */
    else if ((base >= 'A') && (base <= 'Z'))
    {
        /* return true */
        return 1;
    }
    /* otherwise return something unexpected - hehe */
    else
    {
        /* indicates not an alphabet */
        return -1;
    }

}
