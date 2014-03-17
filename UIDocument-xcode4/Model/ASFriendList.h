//
//  ASFriendList.h
//  UIDocument-test
//
//  Created by Brovko Roman on 27.02.14.
//  Copyright (c) 2014 AshberrySoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum eASFriendListLoadResult {
    ASFLLR_SUCCESS,
    ASFLLR_NO_SUCH_FILE,
    ASFLLR_ZERO_LENGTH_FILE,
    ASFLLR_CORRUPT_FILE,
    ASFLLR_UNEXPECTED_VERSION
} ASFriendListLoadResult;

@interface ASFriendList : UIDocument

@property (nonatomic, strong) NSMutableArray *friends;
@property (nonatomic, readonly) ASFriendListLoadResult loadResult;

@end
