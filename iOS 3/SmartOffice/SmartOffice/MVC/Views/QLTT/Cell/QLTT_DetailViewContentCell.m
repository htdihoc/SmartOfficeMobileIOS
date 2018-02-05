//
//  QLTT_DetailViewContentCell_iPhone.m
//  SmartOffice
//
//  Created by NguyenVanTu on 8/7/17.
//  Copyright © 2017 ITSOL. All rights reserved.
//

#import "QLTT_DetailViewContentCell.h"
#import "UIImage+Resize.h"
#import "NSString+Util.h"
@interface QLTT_DetailViewContentCell()

@end
@implementation QLTT_DetailViewContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setFrameForTittleLB];
    _iconSecurityImg.layer.cornerRadius = 3;
    _iconSecurityImg.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (IBAction)likeDocument:(id)sender {
    [self.delegate didSelectLikeButton];
}
- (void)enterDataToView:(QLTTMasterDocumentModel *)model
{
    [self.iconSecurityImg setHidden:!model.secretLevel];
    NSString *version = [NSString stringWithFormat:@"(%@ %@)", LocalizedString(@"QLTT_MasterViewCell_Phiên_bản"), model.version];
    _lbl_Version.text = version;
    _lbl_Name.text =  model.name;
    NSString *createDate = model.createdDate;
    
    if (![createDate isEqualToString:LocalizedString(@"N/A")]) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[createDate doubleValue]/1000];
        _lbl_CreatedDate.text = [self getDateString:date];
    }else
    {
        _lbl_CreatedDate.text = LocalizedString(@"N/A");
    }
    
    _lbl_StatusName.text = model.effectStatusString;
    [self imageForStatus:_lbl_StatusName.text];
    _lbl_NumReadAndDownload.minimumScaleFactor = 0.5;
    _lbl_NumReadAndDownload.adjustsFontSizeToFitWidth = YES;
    _lbl_NumReadAndDownload.text = [NSString stringWithFormat:@"%ld/%ld", [model.numRead longValue], [model.numDownload longValue]];
    NSString *fileType = [model.fileType componentsSeparatedByString:@","].firstObject;
    if (fileType == nil) {
        fileType = @"";
    }
    fileType = fileType.lowercaseString;
    if ([fileType isImageType]) {
        fileType = @"imageFileWhite";
    }
    else if([fileType containsString:@"xls"])
    {
        fileType = @"xlsFileWhite";
    }
    else if([fileType containsString:@"ppt"])
    {
        fileType = @"pptFileWhite";
    }
    else if([fileType isVideo])
    {
        fileType = @"videoFileWhite";
    }
    else
    {
        fileType = [fileType isEqualToString:@""] ? @"otherFile" : [NSString stringWithFormat:@"%@FileWhite", [fileType lowercaseString]];
    }
    
    
    UIImage *imgType = [UIImage imageNamed:fileType];
    if (!imgType) {
        imgType = [UIImage imageNamed:@"otherFileWhite"];
    }
    _img_FileType.image = imgType;
    [self addTextToLikeLbl:[model.numLike longValue] isLike:model.isLike];
    [self loadImage:model.avatar.firstObject];
    [_info loadDataWith:model];
    [_info layoutIfNeeded];
}

- (void)loadImage:(QLTTFileAttachmentModel *)avatar
{
    NSLog(@"%@", avatar.filePath);
    if (avatar) {
        if (avatar.fileAttachmentId) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *cacheImg = [UIImage imageCache:avatar.filePath];
                if (cacheImg) {
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        self.img_Doc.image = cacheImg;
                    });
                }
                else
                {
                    [QLTT_InfoDetailController loadData:avatar.filePath completion:^(BOOL success, NSData *resultData, NSException *exception, NSDictionary *error) {
                        if (!resultData) {
                            dispatch_async(dispatch_get_main_queue(), ^(void) {
                                self.img_Doc.image = [UIImage imageNamed:@"QLTTDemo"];
                            });
                        }
                        else if([self.delegate isVisibleContentCell:self])
                        {
                            self.img_Doc.image = [UIImage imageWithImageCache:[UIImage imageWithData:resultData] key:avatar.filePath];
                        }
                    }];
                }
                
            });
        }
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.img_Doc.image = [UIImage imageNamed:@"QLTTDemo"];
        });
    }
}
- (void)addTextToLikeLbl:(long)modelNumLike isLike:(BOOL)isLike
{
    NSInteger numLike = modelNumLike;
    NSString *subString = LocalizedString(@"QLTT_DetailVC_hãy_là_người_đầu_tiên_thích_tài_liệu_này");
    [_img_Like setImage:[UIImage imageNamed:@"likeIconGray"] forState:UIControlStateNormal];
    if (numLike != 0) {
        if (isLike) {
            [_img_Like setImage:[UIImage imageNamed:@"likeIcon"] forState:UIControlStateNormal];
            numLike = numLike - 1;
            if (numLike > 0) {
                subString = [NSString stringWithFormat:@"%@ %@ %ld %@ %@", LocalizedString(@"QLTT_DetailVC_Bạn"), LocalizedString(@"QLTT_DetailVC_và"), (long)numLike, LocalizedString(@"QLTT_DetailVC_người_khác"), LocalizedString(@"QLTT_DetailVC_thích_tài_liệu_này")];
            }
            else
            {
                subString = [NSString stringWithFormat:@"%@ %@", LocalizedString(@"QLTT_DetailVC_Bạn"), LocalizedString(@"QLTT_DetailVC_thích_tài_liệu_này")];
            }
        }
        else
        {
            subString = [NSString stringWithFormat:@"%ld %@ %@", (long)numLike, LocalizedString(@"QLTT_DetailVC_người"), LocalizedString(@"QLTT_DetailVC_thích_tài_liệu_này")];
        }
        
    }
    
    _lbl_NumerLike.text = subString;
}
- (void)imageForStatus:(NSString *)status
{
    if ([status isEqualToString:@"Còn hiệu lực"]) {
        self.img_Time.image = [UIImage imageNamed:@"state1"];
        _lbl_StatusName.textColor = COLOR_FROM_HEX(0x00a651);
    }
    else if ([status isEqualToString:@"Sắp hết hiệu lực"])
    {
        self.img_Time.image = [UIImage imageNamed:@"state2"];
        _lbl_StatusName.textColor = COLOR_FROM_HEX(0xe66b29);
    }
    else if ([status isEqualToString:@"Đã hết hiệu lực"])
    {
        self.img_Time.image = [UIImage imageNamed:@"state3"];
        _lbl_StatusName.textColor = COLOR_FROM_HEX(0xff3a3a);
    }
    else
    {
        self.img_Time.image = [UIImage imageNamed:@"timer_icon"];
        _lbl_StatusName.textColor = AppColor_MainTextColor;
    }
}
- (NSString *)getDateString:(NSDate *)date
{
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"dd MMMM yyyy hh:mm"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    NSInteger month = [components month];
    NSInteger day = [components day];
    NSInteger year = [components year];
    
    return [NSString stringWithFormat:@"%02ld:%02ld - %02ld/%02ld/%ld", (long)hour, (long)minute, (long)day, (long)month, (long)year];
    
}
- (void)setFrameForTittleLB {
    _lbl_SectionTitle.font = [UIFont systemFontOfSize:14];
    _lbl_SectionTitle.backgroundColor = AppColor_MainAppBackgroundColor;
    _lbl_SectionTitle.text = LocalizedString(@"QLTT_DetailView_Cùng_chuyên_mục");
    if (IS_IPHONE) {
        self.lbl_SectionTitle.edgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    } else {
        self.lbl_SectionTitle.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}
@end
