#include <cs50.h>
#include <stdio.h>
#include <string.h>

// Max voters and candidates
#define MAX_VOTERS 100
#define MAX_CANDIDATES 9

// preferences[i][j] is jth preference for voter i
int preferences[MAX_VOTERS][MAX_CANDIDATES];

// Candidates have name, vote count, eliminated status
typedef struct
{
    string name;
    int votes;
    bool eliminated;
}
candidate;

// Array of candidates
candidate candidates[MAX_CANDIDATES];

// Numbers of voters and candidates
int voter_count;
int candidate_count;

// Function prototypes
bool vote(int voter, int rank, string name);
void tabulate(void);
bool print_winner(void);
int find_min(void);
bool is_tie(int min);
void eliminate(int min);

int main(int argc, string argv[])
{
    // Check for invalid usage
    if (argc < 2)
    {
        printf("Usage: runoff [candidate ...]\n");
        return 1;
    }

    // Populate array of candidates
    candidate_count = argc - 1;
    if (candidate_count > MAX_CANDIDATES)
    {
        printf("Maximum number of candidates is %i\n", MAX_CANDIDATES);
        return 2;
    }
    for (int i = 0; i < candidate_count; i++)
    {
        candidates[i].name = argv[i + 1];
        candidates[i].votes = 0;
        candidates[i].eliminated = false;
    }

    voter_count = get_int("Number of voters: ");
    if (voter_count > MAX_VOTERS)
    {
        printf("Maximum number of voters is %i\n", MAX_VOTERS);
        return 3;
    }

    // Keep querying for votes
    for (int i = 0; i < voter_count; i++)
    {

        // Query for each rank
        for (int j = 0; j < candidate_count; j++)
        {
            string name = get_string("Rank %i: ", j + 1);

            // Record vote, unless it's invalid
            if (!vote(i, j, name))
            {
                printf("Invalid vote.\n");
                return 4;
            }
        }

        printf("\n");
    }

    // Keep holding runoffs until winner exists
    while (true)
    {
        // Calculate votes given remaining candidates
        tabulate();

        // Check if election has been won
        bool won = print_winner();
        if (won)
        {
            break;
        }

        // Eliminate last-place candidates
        int min = find_min();
        bool tie = is_tie(min);

        // If tie, everyone wins
        if (tie)
        {
            for (int i = 0; i < candidate_count; i++)
            {
                if (!candidates[i].eliminated)
                {
                    printf("%s\n", candidates[i].name);
                }
            }
            break;
        }

        // Eliminate anyone with minimum number of votes
        eliminate(min);

        // Reset vote counts back to zero
        for (int i = 0; i < candidate_count; i++)
        {
            candidates[i].votes = 0;
        }
    }
    return 0;
}

// Record preference if vote is valid
bool vote(int voter, int rank, string name)
{
    /* checking validity */
    for (int i = 0; i < candidate_count; i++)
    {
        /* if there is a match */
        if (strcmp(candidates[i].name, name) == 0)
        {
            /* the preference of voter (number) on rank (number) is candidate (number) */
            preferences[voter][rank] = i;
            return true;
        }
    }
    return false;
}

// Tabulate votes for non-eliminated candidates
void tabulate(void)
{
    /* for each voter */
    for (int i = 0; i < voter_count; i++)
    {
        /* for each candidate for that voter */
        for (int j = 0; j < candidate_count; j++)
        {
            /* if the given candidate is not eliminated */
            if (candidates[preferences[i][j]].eliminated == false)
            {
                candidates[preferences[i][j]].votes += 1;
                break;
            }
        }
    }
    return;
}

// Print the winner of the election, if there is one
bool print_winner(void)
{
    /* counting majority */
    int majority = (voter_count / 2) + 1;
    int winner = -1;
    int winner_count = 0;

    /* for every candidate */
    for (int i = 0; i < candidate_count; i++)
    {
        /* if there is a majority */
        if (candidates[i].votes >= majority)
        {
            /* count the candidate among winners */
            winner_count += 1;
            winner = i;
            /* in case more than one has majority - there is no clear winner */
            if (winner_count > 1)
            {
                return false;
            }
        }
        /* else do nothing */
    }
    /* if there is one distinct winner - declare so */
    if (winner_count == 1)
    {
        printf("%s\n", candidates[winner].name);
        return true;
    }
    /* else do nothing */
    return false;
}

// Return the minimum number of votes any remaining candidate has
int find_min(void)
{
    /* let current minimum be voter_count */
    int minimum = voter_count;
    /* for each candidate */
    for (int i = 0; i < candidate_count; i++)
    {
        /* if the candidate is not eliminated */
        if (candidates[i].eliminated == false)
        {
            /* note the lowest votes if any */
            if (candidates[i].votes < minimum)
            {
                minimum = candidates[i].votes;
            }
            /* else do nothing */
        }
    }
    return minimum;
}

// Return true if the election is tied between all candidates, false otherwise
bool is_tie(int min)
{
    /* some requirements */
    int number_of_minimum_vote_candidates = 0;
    int remaining_candidates = 0;
    /* for each candidate */
    for (int i = 0; i < candidate_count; i++)
    {
        /* count the remaining candidates */
        if (candidates[i].eliminated == false)
        {
            remaining_candidates += 1;
            /* count if the remaining candidate has minimum value of votes */
            if (candidates[i].votes == min)
            {
                number_of_minimum_vote_candidates += 1;
            }
        }
    }

    /* check if all remaining candidates have the same number of votes */
    if (remaining_candidates == number_of_minimum_vote_candidates)
    {
        return true;
    }
    /* else return false */
    return false;
}

// Eliminate the candidate (or candidiates) in last place
void eliminate(int min)
{
    /* loop through candidates */
    for (int i = 0; i < candidate_count; i++)
    {
        /* if not already eliminated */
        if (candidates[i].eliminated == false)
        {
            /* if the candidate(s) has minimum number of votes */
            if (candidates[i].votes == min)
            {
                /* eliminate the candidate(s) */
                candidates[i].eliminated = true;
            }
        }
    }
    return;
}
