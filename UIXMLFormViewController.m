//
//  TableViewController.m
//  TableViewDataEntry
//
//  Created by Fabrizio Guglielmino on 10/09/10.
//  Copyright 2010 Infit S.r.l. All rights reserved.
//

#import "UIXMLFormViewController.h"
#import "UIXMLFormViewControllerDelegate.h"
#import "BaseDataEntryCell.h"
#import "TextDataEntryCell.h"
#import "PushControllerDataEntryCell.h"
#import "NSBundle+UIXML.h"

@interface UIXMLFormViewController(Private) 

- (BaseDataEntryCell *_Nullable)tableView:(UITableView *_Nonnull)tableView initCellFromData:(NSDictionary *_Nonnull)cellData;
@end

@implementation UIXMLFormViewController

@synthesize resource;
@synthesize dataEntryCell;

#pragma mark custom methods

- (id)initFromFile:(NSString*)file registerNotification:(BOOL)registerNotification {
	
	id result = [super initWithStyle:UITableViewStyleGrouped];
	
	if (result!=nil) {
		[self loadFromFile:file];
	}

	if(registerNotification ) [self registerControEditingNotification];

	return result;
}

- (void)loadFromFile:(NSString*)file {
	
	if (tableStructure!=nil) {
		return ;
	}

    
    NSString *language = [NSLocale preferredLanguages][0];
    NSLog(@"default language [%@]", language );
    
    resource = [[NSBundle mainBundle] pathForResource:file
                                                         ofType:nil
                                                    inDirectory:[language stringByAppendingPathExtension:@"lproj"]];
	
    if (![[NSFileManager defaultManager] fileExistsAtPath:resource])
    {
        resource = [[NSBundle mainBundle] pathForResource:file ofType:nil];
    }
        
    tableStructure = [NSArray arrayWithContentsOfFile:resource];

	[self registerControEditingNotification];
	
	return ;
}

-(void)loadFromArray:(NSArray *)array
{
    tableStructure = [array copy];

	[self registerControEditingNotification];
}

-(NSString*)getStringInSection:(NSInteger)section {
	
	NSArray *sectionInfo = tableStructure[section];
	
	NSDictionary *sectionInfoData = sectionInfo[0];
	
	return sectionInfoData[@"label"];
	
}

-(BaseDataEntryCell*)cellForIndexPath:(NSUInteger)row section:(NSUInteger)section {
	
	NSIndexPath *ip = [NSIndexPath indexPathForRow:row inSection:section]; 
	
	BaseDataEntryCell *cell = (BaseDataEntryCell*)[self.tableView cellForRowAtIndexPath:ip];
	
	return cell;
}

- (BaseDataEntryCell *_Nullable)tableView:(UITableView *_Nonnull)tableView
                              cellFromType:(NSString *_Nonnull)cellType
                                 cellData:(NSDictionary *_Nonnull)cellData
{
    BaseDataEntryCell *cell = nil;

    NSBundle *mainBundle = [NSBundle mainBundle];
    
    @try {
        [mainBundle loadNibNamed:cellType owner:self options:nil];
    }
    @catch (NSException *exception) {
        
        @try {
            NSBundle *mBundle = [NSBundle moduleBundle];

            if( mBundle != nil ) {
                [mBundle loadNibNamed:cellType owner:self options:nil];
            }
        }
        @catch (NSException *exception) {
            
        }
    }
    
    cell = self.dataEntryCell;
    self.dataEntryCell = nil;

    return cell;
    
}

- (BaseDataEntryCell *_Nullable)tableView:(UITableView *_Nonnull)tableView initCellFromData:(NSDictionary *_Nonnull)cellData {

    NSString *dataKey = cellData[@"DataKey"];
	NSString *cellType = cellData[@"CellType"];
    
    BaseDataEntryCell *cell = (BaseDataEntryCell *)[tableView dequeueReusableCellWithIdentifier:cellType];
	
    if (cell == nil) {
    
        cell = [self tableView:tableView cellFromType:cellType cellData:cellData];
        
        if( cell == nil ) {
            return nil;
        }
        
        if ( [self respondsToSelector:@selector(cellControlDidLoad:cellData:)]) {
            [self cellControlDidLoad:cell cellData:cellData];
        }

        [cell prepareToAppear:self datakey:dataKey cellData:cellData];
        
    }
    
    return cell;
    
}

#pragma mark -
#pragma mark UIXMLFormViewControllerDelegate

-(void)cellControlDidEndEditing:(BaseDataEntryCell *)cell {

}

#pragma mark - Editing control

-(void)registerControEditingNotification {

	[[NSNotificationCenter defaultCenter]
		addObserver:self
		selector:@selector(cellControlDidEndEditingNotify:)
		name:CELL_ENDEDIT_NOTIFICATION_NAME
		object:nil];      
	
}

-(void)unregisterControEditingNotification {
	[[NSNotificationCenter defaultCenter]
		removeObserver:self
		name:CELL_ENDEDIT_NOTIFICATION_NAME
		object:nil];      
}


-(void)cellControlDidEndEditingNotify:(NSNotification *)notification
{
	NSLog(@"cellControlDidEndEditingNotify");
	
	//NSIndexPath *cellIndex = (NSIndexPath *)[notification object];
	//BaseDataEntryCell *cell = (BaseDataEntryCell *)[self.tableView cellForRowAtIndexPath:cellIndex];

	BaseDataEntryCell *cell = (BaseDataEntryCell *)[notification object];
	
	[self cellControlDidEndEditing:cell];
}



#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	
}

- (void)viewDidUnload {
	[self unregisterControEditingNotification];
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    [super viewDidUnload];
}





/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	if (tableStructure==nil) {
		return 0;
	}
	
    NSInteger section =  tableStructure.count;
	
	return section;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	if (tableStructure==nil) {
		return 0;
	}
	
	NSArray *sectionInfo = tableStructure[section];
	NSArray *sectionData = sectionInfo[1];
	
    return [sectionData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog( @"section[%ld] row [%ld]", (long)indexPath.section, (long)indexPath.row );

	NSArray *sectionInfo = tableStructure[indexPath.section];

#ifdef _TRACE	
	NSLog( @"sectionInfo [%@]", sectionInfo );
#endif

	NSArray *sectionData = sectionInfo[1];
	
#ifdef _TRACE	
	NSLog( @"sectionData [%@]", sectionData );
#endif
	
	NSDictionary *cellData = sectionData[indexPath.row];
	
#ifdef _TRACE	
	NSLog( @"cellData [%@]", cellData );
#endif
	
	BaseDataEntryCell *cell = [self tableView:tableView initCellFromData:cellData];
	
    if( cell != nil ) {
        
        if ([self respondsToSelector:@selector(cellControlDidInit:cellData:)]) {
            [self cellControlDidInit:cell cellData:cellData];
        }
    }

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

 // Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


 

#pragma mark -
#pragma mark Table view delegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *sectionInfo = tableStructure[indexPath.section];
 
    NSArray *sectionData = sectionInfo[1];
 
    NSDictionary *cellData = sectionData[indexPath.row];
 
    NSString *cellType = cellData[@"CellType"];
 
    BaseDataEntryCell *cell = [self tableView:tableView cellFromType:cellType cellData:cellData];
    
    return cell.frame.size.height;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if( self.navigationController == nil ) return;
	
    NSLog( @"section[%ld] row [%ld]", (long)indexPath.section, (long)indexPath.row );
	
	NSArray *sectionInfo = tableStructure[indexPath.section];

#ifdef _TRACE		
	NSLog( @"sectionInfo [%@]", sectionInfo );
#endif
	
	NSArray *sectionData = sectionInfo[1];
	
#ifdef _TRACE		
	NSLog( @"sectionData [%@]", sectionData );
#endif
	
	NSDictionary *cellData = sectionData[indexPath.row];
	
#ifdef _TRACE	
	NSLog( @"cellData [%@]", cellData );
#endif
	
	NSString *dataKey = cellData[@"DataKey"];
	NSString *cellType = cellData[@"CellType"];

	NSLog( @"DataKey[%@] CellType [%@]", dataKey, cellType );

	BaseDataEntryCell *cell = (BaseDataEntryCell *)[tableView cellForRowAtIndexPath:indexPath];
	if( [cell isKindOfClass:[PushControllerDataEntryCell class]] ) {
	
		PushControllerDataEntryCell *pushCell = (PushControllerDataEntryCell *)cell;
		
		// Navigation logic may go here. Create and push another view controller.
		
		UIViewController *detailViewController = [pushCell viewController:cellData];
		
		[self.navigationController pushViewController:detailViewController animated:YES];
		
		//[detailViewController release];
		
	}
}

#pragma mark > Header Management

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // fixed font style. use custom view (UILabel) if you want something different
	
	return [self getStringInSection:section];
	
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
*/

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");
    // Relinquish ownership any cached data, images, etc that aren't in use.
}



@end

#pragma mark UIXMLFormViewControllerEx implementation

@implementation UIXMLFormViewControllerEx

@synthesize delegate;

-(void)cellControlDidEndEditing:(BaseDataEntryCell *)cell {
    if( delegate!=nil && [delegate respondsToSelector:@selector(cellControlDidEndEditing:cell:)] )
    {
		[delegate cellControlDidEndEditing:cell];
	}
	
}

-(void)cellControlDidInit:(BaseDataEntryCell *)cell cellData:(NSDictionary *)cellData{
	
	if( delegate!=nil && [delegate respondsToSelector:@selector(cellControlDidInit:cellData:)]) {
		[delegate cellControlDidInit:cell cellData:cellData];
	}
	
}

-(void)cellControlDidLoad:(BaseDataEntryCell *)cell cellData:(NSDictionary *)cellData {
    
	if( delegate!=nil && [delegate respondsToSelector:@selector(cellControlDidLoad:cellData:)] ) {
		[delegate cellControlDidLoad:cell cellData:cellData];
	}
}


@end


