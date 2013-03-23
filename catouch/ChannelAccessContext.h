//
//  CAContext.h
//  CATouch
//
//  Created by Tom Pelaia II on 7/6/10.
//  Copyright 2010 Oak Ridge National Lab. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ChannelAccessContext : NSObject {
}

// get the space delimitted string of channel addresses
+ (NSString *)addressList;

// set the space delimitted string of channel addresses
+ (void)setAddressList:(NSString *)addressList;

// prepare the current context creating it if needed
+ (void)prepare;

// destroy the current context
+ (void)destroy;

@end
