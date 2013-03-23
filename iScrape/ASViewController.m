//
//  ASViewController.m
//  iScrape
//
//  Created by Robbie Clarken on 23/03/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASViewController.h"

static NSString *LCDFontName = @"DS-Digital";

@interface ASViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) NSString *password;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scraperLabel;
@property (weak, nonatomic) IBOutlet UILabel *radLabel1;
@property (weak, nonatomic) IBOutlet UILabel *radLabel2;
@property (weak, nonatomic) IBOutlet UILabel *radLabel3;

@end

@implementation ASViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self applyLCDFontToLabels:@[self.currentLabel,
                                 self.rateLabel,
                                 self.scraperLabel,
                                 self.radLabel1,
                                 self.radLabel2,
                                 self.radLabel3]];
    
    
    
    CGFloat currentFontSize = self.currentLabel.font.pointSize;
    CGFloat currentFontLowercaseSize = 0.6 * currentFontSize;
    NSMutableAttributedString *currentString = [[NSMutableAttributedString alloc] initWithString:@"200.123 mA"];
    [currentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:LCDFontName size:currentFontLowercaseSize] range:NSMakeRange([currentString length]-2, 1)];
    self.currentLabel.attributedText = currentString;
    
    NSMutableAttributedString *rateString = [[NSMutableAttributedString alloc] initWithString:@"RATE: 1.35 mA/S"];
    UIFont *rateLowerCaseFont = [UIFont fontWithName:LCDFontName size:16.0f];
    [rateString addAttribute:NSFontAttributeName value:rateLowerCaseFont range:NSMakeRange([rateString length]-4, 1)];
    [rateString addAttribute:NSFontAttributeName value:rateLowerCaseFont range:NSMakeRange([rateString length]-1, 1)];
    self.rateLabel.attributedText = rateString;
    
    
    
    if (![self.sshSession isConnected]) {
        // TODO: No connection
    }
    //[self requestPassword];
}

- (void)applyLCDFontToLabels:(NSArray *)labels {
    for (UILabel *label in labels) {
        label.font = [UIFont fontWithName:LCDFontName size:label.font.pointSize];
    }
    
}

- (void)requestPassword {
    UIAlertView *passwordAlertView = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Please enter the ics password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [passwordAlertView setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [passwordAlertView show];
}

- (void)authenticate {
    [self.sshSession authenticateByPassword:self.password];
    if ([self.sshSession isAuthorized]) {
        NSLog(@"isAuthorized");
    }
}

- (IBAction)announceButtonPressed:(UIButton *)sender {
    NSLog(@"announce");
    NSError *error;
    [self.sshSession.channel execute:@"caput IS00:INJ_WARNING_CMD 1" error:&error];
    NSLog(@"%@", error);
}


#pragma mark - UIAlertView delgate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.password = [alertView textFieldAtIndex:0].text;
        [self authenticate];
    }
}

@end
