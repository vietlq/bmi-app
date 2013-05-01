//
//  utils.h
//  BMICalculator
//
//  Created by Le Quoc Viet on 2/5/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#ifndef BMICalculator_utils_h
#define BMICalculator_utils_h

enum unit_system_t {UNIT_METRIC = 0, UNIT_BRITISH};

// The base is m
const static float HEIGHT_RATIO_TABLE[] = {1, 39.3701};
// The base is kg
const static float WEIGHT_RATIO_TABLE[] = {1, 2.20462};

// http://stackoverflow.com/questions/5678562/objective-c-rounding-float-to-the-nearest-05
float round_to_n_decimals(float value, int n);

#endif
