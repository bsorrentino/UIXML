//
//  RowSpanDataEntryCell.h
//  TableViewDataEntry
//
//  Created by softphone on 16/08/12.
//
//

#import "BaseDataEntryCell.h"
#import "UIXML.h"

@class UIXMLFormViewController;

@interface RowSpanDataEntryCell : BaseDataEntryCell

@property (UIXML_WEAK, nonatomic) IBOutlet UIXMLFormViewController *form;

@end
