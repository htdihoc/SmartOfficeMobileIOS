//
//  ImageCollectionCell.h
//  SmartOffice
//
//  Created by Vu Van Tiep on 6/28/17.
//  Copyright © 2017 ITSOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image_attach;
@property (weak, nonatomic) IBOutlet UIButton *button_close;

@end
