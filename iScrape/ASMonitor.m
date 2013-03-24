//
//  ASMonitor.m
//  iScrape
//
//  Created by Robbie Clarken on 24/03/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import "ASMonitor.h"
#import "ChannelAccessClient.h"

@interface ASMonitor()

@property (strong, nonatomic) ChannelAccessChannel *caChannel;
@property (strong, nonatomic) ChannelAccessMonitor *caMonitor;
@property (strong, nonatomic) id connectionObserver;

@end

@implementation ASMonitor

+ (ASMonitor *)monitorWithChannelName:(NSString *)channelName {
    ASMonitor *monitor = [[ASMonitor alloc] init];
    monitor.channelName = channelName;
    return monitor;
}

- (void)connect {
    self.caChannel = [ChannelAccessChannel channelWithName:self.channelName];
    __weak ASMonitor *weakSelf = self;
    self.caMonitor = [ChannelAccessMonitor monitorWithChannel:self.caChannel eventHandler:^(ChannelAccessRecord *record) {
        [weakSelf.delegate monitorUpdate:weakSelf record:record];
    }];
    self.connectionObserver = [self.caChannel addConnectionObserverUsingBlock:^(NSNotification *notification) {
        NSLog(@"connection observed");
    }];
    [self.caChannel connect];
    [ChannelAccessChannel flushIO];
}

- (void)disconnect {
    [self.caMonitor clear];
    [self.caChannel disconnect];
    [ChannelAccessChannel flushIO];
}

@end
