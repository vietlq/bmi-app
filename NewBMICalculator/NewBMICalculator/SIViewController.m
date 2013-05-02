//
//  SIViewController.m
//  NewBMICalculator
//
//  Created by Le Quoc Viet on 29/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "SIViewController.h"
#import "utils.h"

@interface SIViewController ()

@end

// Boundaries for height slider
const static float MIN_HEIGHT_VALUE[] = {0.5, 20};
const static float MAX_HEIGHT_VALUE[] = {3, 120};
// Boundaries for weight slider
const static float MIN_WEIGHT_VALUE[] = {2, 4};
const static float MAX_WEIGHT_VALUE[] = {300, 600};
// Strings
const static char* UNIT_SYSTEMS_LABEL[] = {
    "Unit System: m & kg", "Unit System: in & lb"
};
const static char* UNIT_HEIGHT_LABEL[] = {"m", "in"};

const static char* UNIT_WEIGHT_LABEL[] = {"kg", "lb"};

@implementation SIViewController
{
    float flHeight;
    float flWeight;
    float flBMI;
    enum unit_system_t unit_system;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Defaulting the unit system to Metric
    self.segmentUnitSystem.selectedSegmentIndex = UNIT_METRIC;
    unit_system = self.segmentUnitSystem.selectedSegmentIndex;
    self.labelUnitSystem.text = [NSString stringWithFormat:@"%s", UNIT_SYSTEMS_LABEL[unit_system]];
    
    // Set up the height slider
    self.sliderHeight.minimumValue = MIN_HEIGHT_VALUE[unit_system];
    self.sliderHeight.maximumValue = MAX_HEIGHT_VALUE[unit_system];
    self.sliderHeight.value = 1.6;
    flHeight = self.sliderHeight.value;
    
    // Set up the weight slider
    self.sliderWeight.minimumValue = MIN_WEIGHT_VALUE[unit_system];
    self.sliderWeight.maximumValue = MAX_WEIGHT_VALUE[unit_system];
    self.sliderWeight.value = 50;
    flWeight = self.sliderWeight.value;
    
    // Init BMI
    [self updateBMI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unitSystemChanged:(id)sender
{
    const enum unit_system_t old_unit_system = unit_system;
    unit_system = self.segmentUnitSystem.selectedSegmentIndex;
    self.labelUnitSystem.text = [NSString stringWithFormat:@"%s", UNIT_SYSTEMS_LABEL[unit_system]];
    
    // Set up the height slider
    const float old_height = self.sliderHeight.value;
    self.sliderHeight.minimumValue = MIN_HEIGHT_VALUE[unit_system];
    self.sliderHeight.maximumValue = MAX_HEIGHT_VALUE[unit_system];
    self.sliderHeight.value = old_height*HEIGHT_RATIO_TABLE[unit_system]/HEIGHT_RATIO_TABLE[old_unit_system];
    [self updateHeight];
    
    // Set up the weight slider
    const float old_weight = self.sliderWeight.value;
    self.sliderWeight.minimumValue = MIN_WEIGHT_VALUE[unit_system];
    self.sliderWeight.maximumValue = MAX_WEIGHT_VALUE[unit_system];
    self.sliderWeight.value = old_weight*WEIGHT_RATIO_TABLE[unit_system]/WEIGHT_RATIO_TABLE[old_unit_system];
    [self updateWeight];
    
    // Init BMI
    [self updateBMI];
}

- (void)updateHeight
{
    flHeight = round_to_n_decimals(self.sliderHeight.value, 2);
    self.labelHeight.text = [NSString stringWithFormat:@"Height (%s): %.2f", UNIT_HEIGHT_LABEL[unit_system], flHeight];   
}

- (IBAction)heightChanged:(id)sender
{
    [self updateHeight];
    [self updateBMI];
}

- (void)updateWeight
{
    flWeight = round_to_n_decimals(self.sliderWeight.value, 1);
    self.labelWeight.text = [NSString stringWithFormat:@"Weight (%s): %.1f", UNIT_WEIGHT_LABEL[unit_system], flWeight];   
}

- (IBAction)weightChanged:(id)sender
{
    [self updateWeight];
    [self updateBMI];
}

- (void)updateBMI
{
    flBMI = [SIViewController calculateBMI :unit_system :flHeight :flWeight];
    self.labelBMI.text = [NSString stringWithFormat:@"BMI: %.2f", flBMI];
}

+ (float)calculateBMI :(enum unit_system_t)unit_system :(float)flHeight :(float)flWeight
{
    /*
     English BMI Formula
     BMI = ( Weight in Pounds / ( Height in inches x Height in inches ) ) x 703
     Metric BMI Formula
     BMI = ( Weight in Kilograms / ( Height in Meters x Height in Meters ) )
     */
    
    float flBMI = 0;
    
    switch (unit_system)
    {
        case UNIT_METRIC:
            flBMI = flWeight / (flHeight * flHeight);
            break;
            
        case UNIT_BRITISH:
            flBMI = 703 * flWeight / (flHeight * flHeight);
            break;
            
        default:
            break;
    }
    
    flBMI = round_to_n_decimals(flBMI, 2);
    return flBMI;
}

@end
