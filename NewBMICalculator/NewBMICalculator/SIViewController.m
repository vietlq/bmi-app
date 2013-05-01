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
	// Do any additional setup after loading the view, typically from a nib.
    // Defaulting the unit system to Metric
    self.segmentUnitSystem.selectedSegmentIndex = UNIT_METRIC;
    unit_system = self.segmentUnitSystem.selectedSegmentIndex;
    // Set up the height slider
    self.sliderHeight.minimumValue = MIN_HEIGHT_VALUE[unit_system];
    self.sliderHeight.maximumValue = MAX_HEIGHT_VALUE[unit_system];
    self.sliderHeight.value = 160;
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
    unit_system = self.segmentUnitSystem.selectedSegmentIndex;
}

- (IBAction)heightChanged:(id)sender
{
    flHeight = round_to_n_decimals(self.sliderHeight.value, 2);
    NSLog(@"flHeight = %.2f", flHeight);
    self.labelHeight.text = [NSString stringWithFormat:@"Height: %.2f", flHeight];
    [self updateBMI];
}

- (IBAction)weightChanged:(id)sender
{
    flWeight = round_to_n_decimals(self.sliderWeight.value, 1);
    NSLog(@"flWeight = %.1f", flWeight);
    self.labelWeight.text = [NSString stringWithFormat:@"Weight: %.1f", flWeight];
    [self updateBMI];
}

- (void)updateBMI
{
    flBMI = [SIViewController calculateBMI :unit_system :flHeight :flWeight];
    self.labelBMI.text = [NSString stringWithFormat:@"BMI: %.2f", flBMI];
    NSLog(@"flBMI = %.2f", flBMI);
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
    
    flBMI = round_to_n_decimals(flHeight*flWeight, 2);
    return flBMI;
}

@end
