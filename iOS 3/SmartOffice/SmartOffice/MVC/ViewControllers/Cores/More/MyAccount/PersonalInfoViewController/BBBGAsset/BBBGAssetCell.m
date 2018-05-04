//
//  BBBGAssetCell.m
//  SmartOffice
//
//  Created by Vu Van Tiep on 4/27/17.
//  Copyright © 2017 Nguyen Thanh Huy. All rights reserved.
//

#import "BBBGAssetCell.h"

@implementation BBBGAssetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cellNumberView.layer.cornerRadius = 4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)watchDetailAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:button1Pressed:)]) {
        [self.delegate customCell:self button1Pressed:sender];
    }
}

@end
