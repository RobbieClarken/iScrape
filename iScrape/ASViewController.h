//
//  ASViewController.h
//  iScrape
//
//  Created by Robbie Clarken on 23/03/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NMSSH/NMSSH.h>

@interface ASViewController : UIViewController

@property (strong, nonatomic) NMSSHSession *sshSession;

- (void)openChannelAccess;

@end
