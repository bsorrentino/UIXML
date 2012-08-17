//
//  FormData.m
//  TableViewDataEntry
//
//  Created by Bartolomeo Sorrentino on 1/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FormData.h"


@implementation FormData

@synthesize model=_model;

- (id) init {

    if( self = [super init])  {
        _model = [[NSMutableDictionary alloc] init];
	}
	return self;
}


#pragma - NSCoding implementation

- (void)encodeWithCoder:(NSCoder *)aCoder {
        
    [aCoder encodeObject:_model forKey:@"model"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if( self = [self init] ) {
    
        NSDictionary *d =  [aDecoder decodeObjectForKey:@"model"];
    
        [_model setDictionary:d];
    }
    
    return self;
}

@end