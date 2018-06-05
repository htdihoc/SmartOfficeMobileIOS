//
//  AssetConfirmCell.h
//  SmartOffice
//
//  Created by Vu Van Tiep on 4/28/17.
//  Copyright © 2017 Nguyen Thanh Huy. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "KPDropMenu.h"
#import "MKDropdownMenu.h"

@protocol SendCloseDropDownDelegate <NSObject>

- (void) sendShowDropDown;
- (void) sendCloseDropDown;

@end

@interface AssetConfirmCell : UITableViewCell<MKDropdownMenuDataSource, MKDropdownMenuDelegate>

//@property (weak, nonatomic) IBOutlet KPDropMenu *view_type;
@property (weak, nonatomic) IBOutlet MKDropdownMenu *view_type;
@property (weak, nonatomic) IBOutlet UILabel *textDropDown;
@property (weak, nonatomic) IBOutlet UITextField *text_number_not_used;
@property (weak, nonatomic) IBOutlet UITextView *tv_reason;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;

@property (weak, nonatomic) IBOutlet UILabel *numberNotUseLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayNotUseLabel;

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIButton *pickerDoneButton;
@property (strong, nonatomic) NSDateFormatter *format;
@property (strong, nonatomic) NSDate *dateFromString;

@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger date;
@property (nonatomic) NSInteger typeIntDropDown;
@property (nonatomic, strong) NSArray *itemsArray;
@property (nonatomic, strong) NSArray *itemsLabelArray;

@property (weak, nonatomic) id<SendCloseDropDownDelegate> delegate;

@end
