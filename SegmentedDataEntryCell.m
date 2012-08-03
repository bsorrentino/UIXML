//
//  SegmentedDataEntryCell.m
//  UIXML
//
//  Created by Bartolomeo Sorrentino on 1/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SegmentedDataEntryCell.h"

@implementation SegmentedDataEntryCell

@synthesize segmentedField, textLabel; 


#pragma mark inherit from BaseDataEntryCell

-(void)valueChanged:(id)sender {
	
	NSLog(@"sender [%@]", sender );
	[super postEndEditingNotification];
}

-(id)init:(UIXMLFormViewController*)controller datakey:(NSString *)key label:(NSString*)label cellData:(NSDictionary*)cellData {
	
    if ((self = [super init:controller datakey:key label:label cellData:cellData])) {
        // Initialization code
		
		_segmentKeys = [cellData valueForKey:@"segmentKeys"];
		
    }
	
    return self;
	
}


-(void) setControlValue:(id)value {
	
	NSUInteger index;
	
	if (_segmentKeys==nil) {
		
		index = [(NSNumber *)value unsignedIntegerValue];
	}
	else {
		index = [_segmentKeys indexOfObject:value];
	}

	self.segmentedField.selectedSegmentIndex = index;
}

// Legge il valore dal controllo
-(id) getControlValue {
	
	NSUInteger index = self.segmentedField.selectedSegmentIndex;
	if (_segmentKeys==nil) {
		return [NSNumber numberWithUnsignedInteger:index];
	}
	else {
		return [_segmentKeys objectAtIndex:index];
	}
}

#pragma mark Inherit from UITableViewCell

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

*/
- (void)dealloc {
	[_segmentKeys release];
    [super dealloc];
}



@end
