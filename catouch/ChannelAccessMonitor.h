//
//  CAMonitor.h
//  EPICS
//
//  Created by Tom Pelaia on 11/8/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChannelAccessChannel.h"
#import "ChannelAccessValueAdaptor.h"
#import "ChannelAccessRecord.h"
#import "ChannelAccessRecordAdaptor.h"


extern int CAMONITOR_VALUE_MASK;
extern int CAMONITOR_LOG_MASK;
extern int CAMONITOR_ALARM_MASK;

@class ChannelAccessMonitor;
typedef void (^MonitorEventHandler)(ChannelAccessRecord *record);


@interface ChannelAccessMonitor : NSObject {
}

@property( readonly, strong ) ChannelAccessChannel *channel;
@property( readonly, assign ) ChannelAccessRecordFlavor recordFlavor;
@property( readonly, assign ) int eventMask;
@property( readwrite, copy ) MonitorEventHandler eventHandler;

+ (ChannelAccessMonitor *)monitorWithChannel:(ChannelAccessChannel *)channel eventHandler:(MonitorEventHandler)handler;
+ (ChannelAccessMonitor *)monitorWithChannel:(ChannelAccessChannel *)channel eventHandler:(MonitorEventHandler)handler recordFlavor:(ChannelAccessRecordFlavor)flavor;
+ (ChannelAccessMonitor *)monitorWithChannel:(ChannelAccessChannel *)channel eventHandler:(MonitorEventHandler)handler recordFlavor:(ChannelAccessRecordFlavor)flavor withEventMask:(int)eventMask;

- (id)initWithChannel:(ChannelAccessChannel *)channel eventHandler:(MonitorEventHandler)handler;
- (id)initWithChannel:(ChannelAccessChannel *)channel eventHandler:(MonitorEventHandler)handler recordFlavor:(ChannelAccessRecordFlavor)recordFlavor;
- (id)initWithChannel:(ChannelAccessChannel *)channel eventHandler:(MonitorEventHandler)handler recordFlavor:(ChannelAccessRecordFlavor)recordFlavor withEventMask:(int)eventMask;

- (ChannelAccessChannel *)channel;

- (void)clear;

@end
