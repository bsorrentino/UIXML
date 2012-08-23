//
//  BaseDataEntryCell.h
//  TableViewDataEntry
//
//  Created by Fabrizio Guglielmino on 10/09/10.
//  Copyright 2010 Infit S.r.l. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIXML.h"

// cell controls padding
#define LABEL_CONTROL_PADDING 5
// Control padding  
#define RIGHT_PADDING 5

// Nome della notifica di fine editing
#define CELL_ENDEDIT_NOTIFICATION_NAME @"CellEndEdit"



@class UIXMLFormViewController;

@protocol BaseDataEntryCellDelegate


// Helper per l'invio della notifica di fine editing
-(void)postEndEditingNotification;


@end

@interface BaseDataEntryCell : UITableViewCell<BaseDataEntryCellDelegate> {

}

@property (nonatomic, UIXML_WEAK) NSString *dataKey;
@property (nonatomic) BOOL enabled;

-(void)prepareToAppear:(UIXMLFormViewController*)controller datakey:(NSString*)key label:(NSString*)label cellData:(NSDictionary*)cellData;

// Imposta il valore del controllo gestito (TextField, ...)
-(void) setControlValue:(id)value;

// Legge il valore dal controllo
-(id) getControlValue;

// helper for check string
-(BOOL)isStringEmpty:(NSString*)value;

-(CGRect) getRectRelativeToLabel: (CGRect)controlFrame padding:(NSInteger)padding rpadding:(NSInteger)rpadding;


@end



@interface BaseDataEntryCellWithResponder : BaseDataEntryCell {

}

@property (nonatomic, UIXML_WEAK, readonly, getter = getResponder) UIResponder *responder;

- (void)registerForKeyboardNotifications;
- (void)unregisterForKeyboardNotifications;

@end