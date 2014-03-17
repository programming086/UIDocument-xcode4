//
//  ASFriendListTests.m
//  UIDocument-test
//
//  Created by Brovko Roman on 17.03.14.
//  Copyright (c) 2014 AshberrySoft. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "ASFriendList.h"
#import "ASFriend.h"

@interface ASFriendListTests : SenTestCase

@end

#define kUnitTestFileName @"ASFriendListTest.dat"

@implementation ASFriendListTests {
    NSFileManager *_fileManager;
    NSString *_unitTestFilePath;
    NSURL *_unitTestFileUrl;
    BOOL _blockCalled;
}

- (void)setUp
{
    [super setUp];
    
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [dirs objectAtIndex:0];
    
    _unitTestFilePath = [docsDir stringByAppendingPathComponent:kUnitTestFileName];
    _unitTestFileUrl = [NSURL fileURLWithPath:_unitTestFilePath];
    
    _fileManager = [NSFileManager defaultManager];
    [_fileManager removeItemAtURL:_unitTestFileUrl error:NULL];
    _blockCalled = NO;
}

- (void)tearDown
{
    _unitTestFileUrl = nil;
    _unitTestFilePath = nil;
    _fileManager = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)blockCalled {
    _blockCalled = YES;
}

- (BOOL)bloclCalledWithTimeout:(NSTimeInterval)timeout {
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:timeout];
    while (!_blockCalled && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    BOOL retval = _blockCalled;
    _blockCalled = NO; // готовы к следующему разу
    return retval;
}

- (void)testSavingCreatesFile
{
    // учитывая, что мы имеем экземпляр нашего документа
    ASFriendList *objUnderTest = [[ASFriendList alloc] initWithFileURL:_unitTestFileUrl];
    
    // когда вызываем saveToURL:forSaveOperation:completionHandler:
    __block BOOL blockSuccess = NO;
    
    [objUnderTest saveToURL:_unitTestFileUrl
           forSaveOperation:UIDocumentSaveForCreating
          completionHandler:^(BOOL success) {
              blockSuccess = YES;
              [self blockCalled];
          }];
    
    STAssertTrue([self bloclCalledWithTimeout:10], nil);
    
    // операция должна выполнена успешно и файл должен быть создан
    STAssertTrue(blockSuccess, nil);
    STAssertTrue([_fileManager fileExistsAtPath:_unitTestFilePath], nil);
}

@end
