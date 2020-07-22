#include <stdio.h>
#include <cs50.h>
#include <math.h>

int main()
{
    /* getting user input */
    string text = get_string("Text: ");
    
    /* things that are needed */
    int words, letters, sentences, i;
    words = letters = sentences = i = 0;

    /* calculations */
    while (text[i] != '\0')
    {
        /* if the character is an alphhabet */
        if (((text[i] >= 'a') && (text[i] <= 'z')) || ((text[i] >= 'A') && (text[i] <= 'Z')))
        {
            letters = letters + 1;
        }

        /* if the chararcter is a space */
        else if (text[i] == ' ')
        {
            words = words + 1;
        }

        /* if the character is a full-stop, exclamation or a question mark */
        else if ((text[i] == '?') || (text[i] == '.') || (text[i] == '!'))
        {
            sentences = sentences + 1;
        }

        // else do nothing

        /* incrementing the looping variable */
        i = i + 1;
    }

    /**
     * the last space is not recorded but it ends the sentence
     * and also the word
    */
    words = words + 1;

    /**
     *  doing the math
     *  L = number of letters per 100 words
     *  S = number of sentences per 100 words
    */
    float L = ((100.0 / words) * letters);
    float S = ((100.0 / words) * sentences);

    /* The formula */
    int grade = round((0.0588 * L) - (0.296 * S) - 15.8);

    /* the grading begins */
    if (grade < 1)
    {
        printf("Before Grade 1\n");
    }
    /* philosopher cadre */
    else if (grade >= 16)
    {
        printf("Grade 16+\n");
    }
    /* plebean class */
    else
    {
        printf("Grade %i\n", grade);
    }

    /* tradition demands ... */
    return 0;
}