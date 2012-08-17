//
//  RowSpanDataEntryCell.h
//  TableViewDataEntry
//
//  Created by softphone on 16/08/12.
//
//

#import "BaseDataEntryCell.h"
#import "UIXML.h"
#import "UIXMLFormViewController.h"


@interface RowSpanViewController : UIXMLFormViewControllerEx

@end

@interface RowSpanDataEntryCell : BaseDataEntryCell

@property (UIXML_WEAK, nonatomic) IBOutlet UITableViewController *form;

@end
