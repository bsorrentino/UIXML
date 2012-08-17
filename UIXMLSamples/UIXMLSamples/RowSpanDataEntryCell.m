//
//  RowSpanDataEntryCell.m
//  TableViewDataEntry
//
//  Created by softphone on 16/08/12.
//
//

#import "RowSpanDataEntryCell.h"
#import "UIXMLFormViewController.h"

@implementation RowSpanViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self loadFromFile:@"RowSpanForm.plist"];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
}

-(void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

@end

@implementation RowSpanDataEntryCell
@synthesize form;

- (id)init:(UIXMLFormViewController *)controller datakey:(NSString *)key label:(NSString *)label cellData:(NSDictionary *)cellData
{
    if( self = [super init:controller datakey:key label:label cellData:cellData] ) {
        
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
