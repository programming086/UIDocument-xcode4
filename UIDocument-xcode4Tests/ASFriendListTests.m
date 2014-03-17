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
}

- (void)tearDown
{
    _unitTestFileUrl = nil;
    _unitTestFilePath = nil;
    _fileManager = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
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
          }];
    
    // операция должна выполнена успешно и файл должен быть создан
    STAssertTrue(blockSuccess, nil);
    STAssertTrue([_fileManager fileExistsAtPath:_unitTestFilePath], nil);
}

@end