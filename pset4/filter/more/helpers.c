#include <math.h>
#include "helpers.h"

int is_border(int i, int j, int height, int width)
{
    /* i = 0 means it is a border pixel for any value of j - the top edge */
    if (i == 0)
    {
        return 1;
    }
    /* i = height - 1 implies it is a border pixel on the bottom edge for any j */
    else if (i == (height - 1))
    {
        return 1;
    }
    /* j = 0 means it is the border pixel on the left edge for any i */
    else if (j == 0)
    {
        return 1;
    }
    /* j = width - 1 means it is the border pixel on the right edge for any i */
    else if (j == (width - 1))
    {
        return 1;
    }
    /* otherwise it is not a border pixel */
    else
    {
        return 0;
    }
}

int is_corner(int i, int j, int height, int width)
{
    /**
     * return 0 - not a corner
     * return 1 - bottom left (i = 0 && j == 0)
     * return 2 - bottom right (i = 0 && j == width - 1)
     * return 3 - top left (i == height - 1) && j == 0
    */
    if (i == 0)
    {
        if (j == 0)
        {
            return 1;
        }
        else if (j == (width - 1))
        {
            return 2;
        }
        else
        {
            return 0;
        }
    }
    else if (i == (height - 1))
    {
        if (j == 0)
        {
            return 3;
        }
        else if (j == (width - 1))
        {
            return 4;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return 0;
    }
}

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    /* traversing through the pixels */
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            /* average value */
            int average = 0;
            
            /* rounding them to integers */
            average = round(((float)(image[i][j].rgbtRed + image[i][j].rgbtBlue + image[i][j].rgbtGreen)) / 3);
            /* capping the value of colors to 255 */
            if (average > 255)
            {
                average = 255;
            }
            /* writing the data back to the image */
            image[i][j].rgbtBlue = average;
            image[i][j].rgbtGreen = average;
            image[i][j].rgbtRed = average;
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    /** an array to store color information
     *  colors[0] ->  sepia_blue
     *  colors[1] -> sepia_green
     *  colors[2] -> sepia_red
     */
    int colors[3];

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            /* using the colors values to get the filtered value */
            colors[0] = round((0.272 * image[i][j].rgbtRed) + (0.534 * image[i][j].rgbtGreen) + (0.131 * image[i][j].rgbtBlue));
            colors[1] = round((0.349 * image[i][j].rgbtRed) + (0.686 * image[i][j].rgbtGreen) + (0.168 * image[i][j].rgbtBlue));
            colors[2] = round((0.393 * image[i][j].rgbtRed) + (0.769 * image[i][j].rgbtGreen) + (0.189 * image[i][j].rgbtBlue));
            /* capping the color values to 255 */
            for (int k = 0; k < 3; k++)
            {
                if (colors[k] > 255)
                {
                    colors[k] = 255;
                }
            }
            
            /* writing the values back to the image array */
            image[i][j].rgbtBlue = colors[0];
            image[i][j].rgbtGreen = colors[1];
            image[i][j].rgbtRed = colors[2];
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    /* a temporary variable to store pixel data for swapping */
    RGBTRIPLE temp;

    /* determining the midpoint of the image */
    int middle = 0;
    if (width % 2 == 0)
    {
        middle = width / 2;
    }
    else
    {
        middle = (width - 1) / 2;
    }

    /* for every row in an image */
    for (int i = 0; i < height; i++)
    {
        /* swap the pixel on the left to the corresponding one on the right */
        /**
         * ie. 0 maps to (width - 1)
         * 1 maps to (width - 2)
         * 2 maps to (width - 3)
         * and any j maps to ((width - 1) - j)
         *  going on only to the middle however - otherwise we will come full circle
         */
        for (int j = 0; j < middle; j++)
        {
            temp = image[i][j];
            image[i][j] = image[i][(width - 1) - j];
            image[i][(width - 1) - j] = temp;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    /* creating a false frame around the image of 1 pixel and storing it as a new image */
    RGBTRIPLE new_image[height + 2][width + 2];
    for (int i = 0; i < height + 2; i++)
    {
        for (int j = 0; j < width + 2; j++)
        {
            /* making the borders black because at zero values it will not affect the blur */
            if ((i == 0) || (i == height + 1))
            {
                new_image[i][j].rgbtBlue = 0;
                new_image[i][j].rgbtGreen = 0;
                new_image[i][j].rgbtRed = 0;
                continue;
            }

            if ((j == 0) || (j == width + 1))
            {
                new_image[i][j].rgbtBlue = 0;
                new_image[i][j].rgbtGreen = 0;
                new_image[i][j].rgbtRed = 0;
                continue;
            }

            /* copying the rest of the image as is */
            new_image[i][j].rgbtBlue = image[i - 1][j - 1].rgbtBlue;
            new_image[i][j].rgbtGreen = image[i - 1][j - 1].rgbtGreen;
            new_image[i][j].rgbtRed = image[i - 1][j - 1].rgbtRed;
        }
    }


    /**
     * color[0] - blue
     * color[1] - green
     * color[2] - red
    */
    int color[3];
    /**
     * traversing the new image excluding the borders
     * the purpose of the border is to ensure that 0 values
     * for the edge and corner pixels are available - see the comment below
    */
    for (int i = 1; i < height + 1; i++)
    {
        for (int j = 1; j < width + 1; j++)
        {
            /**
             *  all this fuss about making the border now ensures that 
             * i - 1 and j - 1 and i + 1 and j + 1
             * are always defined and never go out of bound
             * the loops below sums the reds, blues and the greens of
             * the surrounding 8 pixels and the current pixel
             * h ranges from -1 to 1 an so does k
             * this loop traverses from [i - 1][j - 1] to [i + 1][j + 1] and all the possiblities in between
             */

            /* resetting color variable for each pixel */
            color[0] = color[1] = color[2] = 0;
            for (int h = -1; h < 2; h++)
            {
                for (int k = -1; k < 2; k++)
                {
                    color[0] += new_image[i + h][j + k].rgbtBlue;
                    color[1] += new_image[i + h][j + k].rgbtGreen;
                    color[2] += new_image[i + h][j + k].rgbtRed;
                }
            }
    
            /* border pixels only have 6 pixels to average (inclusive of the current) */
            if (is_border(i - 1, j - 1, height, width) == 1)
            {
                /* corners only have 4 pixels averaged (including the current) */
                if (is_corner(i - 1, j - 1, height, width) != 0)
                {
                    /* averaging and rounding the colors and capping them */
                    for (int k = 0; k < 3; k++)
                    {
                        color[k] = round((float) color[k] / 4);
                        if (color[k] > 255)
                        {
                            color[k] = 255;
                        }
                    }
                }
                /* if not corner but only border pixels */
                else
                {
                    /* averaging, rounding and capping the colors */
                    for (int k = 0; k < 3; k++)
                    {
                        color[k] = round((float) color[k] / 6);
                        if (color[k] > 255)
                        {
                            color[k] = 255;
                        }
                    }
                }
            }

            /* if not a border pixel - averageing is done for the 9 pixels including itself */
            else
            {
                /* averaging, rounding and capping */
                for (int k = 0; k < 3; k++)
                {
                    color[k] = round((float) color[k] / 9);
                    if (color[k] > 255)
                    {
                        color[k] = 255;
                    }
                }
            }
            
            /* at this point the blurring is done - writing the data back to the image */
            image[i - 1][j - 1].rgbtBlue = color[0];
            image[i - 1][j - 1].rgbtGreen = color[1];
            image[i - 1][j - 1].rgbtRed = color[2];
        }
    }
    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    /* creating a false frame around the image of 1 pixel and storing it as a new image */
    RGBTRIPLE new_image[height + 2][width + 2];
    for (int i = 0; i < height + 2; i++)
    {
        for (int j = 0; j < width + 2; j++)
        {
            /* making the borders black because at zero values it will not affect the blur */
            if ((i == 0) || (i == height + 1))
            {
                new_image[i][j].rgbtBlue = 0;
                new_image[i][j].rgbtGreen = 0;
                new_image[i][j].rgbtRed = 0;
                continue;
            }

            if ((j == 0) || (j == width + 1))
            {
                new_image[i][j].rgbtBlue = 0;
                new_image[i][j].rgbtGreen = 0;
                new_image[i][j].rgbtRed = 0;
                continue;
            }

            /* copying the rest of the image as is */
            new_image[i][j].rgbtBlue = image[i - 1][j - 1].rgbtBlue;
            new_image[i][j].rgbtGreen = image[i - 1][j - 1].rgbtGreen;
            new_image[i][j].rgbtRed = image[i - 1][j - 1].rgbtRed;
        }
    }

    /**
     * color[0] - blue
     * color[1] - green
     * color[2] - red
    */
    int color[3];

    /**
     * traversing the new image excluding the borders
     * the purpose of the border is to ensure that 0 values
     * for the edge and corner pixels are available - see the comment below
    */
    for (int i = 1; i < height + 1; i++)
    {
        for (int j = 1; j < width + 1; j++)
        {
            /**
             *  all this fuss about making the border now ensures that 
             * i - 1 and j - 1 and i + 1 and j + 1
             * are always defined and never go out of bound
             */
            
            /** 
             * this code below calculates the gx and gy value of each of RGB on that pixel
             * using the given gx and gy matrix (see cs50/pset4/filter/more for further information)
             */
            /* to store the gx and gy values for each color of the pixel */
            float gx_red, gx_blue, gx_green, gy_red, gy_blue, gy_green;
            gx_blue = gx_green = gx_red = gy_blue = gy_green = gy_red = 0;

            /* this variable tracks which value of gx and gy are to be multiplied to the given pixel */
            int g = 0;
            /* the gx and gy matrix row-wise */
            float gx[9] = {-1.0, 0, 1.0, -2.0, 0, 2.0, -1.0, 0, 1.0};
            float gy[9] = {-1.0, -2.0, -1.0, 0, 0, 0, 1.0, 2.0, 1.0};

            /* this loop traverses the 8 elements surrounding the current pixel and the pixel itself */
            /* the vaules h takes is -> 1, 0, -1 and k takes the same */
            /* thus it traveses all cases from [i + 1][j + 1] to [i - 1][j - 1] */
            /* if we start from [i - 1][j - 1] - we'd have to traverse gx and gy arrays in reverse */
            for (int h = 1; h > -2; h--)
            {
                for (int k = 1; k > -2; k--)
                {
                    /* gx is sum of previous + new value */
                    gx_blue += (new_image[i + h][j + k].rgbtBlue * gx[g]);
                    gx_green += (new_image[i + h][j + k].rgbtGreen * gx[g]);
                    gx_red += (new_image[i + h][j + k].rgbtRed * gx[g]);

                    gy_blue += (new_image[i + h][j + k].rgbtBlue * gy[g]);
                    gy_green += (new_image[i + h][j + k].rgbtGreen * gy[g]);
                    gy_red += (new_image[i + h][j + k].rgbtRed * gy[g]);

                    /* incrementing the g value to move to next */
                    g += 1;
                }
            }
            
            /* Value is square root of the sum of squares of gx and gy */
            color[0] = round(pow((pow(gx_blue, 2) + pow(gy_blue, 2)), 0.5));
            color[1] = round(pow((pow(gx_green, 2) + pow(gy_green, 2)), 0.5));
            color[2] = round(pow((pow(gx_red, 2) + pow(gy_red, 2)), 0.5));

            /* capping the colors */
            for (int k = 0; k < 3; k++)
            {
                if (color[k] > 255)
                {
                    color[k] = 255;
                }
            }

            /* writing the pixel information back to the image */
            image[i - 1][j - 1].rgbtBlue = color[0];
            image[i - 1][j - 1].rgbtGreen = color[1];
            image[i - 1][j - 1].rgbtRed = color[2];
        }
    }
    /* we are done now */
    return;
}
