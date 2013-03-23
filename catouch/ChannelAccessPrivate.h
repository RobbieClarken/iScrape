//
//  ChannelAccessPrivate.h
//  CATouch
//
//  Created by Tom Pelaia on 7/11/12.
//  Copyright (c) 2012 Oak Ridge National Lab. All rights reserved.
//

#ifndef CATouch_ChannelAccessPrivate_h
#define CATouch_ChannelAccessPrivate_h

#import <cadef.h>
#import "ChannelAccessChannel.h"

@interface ChannelAccessChannel ()
@property (readonly, assign) chid channelID;
@property (readonly, assign) struct ca_client_context *context;
@end


#endif
