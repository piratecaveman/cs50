#include <cs50.h>
#include <stdio.h>
#include <string.h>

// Max number of candidates
#define MAX 9

// Candidates have name and vote count
typedef struct
{
    string name;
    int votes;
}
candidate;

// Array of candidates
candidate candidates[MAX];

// Number of candidates
int candidate_count;

// Function prototypes
bool vote(string name);
void print_winner(void);

int main(int argc, string argv[])
{
    // Check for invalid usage
    if (argc < 2)
    {
        printf("Usage: plurality [candidate ...]\n");
        return 1;
    }

    // Populate array of candidates
    candidate_count = argc - 1;
    if (candidate_count > MAX)
    {
        printf("Maximum number of candidates is %i\n", MAX);
        return 2;
    }
    for (int i = 0; i < candidate_count; i++)
    {
        candidates[i].name = argv[i + 1];
        candidates[i].votes = 0;
    }

    int voter_count = get_int("Number of voters: ");

    // Loop over all voters
    for (int i = 0; i < voter_count; i++)
    {
        string name = get_string("Vote: ");

        // Check for invalid vote
        if (!vote(name))
        {
            printf("Invalid vote.\n");
        }
    }

    // Display winner of election
    print_winner();
}

// Update vote totals given a new vote
bool vote(string name)
{
    /* iterate over candidate list to find the correct one and increment his/her vote */
    for (int i = 0; i < candidate_count; i++)
    {
        /* assuming that no two candidates have the same name */
        if (strcmp(name, candidates[i].name) == 0)
        {
            /* found him and increment his vote by 1 (mischief if more) */
            candidates[i].votes += 1;
            return true;
        }
    }
    /* return false if no such candidate exists */
    return false;
}

// Print the winner (or winners) of the election
void print_winner(void)
{   
    /* index of the winner */
    int max_votes;
    max_votes = 0;
    /* iterate through votes to calculate maximum votes */
    for (int i = 0; i < candidate_count; i++)
    {
        /* change the index if someone has more votes */
        if (candidates[i].votes > max_votes)
        {
            max_votes = candidates[i].votes;
        }
    }
    /* printing the winners */
    for (int i = 0; i < candidate_count; i++)
    {
        if (candidates[i].votes == max_votes)
        {
            printf("%s\n", candidates[i].name);
        }
    }
    /* let us begin */
    return;
}

