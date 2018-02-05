//
//  QLTT_MasterVC_iPad.h
//  SmartOffice
//
//  Created by NguyenVanTu on 5/24/17.
//  Copyright © 2017 ITSOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VOffice_Base_iPad.h"
#import "QLTT_MasterView.h"
@interface QLTT_MainVC_iPad : VOffice_Base_iPad
@property (weak, nonatomic) id<PassingMasterDocumentModel> delegate;
@property (weak, nonatomic) IBOutlet UIView *qltt_MainDetailView;
@property (weak, nonatomic) IBOutlet UIView *qltt_ContainerMasterView;

@end
