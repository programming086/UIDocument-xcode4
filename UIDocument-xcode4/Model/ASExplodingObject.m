//
//  ASExplodingObject.m
//  UIDocument-xcode4
//
//  Created by Brovko Roman on 17.03.14.
//  Copyright (c) 2014 AshberrySoft. All rights reserved.
//

#import "ASExplodingObject.h"

@implementation ASExplodingObject

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [NSException raise:@"ASExplodingObjectException" format:@"goes bang when unarchived"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
}

@end
