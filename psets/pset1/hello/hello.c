#include <stdio.h>
#include <cs50.h>

int main()
{

    /**
     * cs50.h - provides get_string()
     * name - store name
    */
    string name = get_string("What might your name be: ");
    printf("hello, %s\n", name);
    /* reaturning an integer */
    return 0;
}