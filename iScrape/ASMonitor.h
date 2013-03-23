//
//  ASMonitor.h
//  iScrape
//
//  Created by Robbie Clarken on 24/03/13.
//  Copyright (c) 2013 Robbie Clarken. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChannelAccessMonitor.h"

@class ASMonitor;

@protocol ASMonitorDelegate <NSObject>

- (void)monitorUpdate:(ASMonitor *)monitor record:(ChannelAccessRecord *)record;

@end

@interface ASMonitor : NSObject

@property (strong, nonatomic) NSString *channelName;
@property (strong, nonatomic) ChannelAccessRecord *latestRecord;
@property (strong, nonatomic) id delegate;

+ (ASMonitor *)monitorWithChannelName:(NSString *)channelName;

- (void)connect;
- (void)disconnect;

@end
