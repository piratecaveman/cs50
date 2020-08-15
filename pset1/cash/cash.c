#include <stdio.h>
#include <cs50.h>
#include <math.h>

int main()
{

    /* store amount of change */
    float amount;

    /* input section */
    do
    {
        /* get input until proper */
        amount = get_float("Change owed: ");
    }
    while (amount < 0);

    /* converting to cents */
    int cents = round(amount * 100);
    int coins = 0;

    while (cents >= 25)
    {
        cents = cents - 25;
        coins = coins + 1;
    }

    while (cents >= 10)
    {
        cents = cents - 10;
        coins = coins + 1;        
    }   

    while (cents >= 5)
    {
        cents = cents - 5;
        coins = coins + 1;
    }

    /* the remaining is 1 cent coins obviously */
    coins = coins + cents;
    printf("%d\n", coins);
    
    /* returning integer as traditions demand */
    return 0;
}