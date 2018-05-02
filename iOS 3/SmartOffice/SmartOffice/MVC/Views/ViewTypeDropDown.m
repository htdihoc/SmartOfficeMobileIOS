//
//  ViewTypeDropDown.m
//  SmartOffice
//
//  Created by Hiep Le Dinh on 5/2/18.
//  Copyright © 2018 ITSOL. All rights reserved.
//

#import "ViewTypeDropDown.h"

@implementation ViewTypeDropDown

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.checkView.hidden = selected ? NO : YES;
}

@end
