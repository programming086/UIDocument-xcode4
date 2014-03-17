//
//  ASFriendList.m
//  UIDocument-test
//
//  Created by Brovko Roman on 27.02.14.
//  Copyright (c) 2014 AshberrySoft. All rights reserved.
//

#import "ASFriendList.h"

#define kFriendListKeyArray @"array"

@implementation ASFriendList
@synthesize friends = _friends;

- (id)initWithFileURL:(NSURL *)url {
    self = [super initWithFileURL:url];
    if (self) {
        _friends = [NSMutableArray new];
    }
    return self;
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSMutableData *data = [NSMutableData new];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:_friends forKey:kFriendListKeyArray];
    
    [archiver finishEncoding];
    return data;
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSData *data = (NSData *)contents;
    
    if (data.length == 0) {
        return NO;
    }
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    
    _friends = [unarchiver decodeObjectForKey:kFriendListKeyArray];
    
    return YES;
}

@end
