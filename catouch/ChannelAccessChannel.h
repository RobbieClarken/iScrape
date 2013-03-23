//
//  CAChannel.h
//  EpicsTest
//
//  Created by Thomas Pelaia on 10/25/05.
//  Copyright 2005 Oak Ridge National Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChannelAccessRecord.h"
#import "ChannelAccessRecordAdaptor.h"

extern NSString *CAConnectNotification;
extern NSString *CADisconnectNotification;


typedef void (^GetRequestHandler)(ChannelAccessRecord *record);


@interface ChannelAccessChannel : NSObject {
	NSString *_name;
}


+ (id)channelWithName:(NSString *)name;
+ (id)flushIO;
+ (void)pendIO:(double)timeOut;

- (id)initWithName:(NSString *)name;
- (void)dealloc;

- (NSString *)name;

- (id)connect;
- (id)connectAndWait:(NSTimeInterval)timeout;
- (void)disconnect;
- (BOOL)isConnected;
- (id)addConnectionObserverUsingBlock:(void (^)(NSNotification *notification))block;
- (id)removeConnectionObserver:(id)observer;

- (unsigned long)getElementCount;
- (long)nativeType;

- (void)getValue:(void *)valuePtr type:(long)type withTimeout:(double)timeout;

- (void)getRecordForFlavor:(ChannelAccessRecordFlavor)recordFlavor withHandler:(GetRequestHandler)handler;

- (id)getValueForType:(long)type;
- (id)getValueForType:(long)type withTimeout:(double)timeout;

- (char)getChar;
- (char)getCharWithTimeout:(double)timeout;
- (double)getDouble;
- (double)getDoubleWithTimeout:(double)timeout;
- (float)getFloat;
- (float)getFloatWithTimeout:(double)timeout;
- (int)getInt;
- (int)getIntWithTimeout:(double)timeout;
- (short)getShort;
- (short)getShortWithTimeout:(double)timeout;
- (long)getLong;
- (long)getLongWithTimeout:(double)timeout;
- (NSString *)getString;
- (NSString *)getStringWithTimeout:(double)timeout;

- (void)getArray:(void *)buffer count:(unsigned long)count type:(long)type withTimeout:(double)timeout;

- (void)getCharArray:(char *)buffer count:(unsigned long)count;
- (void)getCharArray:(char *)buffer count:(unsigned long)count withTimeout:(double)timeout;
- (void)getDoubleArray:(double *)buffer count:(unsigned long)count;
- (void)getDoubleArray:(double *)buffer count:(unsigned long)count withTimeout:(double)timeout;
- (void)getFloatArray:(float *)buffer count:(unsigned long)count;
- (void)getFloatArray:(float *)buffer count:(unsigned long)count withTimeout:(double)timeout;
- (void)getIntArray:(int *)buffer count:(unsigned long)count;
- (void)getIntArray:(int *)buffer count:(unsigned long)count withTimeout:(double)timeout;
- (void)getShortArray:(short *)buffer count:(unsigned long)count;
- (void)getShortArray:(short *)buffer count:(unsigned long)count withTimeout:(double)timeout;
- (void)getLongArray:(long *)buffer count:(unsigned long)count;
- (void)getLongArray:(long *)buffer count:(unsigned long)count withTimeout:(double)timeout;

- (void)setValue:(void *)valuePtr dbrType:(long)dbrType commit:(BOOL)shouldCommit withTimeout:(double)timeout;

- (void)setDoubleValue:(double)value commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setDoubleValue:(double)value commit:(BOOL)shouldCommit;
- (void)setFloatValue:(float)value commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setFloatValue:(float)value commit:(BOOL)shouldCommit;
- (void)setIntValue:(int)value commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setIntValue:(int)value commit:(BOOL)shouldCommit;
- (void)setShortValue:(short)value commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setShortValue:(short)value commit:(BOOL)shouldCommit;
- (void)setLongValue:(long)value commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setLongValue:(long)value commit:(BOOL)shouldCommit;

- (void)setArray:(void *)arrayPtr length:(unsigned long)length dbrType:(long)dbrType commit:(BOOL)shouldCommit withTimeout:(double)timeout;

- (void)setDoubleArray:(double *)array length:(unsigned long)length commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setDoubleArray:(double *)array length:(unsigned long)length commit:(BOOL)shouldCommit;
- (void)setFloatArray:(float *)array length:(unsigned long)length commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setFloatArray:(float *)array length:(unsigned long)length commit:(BOOL)shouldCommit;
- (void)setIntArray:(int *)array length:(unsigned long)length commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setIntArray:(int *)array length:(unsigned long)length commit:(BOOL)shouldCommit;
- (void)setShortArray:(short *)array length:(unsigned long)length commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setShortArray:(short *)array length:(unsigned long)length commit:(BOOL)shouldCommit;
- (void)setLongArray:(long *)array length:(unsigned long)length commit:(BOOL)shouldCommit withTimeout:(double)timeout;
- (void)setLongArray:(long *)array length:(unsigned long)length commit:(BOOL)shouldCommit;

@end




@interface NSNotification (ChannelAccessChannelAdditions)

+ (NSNotification *)notificationForChannelAccessConnectionEvent:(ChannelAccessChannel *)channel;
- (ChannelAccessChannel *)channel;

@end