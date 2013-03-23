//
//  CAException.h
//  EPICS
//
//  Created by Tom Pelaia on 11/2/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChannelAccessChannel.h"

extern NSString *CAConnectionException;
extern NSString *CAGetException;
extern NSString *CAPutException;


@interface ChannelAccessException : NSException {

}

+ (id)exceptionWithChannel:(ChannelAccessChannel *)channel name:(NSString *)name reason:(NSString *)reason;
+ (id)connectionExceptionWithChannel:(ChannelAccessChannel *)channel reason:(NSString *)reason;
+ (id)putExceptionWithChannel:(ChannelAccessChannel *)channel reason:(NSString *)reason;
+ (id)getExceptionWithChannel:(ChannelAccessChannel *)channel reason:(NSString *)reason;

- (ChannelAccessChannel *)channel;

@end
