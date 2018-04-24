//
//  AssetConfirmViewController.h
//  SmartOffice
//
//  Created by Vu Van Tiep on 4/28/17.
//  Copyright © 2017 Nguyen Thanh Huy. All rights reserved.
//

#import "TTNS_BaseVC.h"

@protocol AssetConfirmViewControllerDelegate
- (void)successAssetConfirmVC;
- (void)errorAssetConfirmVC;
@end

@interface AssetConfirmViewController : TTNS_BaseVC

@property (nonatomic, weak) id<AssetConfirmViewControllerDelegate>delegate;
@property (nonatomic) NSUInteger merEntityId;

//Fill du lieu
@property (strong, nonatomic) NSString *value_commodity_code;
@property (strong, nonatomic) NSString *value_commodity_name;
@property (strong, nonatomic) NSString *value_unit;
@property (strong, nonatomic) NSString *value_number;
@property (strong, nonatomic) NSString *value_serial;
@property (strong, nonatomic) NSString *value_manufacturer;
@property (strong, nonatomic) NSString *value_aspect;
@property (strong, nonatomic) NSString *value_expiry_date;
@property (strong, nonatomic) NSString *value_asset_type;
@property (strong, nonatomic) NSString *value_use_time;
@property (strong, nonatomic) NSString *value_price;
@property (strong, nonatomic) NSString *value_status;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSInteger typeKTTS;

@end
