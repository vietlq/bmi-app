//
//  SIViewController.h
//  NewBMICalculator
//
//  Created by Le Quoc Viet on 29/4/13.
//  Copyright (c) 2013 Le Quoc Viet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIViewController : UIViewController

@property (nonatomic, strong) IBOutlet UISegmentedControl *segmentUnitSystem;
@property (nonatomic, strong) IBOutlet UILabel *labelUnitSystem;
@property (nonatomic, strong) IBOutlet UISlider *sliderHeight;
@property (nonatomic, strong) IBOutlet UILabel *labelHeight;
@property (nonatomic, strong) IBOutlet UISlider *sliderWeight;
@property (nonatomic, strong) IBOutlet UILabel *labelWeight;
@property (nonatomic, strong) IBOutlet UILabel *labelBMI;

- (IBAction)unitSystemChanged:(id)sender;
- (IBAction)heightChanged:(id)sender;
- (IBAction)weightChanged:(id)sender;

@end
