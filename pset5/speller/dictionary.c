// Implements a dictionary's functionality
#include <stdbool.h>

/* needed for strlen() */
#include <string.h>
/* needed for strcasecmmp() */
#include <strings.h>
/* needed for pow() and floor() */
#include <math.h>
/* needed for tolower() */
#include <ctype.h>
/* for printf() */
#include <stdio.h>
/* for malloc() and free() */
#include <stdlib.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

/* read characters into buffer until newline is encountered */
void read_word(FILE *file, char *buffer);
/* free cells of the table and the linked lists within them */
void free_cells(node *cell);


// Number of buckets in hash table
const unsigned int N = 10000;

// Hash table
node *table[N];

/* the cache of cells that are already assigned */
unsigned int assigned_cells[N];
/* count of assigned cells */
int cell_assignment_count = 0;
/* number of words (nodes) loaded into the memory */
int words_added = 0;

// Returns true if word is in dictionary else false
bool check(const char *word)
{
    /* hashing the inputs */
    unsigned int _hash = hash(word);
    /* if no cell is assigned that hash - the word does not exist in our dictionary */
    if (table[_hash] == NULL)
    {
        return false;
    }
    /* else it exists and we must find it */
    else
    {
        node *current_node = table[_hash];
        while (true)
        {
            /* if it is the first node of the linked list */
            if (strcasecmp(current_node->word, word) == 0)
            {
                return true;
            }
            /* if the current node is the last element - we haven't found the word */
            else if (current_node->next == NULL)
            {
                return false;
            }
            /* move on to the next element */
            current_node = current_node->next;
        }
    }
    /* this statement will never be reached hah */
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    int string_length = strlen(word);
    unsigned int _hash = 0;

    /* prime numbers provide good pseudo-randomness if square-root is calculated */
    int primes[12] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37};
    /* selecting one prime number to use */
    int prime_first = string_length % 12;

    for (int i = 0; i < string_length; i++)
    {
        char current = word[i];
        /* the dictionary lookup is case insensitive */
        current = tolower(current);
        /* some random mathematics */
        double result = pow((int) current, 2) + pow(primes[prime_first], 0.5);
        _hash = _hash + (int) floor(pow(result, 0.5));
    }
    /* compressing the hash value to be bound by N */
    _hash = _hash % N;
    return _hash;
}

// Loads dictionary into memory, returning true if successful else false
bool load(const char *dictionary)
{
    /* This function will try to read the dictionary file and load words into the memory one word at a time */
    FILE *file = fopen(dictionary, "r");
    if (file == NULL)
    {
        return false;
    }

    while (!feof(file))
    {
        /* a new node for inserting a new word */
        node *current_node = malloc(sizeof(node));
        current_node->next = NULL;
        /* initializing the word field of the node - not required but for safety */
        for (int i = 0; i < LENGTH; i++)
        {
            current_node->word[i] = '\0';
        }
        /* reads a word into the current node */
        read_word(file, current_node->word);
        unsigned int _hash = hash(current_node->word);
        
        /* a hash of it already exists - either the word is a repeat or a collison of hash has occured */
        if (table[_hash] != NULL)
        {
            /* inserting the new node at the front of the linked list pointed to by that cell */
            node *temporary = table[_hash];
            table[_hash] = current_node;
            current_node->next = temporary;
            /* since a word is now loaded but no new cell is assigned */
            words_added += 1;
        }
        else
        {
            /* assignment to a new cell */
            table[_hash] = current_node;
            /* caching the hash for faster retrival (not acceptable if the entire table is used) */
            assigned_cells[cell_assignment_count] = _hash;
            /* a new word has been added and a new cell has been assigned */
            cell_assignment_count += 1;
            words_added += 1;
        }
    }
    fclose(file);
    return true;
}

// Returns number of words in dictionary if loaded else 0 if not yet loaded
unsigned int size(void)
{
    /* we already know the word count */
    return words_added - 1;
}

// Unloads dictionary from memory, returning true if successful else false
bool unload(void)
{
    /* we already have the list of cells that are assigned some values */
    for (int i = 0; i < cell_assignment_count; i++)
    {
        free_cells(table[assigned_cells[i]]);
        table[assigned_cells[i]] = NULL;
    }
    return true;
}

void read_word(FILE *file, char *buffer)
{
    /**
     * This function assumes that the file pointer is valid and opened in read mode
     * The function reads characters into the buffer until a newline is encountered
     * assuming the buffer provided has enough space
    */

    char current = '\0';
    /* counter for traversing the buffer */
    int counter = 0;
    while (!feof(file))
    {
        current = fgetc(file);
        if (current == '\n')
        {
            break;
        }
        buffer[counter] = current;
        counter += 1;
    }
    /* not forgetting to add the string terminating character */
    buffer[counter] = '\0';
    return;
}

void free_cells(node *cell)
{
    /* this function recursively frees nodes and the cells of the table */
    if (cell->next == NULL)
    {
        /* the last cell of linked list */
        free(cell);
    }
    /* else free the next node first */
    else
    {
        free_cells(cell->next);
        free(cell);
    }
    return;
}