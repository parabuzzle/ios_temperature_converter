//
//  MainViewController.m
//  Tempature
//
//  Created by Mike Heijmans on 7/24/13.
//  Copyright (c) 2013 Yahoo! Inc. All rights reserved.
//

#import "MainViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface MainViewController ()

- (void) convertTemp;
- (void) convertFtoC;
- (void) convertCtoF;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Set title for this view
        self.title = @"Tempature";
        
        // Set the static tag values for the fields
        self.fahrenheitValue.tag = 0;
        self.celsiusValue.tag = 1;
        
        // Set the background color we want to initialize with
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set myself as the delegate for the text fields
    self.fahrenheitValue.delegate = self;
    self.celsiusValue.delegate = self;
    
    // Set the fahrenheit value as the default conversion value
    // -- this fixes a bug where pressing the convert button right after launch results in crash
    self.conversionIdx = self.fahrenheitValue;
    
    // Set the view background color to my desired color
    self.view.backgroundColor = self.backgroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // When a text field is selected for edit display a done button in the nav bar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDoneButton:)];
    
    // Set the conversion index field to the current field that is being edited.
    self.conversionIdx = textField;
    
    // Reset the other field to blank...
    if (self.conversionIdx.tag == 0) {
        // this is f
        self.celsiusValue.text = nil;
    } else {
        // this is c
        self.fahrenheitValue.text = nil;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // Ensure the done button persists on field change
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDoneButton)];
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    // When the text field is no longer selected for edit remove the done button
    self.navigationItem.rightBarButtonItem = nil;
    return YES;
}

#pragma mark - Public Methods

- (void)onDoneButton {
    // Since we want to convert on button press.. lets just remove the keyboard
    [self.view endEditing:(YES)];
    
    // uncomment this to do the conversion after editing.
    //[self convertTemp];
}

- (void)onConvertButton {
    // Convert button was pressed... lets convert!
    [self convertTemp];
    
    // also dismiss the keyboard...
    [self onDoneButton];
}

#pragma mark - Private Methods

- (void) convertTemp {
    // converts tempature based on conversionIdx
    // F -> C = ((F-32)*5)/9
    // C -> F = ((C*9)/5)+32
    
    
    if (self.conversionIdx.tag == 0) {
        // this is f to c
        [self convertFtoC];
        
    } else {
        // this is c to f
        [self convertCtoF];
    }
    
    // Set the background color
    self.view.backgroundColor = self.backgroundColor;
    
}

- (void) convertFtoC {
    // Converts fahrenheit to celsius
    
    // load up floats..
    float f = [self.fahrenheitValue.text floatValue];
    float c;
    
    // do the math
    c = (f - 32) * 5 / 9;
    
    if ([self.fahrenheitValue.text isEqual: @""]) {
        // if the value was blank just nil out the values
        self.celsiusValue.text = nil;
        
        // set background to white
        self.backgroundColor = [UIColor whiteColor];
        
    } else {
        self.celsiusValue.text = [NSString stringWithFormat:@"%0.2f", c];
        // set the celcius value
        
        if (f > 85) {
            // if the temp is considered 'warm'
            self.backgroundColor = UIColorFromRGB(0xFFF0F0);
        } else if (f < 70) {
            // if the temp is considered 'cold'
            self.backgroundColor = UIColorFromRGB(0xE8EDFF);
        } else {
            // the temp is within room temp range
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void) convertCtoF {
    // converts celsius to fahrenheit
    
    // load up the floats...
    float f;
    float c = [self.celsiusValue.text floatValue];
    
    // do the math
    f = (c * 9) / 5 + 32;

    if ([self.celsiusValue.text isEqual: @""]) {
        // if the value is blank just nil out the values
        self.fahrenheitValue.text = nil;
        
        // set the background color
        self.backgroundColor = [UIColor whiteColor];
    } else {
        // set the fahrenheit value
        self.fahrenheitValue.text = [NSString stringWithFormat:@"%0.2f", f];
        
        if (f > 85) {
            // if the temp is considered 'warm'
            self.backgroundColor = UIColorFromRGB(0xFFF0F0);
        } else if (f < 70) {
            // if the temp is considered 'cold'
            self.backgroundColor = UIColorFromRGB(0xE8EDFF);
        } else {
            // the temp is within room temp range
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

@end
