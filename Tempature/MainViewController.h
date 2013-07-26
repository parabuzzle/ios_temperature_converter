//
//  MainViewController.h
//  Tempature
//
//  Created by Mike Heijmans on 7/24/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITextFieldDelegate>

#pragma mark - Properties
@property (nonatomic, weak) IBOutlet UITextField *fahrenheitValue;
@property (nonatomic, weak) IBOutlet UITextField *celsiusValue;
@property (nonatomic, weak) IBOutlet UIButton *convertButton;
@property (nonatomic, weak) UITextField *conversionIdx;
@property (nonatomic, weak) UIColor *backgroundColor; //used for background color

#pragma mark - Public methods
- (IBAction)onDoneButton;
- (IBAction)onConvertButton;

@end
