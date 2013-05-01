//
//  utils.c
//  BMICalculator
//
//  Created by Le Quoc Viet on 2/5/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#include <stdio.h>
#import <math.h>
#include "utils.h"

const static int ROUNDING_TABLE[] = {
    1,      10,     100,
    1000,   10000,  100000
};

float round_to_n_decimals(float value, int n)
{
    value *= ROUNDING_TABLE[n];
    return floorf(value)/ROUNDING_TABLE[n];
}
