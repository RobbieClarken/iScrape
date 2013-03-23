//
//  PrivateUtility.h
//  EPICS
//
//  Created by Tom Pelaia on 11/11/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ChannelAccessPrivateUtility : NSObject {

}

+ (void)spawnDummyThread;
+ (void)dummyAction:(id)anObject;

@end
