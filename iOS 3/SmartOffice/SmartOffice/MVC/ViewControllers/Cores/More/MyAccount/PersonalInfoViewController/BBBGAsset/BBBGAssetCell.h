//
//  BBBGAssetCell.h
//  SmartOffice
//
//  Created by Vu Van Tiep on 4/27/17.
//  Copyright © 2017 Nguyen Thanh Huy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BBBGAssetCell;
@protocol BBBGAssetCellDelegate <NSObject>

- (void) customCell:(BBBGAssetCell *)cell button1Pressed:(UIButton *)btn;

@end

@interface BBBGAssetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn_view_detail;
@property (weak, nonatomic) IBOutlet UILabel *view_cell_number;

@property (weak, nonatomic) IBOutlet UIView *cellNumberView;

@property (weak, nonatomic) IBOutlet UILabel *title_goods_name;
@property (weak, nonatomic) IBOutlet UILabel *title_number;
@property (weak, nonatomic) IBOutlet UILabel *title_serial;
@property (weak, nonatomic) IBOutlet UILabel *title_status;
@property (weak, nonatomic) IBOutlet UILabel *value_goods_name;
@property (weak, nonatomic) IBOutlet UILabel *value_number;
@property (weak, nonatomic) IBOutlet UILabel *value_serial;
@property (weak, nonatomic) IBOutlet UILabel *value_status;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightTitleStatusConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightValueStatusConstrain;

@property (nonatomic, assign) id<BBBGAssetCellDelegate> delegate;

@end
