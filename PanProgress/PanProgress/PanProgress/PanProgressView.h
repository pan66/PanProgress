//
//  PanProgressView.h
//  ipadDemo
//
//  Created by panjunfeng on 2019/5/27.
//  Copyright © 2019 panjunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PanProgressView : UIView

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, strong) UIImage *trackImage;
@property (nonatomic, strong) UIImage *progressImage;

@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat minValue;
@property (nonatomic) CGFloat currentValue;

@property (nonatomic) BOOL roundedCorner;

@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UIImageView *progressImageView;


@end

NS_ASSUME_NONNULL_END
