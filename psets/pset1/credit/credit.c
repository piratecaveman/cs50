#include <stdio.h>
#include <cs50.h>
#include <math.h>

int main()
{
    /* long long int to store big numbers upto 19 digits are required */
    unsigned long long int number, working_copy;
    
    /* getting input */
    do
    {
        number = get_long("Number: ");
    }
    while (number < 0);

    /* making a copy to work on */
    working_copy = number;

    /**
     * pass - pass the digit (1) or act on it (0)
     * lenght - calculate the length of the number
     * sum - sum of the digits
     * digit - store current digit
    */
    int pass, length, sum, digit;
    length = sum = 0;
    pass = 1;
    
    /* Traversing throught the digits */
    while (working_copy > 1)
    {
        /* skipping every second number */
        if (pass == 0)
        {   
            /* extracting the last digit */
            digit = 2 * (working_copy % 10);

            /**
             * if the digit is bigger than 10 add the sum of its digits
             * which conveniently so happends to be digit - 9
             * eg. 12 -> 1 + 2 = 3 = 12 - 9
            */
            if (digit >= 10)
            {
                digit = digit - 9;
            }

            /* summming it up */
            sum = sum + digit;
            /* resetting the variable */
            pass = 1;
        }

        /* the skipped digit */
        else
        {
            /* extracting the digit */
            digit = working_copy % 10;
            /* adding it to the sum */
            sum = sum + digit;
            /* resetting the variable */
            pass = 0;
        }

        /* trimming the last digit */
        length = length + 1;
        working_copy = working_copy / 10;
    }
    
    /* sum of the digits is now obtained and its time to evaluate */
    if ((sum % 10) == 0)
    {
        /* ascertain the lenghth of number is between limits */
        if ((length >= 13) && (length <= 19))
        {
            /* extracting the first two digits */
            unsigned long long int factor;
            factor = pow(10, length - 1);
            
            /* this should be pretty self explanatory */
            int first_digit = number / factor;
            int first_two = number / (factor / 10);
            
            /* visa cards begin with a 4 */
            if (first_digit == 4)
            {
                printf("VISA\n");
            }
            /* American express cards begin with either 34 or 37 */
            else if ((first_two == 34) || (first_two == 37))
            {
                printf("AMEX\n");
            }
            /* Mastercard begins between 51 to 55 */
            else if ((first_two >= 51) && (first_two <= 55))
            {
                printf("MASTERCARD\n");
            }
            /* else it is invalid */
            else
            {
                printf("INVALID\n");
            }
        }
        /* all numbers are between 13 and 19 digits in lenght (inclusive) */
        else
        {
            printf("INVALID\n");
        }
    }
    /* if sum is not a multiple of 10 then it must be invalid */
    else
    {
        printf("INVALID\n");
    }
    
    /* a tradition once formed ...*/
    return 0;
}