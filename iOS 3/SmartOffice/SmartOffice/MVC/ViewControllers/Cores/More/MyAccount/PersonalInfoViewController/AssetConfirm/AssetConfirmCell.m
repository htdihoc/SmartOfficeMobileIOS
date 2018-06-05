//
//  AssetConfirmCell.m
//  SmartOffice
//
//  Created by Vu Van Tiep on 4/28/17.
//  Copyright © 2017 Nguyen Thanh Huy. All rights reserved.
//

#import "AssetConfirmCell.h"
#import "ViewTypeDropDown.h"

@interface AssetConfirmCell()

@end

@implementation AssetConfirmCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // set ui
    [self setUserInterfaceObject:self.view_type];
    [self setUserInterfaceObject:self.text_number_not_used];
    [self setUserInterfaceObject:self.tv_reason];
    
    self.itemsArray = [NSArray arrayWithObjects: @"Báo mất", @"Báo hỏng", @"Báo không sử dụng", nil];
    self.itemsLabelArray = [NSArray arrayWithObjects: @"mất", @"hỏng", @"không sử dụng", nil];
//    _view_type.delegate = self;
//    _view_type.title = _view_type.items[0];
    _view_type.dataSource = self;
    _view_type.delegate = self;
    self.textDropDown.text = @"Báo mất";
    NSMutableAttributedString *coloredText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Số lượng mất *"]];
    
    [coloredText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(coloredText.string.length - 1, 1)];
    
    self.numberNotUseLabel.attributedText = coloredText;
    
    NSMutableAttributedString *coloredText1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Ngày mất *"]];
    
    [coloredText1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(coloredText1.string.length - 1, 1)];
    
    self.dayNotUseLabel.attributedText = coloredText1;
    _datePicker = [UIDatePicker new];
    _pickerDoneButton = [UIButton new];
    _format = [NSDateFormatter new];
    _dateFromString = [NSDate new];
    [_format setDateFormat:@"dd/MM/yyyy"];
    _dateTextField.text = [_format stringFromDate: [NSDate date]];
    _tv_reason.text = @"";
    
    [self selectDateAuto];
}

#pragma mark - MKDropdownMenuDataSource

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didOpenComponent:(NSInteger)component{
    [self.delegate sendShowDropDown];
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didCloseComponent:(NSInteger)component{
    [self.delegate sendCloseDropDown];
}

- (NSInteger)numberOfComponentsInDropdownMenu:(MKDropdownMenu *)dropdownMenu {
    return 1;
}

- (NSInteger)dropdownMenu:(MKDropdownMenu *)dropdownMenu numberOfRowsInComponent:(NSInteger)component {
    return self.itemsArray.count;
}

#pragma mark - MKDropdownMenuDelegate

//- (NSString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu titleForComponent:(NSInteger)component {
//    return self.itemsArray[component];
//}

- (UIView *)dropdownMenu:(MKDropdownMenu *)dropdownMenu viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    ViewTypeDropDown *viewTypeDropDown = (ViewTypeDropDown *)view;
    if (viewTypeDropDown == nil || ![viewTypeDropDown isKindOfClass:[ViewTypeDropDown class]]) {
        viewTypeDropDown = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ViewTypeDropDown class]) owner:nil options:nil] firstObject];
    }

    viewTypeDropDown.textLabel.text = self.itemsArray[row];
    if (row == self.typeIntDropDown) {
        viewTypeDropDown.selected = YES;
    }else {
        viewTypeDropDown.selected = NO;
    }
    return viewTypeDropDown;
    
}

- (CGFloat)dropdownMenu:(MKDropdownMenu *)dropdownMenu rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (void)dropdownMenu:(MKDropdownMenu *)dropdownMenu didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.typeIntDropDown = row;
    self.textDropDown.text = self.itemsArray[row];
    NSMutableAttributedString *coloredText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Số lượng %@ *", self.itemsLabelArray[row]]];
    
    [coloredText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(coloredText.string.length - 1, 1)];
    
    self.numberNotUseLabel.attributedText = coloredText;
    
    NSMutableAttributedString *coloredText1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Ngày %@ *", self.itemsLabelArray[row]]];
    
    [coloredText1 addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(coloredText1.string.length - 1, 1)];
    
    self.dayNotUseLabel.attributedText = coloredText1;
    [dropdownMenu closeAllComponentsAnimated:YES];
}

- (BOOL)dropdownMenu:(MKDropdownMenu *)dropdownMenu shouldUseFullRowWidthForComponent:(NSInteger)component {
    return NO;
}

//- (NSAttributedString *)dropdownMenu:(MKDropdownMenu *)dropdownMenu attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    return [[NSAttributedString alloc] initWithString:self.itemsArray[row]
//                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14 weight:UIFontWeightLight],
//                                                        NSForegroundColorAttributeName: [UIColor blackColor]}];
//}

- (IBAction)selectDateAction:(id)sender {
    _datePicker.frame = CGRectMake(0, 50, self.frame.size.width, 200);
    _datePicker.datePickerMode = UIDatePickerModeDate;
    _datePicker.backgroundColor = [UIColor whiteColor];
    [_datePicker addTarget:self action:@selector(selectDate) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_datePicker];
    [self selectDateAuto];
}

- (void) selectDateAuto {
    _dateFromString = [_format dateFromString:_dateTextField.text];
    NSTimeInterval timeInMiliseconds = [_dateFromString timeIntervalSince1970]*1000;
    _date = timeInMiliseconds;
}

- (void) selectDate {
    _dateTextField.text = [_format stringFromDate:_datePicker.date];
    _dateFromString = [_format dateFromString:_dateTextField.text];
    NSTimeInterval timeInMiliseconds = [_dateFromString timeIntervalSince1970]*1000;
    _date = timeInMiliseconds;
}

//- (void)itemSelected:(NSInteger)index {
//    _type = index + 1;
//}

- (void) setUserInterfaceObject: (UIView *)object {
    object.layer.borderWidth = 0.5;
    object.layer.borderColor = RGB(204, 204, 204).CGColor;
    object.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
