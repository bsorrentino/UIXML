//
//  UIXMLSamplesTests.m
//  UIXMLSamplesTests
//
//  Created by softphone on 17/08/12.
//  Copyright (c) 2012 soulsoftware. All rights reserved.
//

#import "UIXMLSamplesTests.h"
#import "FormData.h"

@implementation UIXMLSamplesTests

- (void)setUp
{
    [super setUp];
    
    d = [[FormData alloc] init];
    
    STAssertNotNil(d, @"FormData is nil");
    
    
    [d.model setValue:@"Bartolomeo" forKey:@"name"];
    [d.model setValue:@"Sorrentino" forKey:@"sname"];
}

- (void)tearDown
{
#if !__has_feature(objc_arc)
    [d release];
#endif
    [super tearDown];
}

- (void)testNSPropertyListSerialization {
    
    NSMutableArray *root = [[NSMutableArray alloc] init];
    
    [root addObject:d.model];
    
    NSString *errorDescription;
    
    NSData *data = [NSPropertyListSerialization dataFromPropertyList:root format:NSPropertyListXMLFormat_v1_0 errorDescription:&errorDescription ];
    
    STAssertNotNil(data, @"dataFromPropertyList returned nil. error [%@[", errorDescription);
    
    
    BOOL expandTilde = YES;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, expandTilde);
    
    STAssertNotNil(paths, @"paths is null");
    
    STAssertTrue([paths count] > 0 , @"paths is empty" );
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSLog(@"Dcoument paths[0]=[%@]", documentDirectory);
    
    NSString *outputPath = [documentDirectory stringByAppendingPathComponent:@"export.plist"];
    
    //BOOL writeResult = [data writeToFile:outputPath atomically:YES];
    NSError *error;
    BOOL writeResult = [data writeToFile:outputPath options:NSDataWritingAtomic error:&error];
    
    
    STAssertTrue(writeResult, @"write file [%@] failed! [%@]", outputPath, [error userInfo] );
    
    /*
     NSString *dataAsString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
     
     NSLog(@"%@", dataAsString);
     
     [dataAsString release];
     */
}


- (void)testArchiver
{
    //STFail(@"Unit tests are not implemented yet in TableViewDataEntryTests");
    
    
    NSMutableData *data = [NSMutableData data];
    
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    
    [archiver encodeObject:d forKey:@"data"];
    [archiver finishEncoding];
#if !__has_feature(objc_arc)
    [archiver release];
#endif
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc ] initForReadingWithData:data];
    
    FormData *d1 = [unarchiver decodeObjectForKey:@"data"];
    
    STAssertNotNil(d1, @"Unarchived FormData is nil");
    
    
    STAssertEqualObjects( [d1.model valueForKey:@"name"], @"Bartolomeo", @"name is different" );
    STAssertEqualObjects( [d1.model valueForKey:@"sname"], @"Sorrentino", @"sname is different" );
    
    NSString *dataAsString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    NSLog(@"%@", dataAsString);
#if !__has_feature(objc_arc)
    [dataAsString release];
#endif
}

@end
