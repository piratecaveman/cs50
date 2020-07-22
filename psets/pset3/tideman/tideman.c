#include <cs50.h>
#include <stdio.h>
#include <string.h>

// Max number of candidates
#define MAX 9

// preferences[i][j] is number of voters who prefer i over j
int preferences[MAX][MAX];

// locked[i][j] means i is locked in over j
bool locked[MAX][MAX];

// Each pair has a winner, loser
typedef struct
{
    int winner;
    int loser;
}
pair;

// Array of candidates
string candidates[MAX];
pair pairs[MAX * (MAX - 1) / 2];

int pair_count;
int candidate_count;

// Function prototypes
bool vote(int rank, string name, int ranks[]);
void record_preferences(int ranks[]);
void add_pairs(void);
void sort_pairs(void);
void lock_pairs(void);
void print_winner(void);

// functions declared by me
bool cyclic_check(int candidate_a, int candidate_b);

int main(int argc, string argv[])
{
    // Check for invalid usage
    if (argc < 2)
    {
        printf("Usage: tideman [candidate ...]\n");
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
        candidates[i] = argv[i + 1];
    }

    // Clear graph of locked in pairs
    for (int i = 0; i < candidate_count; i++)
    {
        for (int j = 0; j < candidate_count; j++)
        {
            locked[i][j] = false;
        }
    }

    pair_count = 0;
    int voter_count = get_int("Number of voters: ");

    // Query for votes
    for (int i = 0; i < voter_count; i++)
    {
        // ranks[i] is voter's ith preference
        int ranks[candidate_count];

        // Query for each rank
        for (int j = 0; j < candidate_count; j++)
        {
            string name = get_string("Rank %i: ", j + 1);

            if (!vote(j, name, ranks))
            {
                printf("Invalid vote.\n");
                return 3;
            }
        }

        record_preferences(ranks);

        printf("\n");
    }

    add_pairs();
    sort_pairs();
    lock_pairs();
    print_winner();
    return 0;
}

// Update ranks given a new vote
bool vote(int rank, string name, int ranks[])
{
    /* cycling through all acndidates assuming no two have the same name */
    for (int i = 0; i < candidate_count; i++)
    {
        if (strcmp(name, candidates[i]) == 0)
        {
            /* ranks[i] - voter's ith preference */
            /* ranks[rank] - voter's preference at rank (rank) is candidate index */
            ranks[rank] = i;
            return true;
        }
    }
    return false;
}

// Update preferences given one voter's ranks
void record_preferences(int ranks[])
{
    /* the ranks are for one voter */
    /* preferences[i][j] = number of people who prefer i over j */
    for (int i = 0; i < candidate_count; i++)
    {
        /* for each candidate loop through other candidates */
        for (int j = 0; j < candidate_count; j++)
        {
            /* if not comparing to himself */
            if (i != j)
            {
                /* ranks[i] would be higer rank than ranks[j] in this case */
                if (i < j)
                {
                    /* incrementing the votes for candidate present at ranks[i] over the one at ranks[j] */
                    preferences[ranks[i]][ranks[j]] += 1;
                }
                /* the else cases will eventtually get covered in the subsequent runs of this loop */
            }
        }
    }
    return;
}

// Record pairs of candidates where one is preferred over the other
void add_pairs(void)
{
    /* looping over candidates again */
    for (int i = 0; i < candidate_count; i++)
    {
        for (int j = 0; j < candidate_count; j++)
        {
            /* no candidate is to compete against himself */
            if (i != j)
            {
                /* preferences[i][j] = no. of voters who prefer i over j */
                if (preferences[i][j] > preferences[j][i])
                {
                    pairs[pair_count].winner = i;
                    pairs[pair_count].loser = j;
                    pair_count += 1;
                }
                /* else parts will be satisfied in subsequent runs of the loop */
            }
        }
    }
    return;
}

// Sort pairs in decreasing order by strength of victory
void sort_pairs(void)
{
    /**
     * The idea is:
     * - compare all pairs against each other one by one
     * - the pair with higher votes should always occupy lower index
     * - swap current pair with the one compared against, if necessary
    */
    /* variable for swapping */
    pair temp;
    /* iterating through pairs */
    for (int i = 0; i < pair_count; i++)
    {
        for (int j = 0; j < pair_count; j++)
        {
            /* not wanting to sort the same pair :p */
            if (i != j)
            {
                /* if the candidate i is behind j*/
                if (i > j)
                {
                    /* but has more votes than the other pair */
                    if (preferences[pairs[i].winner][pairs[i].loser] > preferences[pairs[j].winner][pairs[j].loser])
                    {
                        /* swap i to the place of j */
                        temp = pairs[i];
                        pairs[i] = pairs[j];
                        pairs[j] = temp;
                    }
                }
                /* else if the candidate i is ahead of j */
                else
                {
                    /* but has lesser votes than the other pair */
                    if (preferences[pairs[i].winner][pairs[i].loser] < preferences[pairs[j].winner][pairs[j].loser])
                    {
                        /* swap i to the position of j */
                        temp = pairs[j];
                        pairs[j] = pairs[i];
                        pairs[i] = temp;
                    }
                }
            }
        }
    }
    return;
}

// Lock pairs into the candidate graph in order, without creating cycles
void lock_pairs(void)
{
    /* looping through pairs if there are no cycles in it, lock them */
    for (int i = 0; i < pair_count; i++)
    {
        if (!locked[pairs[i].winner][pairs[i].loser])
        {
            if (!cyclic_check(pairs[i].winner, pairs[i].loser))
            {
                locked[pairs[i].winner][pairs[i].loser] = true;
            }
        }
    }
    return;
}

// Print the winner of the election
void print_winner(void)
{
    /* if no other candidate locks on to a candidate - he is the winner */
    /* we are to assume that there is only one winner */
    for (int i = 0; i < candidate_count; i++)
    {
        /* counter to see if the given candidate is locked */
        int counter = 0;
        for (int j = 0; j < candidate_count; j++)
        {
            /* if the given candidate is locked */
            if (locked[j][i] == true)
            {
                /* no need to check further */
                counter += 1;
                break;
            }
            /* else print him as a winner */
        }
        if (counter == 0)
        {
            printf("%s\n", candidates[i]);
        }
    }
    return;
}


bool cyclic_check(int candidate_a, int candidate_b)
{
    /** 
     * if candidate_a has an edge over candidate_b
     * and if candidate_b has an edge over candidate_a
     * then i is obviously a cycle A -> B and B -> A 
     */

    if (locked[candidate_b][candidate_a] == true)
    {
        return true;
    }

    /* check if there is a cycle in any candidate in he list */
    for (int i = 0; i < candidate_count; i++)
    {
        /**
         * say the candidate i has an edge over candidate_a
         * if candidate_b has an edge over i and
         * candidate_a has an edge over candidate_b
         * then we are running in circles
        */
        if ((i != candidate_b) && (locked[i][candidate_a] == true))
        {
            /* it has to be recursive to identify intermediate circles */
            return cyclic_check(i, candidate_b);
        }
    }
    return false;
}