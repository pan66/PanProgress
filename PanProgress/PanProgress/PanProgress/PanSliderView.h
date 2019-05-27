//
//  PanSliderView.h
//  ipadDemo
//
//  Created by panjunfeng on 2019/5/27.
//  Copyright © 2019 panjunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class PanSliderView;
@protocol PanSliderViewDelegate <NSObject>
@optional
- (void)sliderViewValueChangeBegin:(PanSliderView *)view;
- (void)sliderViewValueChanging:(PanSliderView *)view;
- (void)sliderViewValueChanged:(PanSliderView *)view;

@end

@interface PanSliderView : UIView

@property (nonatomic, weak) id<PanSliderViewDelegate> delegate;

@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, strong) UIImage *progressImage;

@property (nonatomic, strong) UIImage *trackBarImage;
@property (nonatomic) CGSize trackBarSize;
@property (nonatomic) CGFloat trackWidth;
@property (nonatomic) UIViewContentMode trackBarContentMode;

@property (nonatomic) CGFloat maxValue;
@property (nonatomic) CGFloat minValue;
@property (nonatomic) CGFloat currentValue;

@property (nonatomic) BOOL roundedCorner;

- (void)commonInit;

@end

NS_ASSUME_NONNULL_END
