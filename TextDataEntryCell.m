//
//  TextDataEntryCell.m
//  TableViewDataEntry
//
//  Created by Fabrizio Guglielmino on 10/09/10.
//  Copyright 2010 Infit S.r.l. All rights reserved.
//

#import "TextDataEntryCell.h"

@interface TextDataEntryCell()

@end

NSString *const TextDataEntryCellNotification = @"TextDataEntryCell.scrollUpToKeyboard";

@implementation TextDataEntryCell

@synthesize textField;

#pragma mark - BaseDataEntryCellWithResponder implementation


-(UIResponder *)getResponder
{
    return self.textField;
}


#pragma mark - Inherit from UIView

- (void)layoutSubviews {
	[super layoutSubviews];
	
	// Rect area del textbox
	/*
	CGRect rect = CGRectMake(self.textLabel.frame.origin.x + self.textLabel.frame.size.width  + LABEL_CONTROL_PADDING, 
							 12.0, 
							 self.contentView.frame.size.width-(self.textLabel.frame.size.width + LABEL_CONTROL_PADDING + self.textLabel.frame.origin.x)-RIGHT_PADDING, 
							 25.0);
	*/
	
	CGRect rect = [super getRectRelativeToLabel:textField.frame padding:LABEL_CONTROL_PADDING rpadding:RIGHT_PADDING];
	[textField setFrame:rect];
}

#pragma mark Inherit from BaseDataEntryCell

- (void) prepareToAppear:(UIXMLFormViewController*)controller datakey:(NSString*)key cellData:(NSDictionary*)cellData{
	
    [super prepareToAppear:controller datakey:key cellData:cellData];
    
    // Initialization codex
    [cellData getStringForKey:@"placeholder" next:^(NSString * _Nonnull value) {
        [textField setPlaceholder:value];
    }];
    [cellData getStringForKey:@"secure" next:^(NSString * _Nonnull value) {
        textField.secureTextEntry = [value boolValue];
    }];
    [cellData getStringForKey:@"autocorrectionType" next:^(NSString * _Nonnull value) {
        textField.autocorrectionType =
            ( [value boolValue] ) ? UITextAutocorrectionTypeYes : UITextAutocorrectionTypeNo;
    }];
    [cellData getStringForKey:@"autocapitalizationType" next:^(NSString * _Nonnull value) {
        /*
         UITextAutocapitalizationTypeNone,
         UITextAutocapitalizationTypeWords,
         UITextAutocapitalizationTypeSentences,
         UITextAutocapitalizationTypeAllCharacters,
         */
        if( [value compare:@"None" options:NSCaseInsensitiveSearch]==NSOrderedSame ) {
            textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        } else if ( [value compare:@"Words" options:NSCaseInsensitiveSearch]==NSOrderedSame ) {
            textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        } else if ( [value compare:@"Sentences" options:NSCaseInsensitiveSearch]==NSOrderedSame ) {
            textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
        } else if ( [value compare:@"AllCharacters" options:NSCaseInsensitiveSearch]==NSOrderedSame ) {
            textField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        }
    }];
		
}

-(void) setControlValue:(id)value
{
	if (value==nil) {
		self.textField.text = @"";
	}
	else {
		self.textField.text = value;
	}
}

-(id) getControlValue
{
	return self.textField.text;
}

-(void)setEnabled:(BOOL)value {
	self.textField.enabled = value;
}

-(BOOL)enabled {
	return self.textField.enabled ;
}


#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)txtField {

	return YES;
	
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)txtField {
	if( [txtField isFirstResponder] ) {
		[txtField resignFirstResponder];
	}
	return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)txtField {
	if( [txtField isFirstResponder] ) {
		[txtField resignFirstResponder];
	}
	return YES;
	
}

- (void)textFieldDidEndEditing:(UITextField *)txtField
{
	[self postEndEditingNotification];
}



@end
