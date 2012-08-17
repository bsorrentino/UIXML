//
//  RowSpanDataEntryCell.m
//  TableViewDataEntry
//
//  Created by softphone on 16/08/12.
//
//

#import "RowSpanDataEntryCell.h"
#import "UIXMLFormViewController.h"

@implementation RowSpanDataEntryCell
@synthesize form;

- (id)init:(UIXMLFormViewController *)controller datakey:(NSString *)key label:(NSString *)label cellData:(NSDictionary *)cellData
{
    if( self = [super init:controller datakey:key label:label cellData:cellData] ) {
        
        [self.form loadFromFile:@"RowSpanForm.plist"];
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
