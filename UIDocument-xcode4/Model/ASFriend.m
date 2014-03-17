//
//  ASFriend.m
//  UIDocument-test
//
//  Created by Brovko Roman on 27.02.14.
//  Copyright (c) 2014 AshberrySoft. All rights reserved.
//

#import "ASFriend.h"

#define kFriendKeyName @"name"
#define kFriendKeyBirthdate @"birthdate"

@implementation ASFriend
@synthesize name = _name;
@synthesize birthdate = _birthdate;

#pragma mark - NSCoding methods
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:kFriendKeyName];
        _birthdate = [aDecoder decodeObjectForKey:kFriendKeyBirthdate];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kFriendKeyName];
    [aCoder encodeObject:self.birthdate forKey:kFriendKeyBirthdate];
}

@end
