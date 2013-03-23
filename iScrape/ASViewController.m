//
//  ASViewController.m
//  iScrape
//
//  Created by Robbie Clarken on 23/03/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASViewController.h"
#import "ChannelAccessChannel.h"
#import "ChannelAccessMonitor.h"
#import "ASLCDLabel.h"

@interface ASViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) NSString *password;
@property (weak, nonatomic) IBOutlet ASLCDLabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scraperLabel;
@property (weak, nonatomic) IBOutlet UILabel *radLabel1;
@property (weak, nonatomic) IBOutlet UILabel *radLabel2;
@property (weak, nonatomic) IBOutlet UILabel *radLabel3;

@property (strong, nonatomic) ChannelAccessChannel *currentChannel;
@property (strong, nonatomic) ChannelAccessMonitor *currentMonitor;
@property (strong, nonatomic) id currentConnectionObserver;

@end

@implementation ASViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    if (![self.sshSession isConnected]) {
        // TODO: No connection
    }
    //[self requestPassword];
}

- (void)openChannelAccess {
    self.currentChannel = [ChannelAccessChannel channelWithName:@"SR11BCM01:CURRENT_MONITOR"];
    __weak ASViewController *weakSelf = self;
    self.currentMonitor = [ChannelAccessMonitor monitorWithChannel:self.currentChannel eventHandler:^(ChannelAccessRecord *record) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.currentLabel.text = [NSString stringWithFormat:@"%@ mA", [record formattedScalarUsingPrecision:6]];
        });
    }];
    self.currentConnectionObserver = [self.currentChannel addConnectionObserverUsingBlock:^(NSNotification *notification) {
        NSLog(@"connection observed");
    }];
    [self.currentChannel connect];
    [ChannelAccessChannel flushIO];
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
