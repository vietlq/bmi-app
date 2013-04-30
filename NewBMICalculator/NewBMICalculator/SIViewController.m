//
//  SIViewController.m
//  NewBMICalculator
//
//  Created by Le Quoc Viet on 29/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import "SIViewController.h"
#import <math.h>

@interface SIViewController ()

@end

// http://stackoverflow.com/questions/5678562/objective-c-rounding-float-to-the-nearest-05
float round_to_first_decimal(float value);
float round_to_second_decimal(float value);

@implementation SIViewController
{
    float flHeight;
    float flWeight;
    float flBMI;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unitSystemChanged:(id)sender
{
    //self.segmentUnitSystem.selectedSegmentIndex
}

- (IBAction)heightChanged:(id)sender
{
    flHeight = round_to_first_decimal(self.sliderHeight.value);
    NSLog(@"flHeight = %.1f", flHeight);
    self.labelHeight.text = [NSString stringWithFormat:@"Height: %.2f", flHeight];
    [self updateBMI];
}

- (IBAction)weightChanged:(id)sender
{
    flWeight = round_to_first_decimal(self.sliderWeight.value);
    NSLog(@"flWeight = %.1f", flWeight);
    self.labelWeight.text = [NSString stringWithFormat:@"Weight: %.2f", flWeight];
    [self updateBMI];
}


- (void)updateBMI
{
    flBMI = [SIViewController calculateBMI:flHeight :flWeight];
    NSLog(@"flBMI = %.2f", flBMI);
}

+ (float)calculateBMI :(float)flHeight :(float)flWeight
{
    float flBMI = 0;
    
    flBMI = flHeight*flWeight;
    
    return flBMI;
}

@end

float round_to_first_decimal(float value)
{
    const float roundingValue = 0.1;
    int mulitpler = floor(value / roundingValue);
    return mulitpler * roundingValue;
}

float round_to_second_decimal(float value)
{
    const float roundingValue = 0.01;
    int mulitpler = floor(value / roundingValue);
    return mulitpler * roundingValue;
}
