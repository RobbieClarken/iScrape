//
//  ASMonitor.m
//  iScrape
//
//  Created by Robbie Clarken on 24/03/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASMonitor.h"
#import "ChannelAccessChannel.h"

@interface ASMonitor()

@property (strong, nonatomic) ChannelAccessChannel *caChannel;
@property (strong, nonatomic) ChannelAccessMonitor *caMonitor;
@property (strong, nonatomic) id connectionObserver;

@end

@implementation ASMonitor


+ (void)monitorWithChannelName:(NSString *)channelName {
    ASMonitor *monitor = [[ASMonitor alloc] init];
    monitor.channelName = channelName;
}

- (void)connect {
    
}

- (void)disconnect {
    
}

@end
