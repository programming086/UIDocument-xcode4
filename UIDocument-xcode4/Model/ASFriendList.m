//
//  ASFriendList.m
//  UIDocument-test
//
//  Created by Brovko Roman on 27.02.14.
//  Copyright (c) 2014 AshberrySoft. All rights reserved.
//

#import "ASFriendList.h"

#define kFriendListKeyVersion @"version"
#define kFriendListKeyArray @"array"

#define kFriendListCurrentVersion 1

@implementation ASFriendList
@synthesize friends = _friends;
@synthesize loadResult = _loadResult;

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
    
    [archiver encodeInt:kFriendListCurrentVersion forKey:kFriendListKeyVersion];
    [archiver encodeObject:_friends forKey:kFriendListKeyArray];
    
    [archiver finishEncoding];
    return data;
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSData *data = (NSData *)contents;
    
    if (data.length == 0) {
        _loadResult = ASFLLR_ZERO_LENGTH_FILE;
        return NO;
    }
    
    @try {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        int version = [unarchiver decodeIntForKey:kFriendListKeyVersion];
        switch (version) {
            case kFriendListCurrentVersion:
                _friends = [unarchiver decodeObjectForKey:kFriendListKeyArray];
                break;
                
            default:
                _loadResult = ASFLLR_UNEXPECTED_VERSION;
                return NO;
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@">> %@ exception: %@", NSStringFromSelector(_cmd), exception);
        _loadResult = ASFLLR_CORRUPT_FILE;
        return NO;
    }
    
    _loadResult = ASFLLR_SUCCESS;
    return YES;
}

- (void)openWithCompletionHandler:(void (^)(BOOL))completionHandler {
    _loadResult = ASFLLR_NO_SUCH_FILE;
    [super openWithCompletionHandler:completionHandler];
}

@end
