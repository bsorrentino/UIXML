//
//  ListDataEntryCell.h
//  UIXML
//
//  Created by Bartolomeo Sorrentino on 8/30/11.
//  Copyright 2011 SOUL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PushControllerDataEntryCell.h"
#import "UIXML.h"

@interface ListDataViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {

@private
    NSMutableArray *data_;
    BaseDataEntryCell *__UIXML_WEAK cell_;
    
}

@property (nonatomic,UIXML_WEAK) BaseDataEntryCell *cell;
@end

@interface ListDataEntryCell : PushControllerDataEntryCell {
    
@private 
    ListDataViewController *listViewController_;
}

@property (nonatomic,retain) IBOutlet ListDataViewController *listViewController;
@end


