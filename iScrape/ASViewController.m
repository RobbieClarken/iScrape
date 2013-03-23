//
//  ASViewController.m
//  iScrape
//
//  Created by Robbie Clarken on 23/03/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASViewController.h"

@interface ASViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) NSString *password;

@end

@implementation ASViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![self.sshSession isConnected]) {
        // TODO: No connection
    }
    [self requestPassword];
}

- (void)requestPassword {
    UIAlertView *passwordAlertView = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Please enter the password to proceed" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [passwordAlertView setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [passwordAlertView show];
}

- (void)authenticate {
    [self.sshSession authenticateByPassword:self.password];
}

#pragma mark - UIAlertView delgate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.password = [alertView textFieldAtIndex:0].text;
    }
}

@end
