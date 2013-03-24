//
//  ASViewController.m
//  iScrape
//
//  Created by Robbie Clarken on 23/03/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASViewController.h"
#import "ChannelAccessClient.h"
#import "ASLCDLabel.h"
#import "ASMonitor.h"

@interface ASViewController () <UIAlertViewDelegate, UIActionSheetDelegate, ASMonitorDelegate>

@property (strong, nonatomic) NSString *password;
@property (weak, nonatomic) IBOutlet ASLCDLabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *scraperLabel;
@property (weak, nonatomic) IBOutlet UILabel *radLabel1;
@property (weak, nonatomic) IBOutlet UILabel *radLabel2;
@property (weak, nonatomic) IBOutlet UILabel *radLabel3;
@property (strong, nonatomic) NSDictionary *channelNameLabels;
@property (strong, nonatomic) NSMutableDictionary *channelNameMonitors;

@property (strong, nonatomic) ASMonitor *currentMonitor;

@end

@implementation ASViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.channelNameLabels = @{
        @"SR11BCM01:CURRENT_MONITOR" : self.currentLabel,
        @"SR00IE01:DELTA_CURRENT_MONITOR": self.rateLabel,
        @"SR11SCR01:UPPER_POSITION_MONITOR": self.scraperLabel,
        @"SR02VRM01:DOSE_RATE_MONITOR": self.radLabel1,
        @"SR12NRM01:DOSE_RATE_MONITOR": self.radLabel2,
        @"SR14VRM01:DOSE_RATE_MONITOR": self.radLabel3
    };
    self.channelNameMonitors = [NSMutableDictionary dictionaryWithCapacity:[self.channelNameLabels count]];
    [self openChannelAccess];
    
    if ([self.sshSession isConnected]) {
        [self requestPassword];
    } else {
        // TODO: No connection :(
    }
}

- (void)openChannelAccess {
    for (NSString *channelName in self.channelNameLabels) {
        ASMonitor *monitor = [ASMonitor monitorWithChannelName:channelName];
        monitor.delegate = self;
        [monitor connect];
        self.channelNameMonitors[channelName] = monitor;
    }
}

- (void)closeChannelAccess {
    for (NSString *channelName in self.channelNameLabels) {
        ASMonitor *monitor = self.channelNameMonitors[channelName];
        [monitor disconnect];
    }
}

- (void)requestPassword {
    UIAlertView *passwordAlertView = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Please enter the ics password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [passwordAlertView setAlertViewStyle:UIAlertViewStyleSecureTextInput];
    [passwordAlertView show];
}

- (void)authenticate {
    [self.sshSession authenticateByPassword:self.password];
    if (![self.sshSession isAuthorized]) {
        // TODO: Handle password mistake
        if (![self.sshSession isAuthorized]) {
            [self requestPassword];
        }
    }
}

- (IBAction)scrapeButtonPressed:(UIButton *)sender {
    // TODO: Handle authentication
    UIActionSheet *warningActionSheet = [[UIActionSheet alloc] initWithTitle:@"Do you really want to scrape?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Scrape to zero" otherButtonTitles:nil];
    [warningActionSheet showInView:self.view];
}

- (void)scrape {
    NSLog(@"scrapin time");
    static NSString *ScrapeCommand = @"scrape.py y";
    // TODO: Handle errors
    [self.sshSession.channel execute:ScrapeCommand error:nil];
}

- (NSString *)textForLabel:(UILabel *)label withValue:(NSNumber *)value {
    NSString *text;
    switch (label.tag) {
        case 0:
            text = [NSString stringWithFormat:@"%.2f mA", [value floatValue]];
            break;
        case 1:
            text = [NSString stringWithFormat:@"RATE: %.2f mA/s", [value floatValue]];
            break;
        case 2:
            text = [NSString stringWithFormat:@"SCRAPER: %.2f mm", [value floatValue]];
            break;
        case 3:
            text = [NSString stringWithFormat:@"SR02 RAD: %.2f uSv", [value floatValue]];
            break;
        case 4:
            text = [NSString stringWithFormat:@"SR12 RAD: %.2f uSv", [value floatValue]];
            break;
        case 5:
            text = [NSString stringWithFormat:@"SR14 RAD: %.2f uSv", [value floatValue]];
            break;
        default:
            break;
    }
    return text;
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.password = [alertView textFieldAtIndex:0].text;
        [self authenticate];
    }
}

#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self scrape];
    }
}

#pragma mark - ASMonitor delegate

- (void)monitorUpdate:(ASMonitor *)monitor record:(ChannelAccessRecord *)record {
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *label = self.channelNameLabels[monitor.channelName];
        //label.text = [NSString stringWithFormat:@"%@ mA", [record scalarValue]];
        label.text = [self textForLabel:label withValue:[record scalarValue]];
    });
}

@end
