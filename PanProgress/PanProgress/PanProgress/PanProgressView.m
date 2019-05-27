//
//  PanProgressView.m
//  ipadDemo
//
//  Created by panjunfeng on 2019/5/27.
//  Copyright © 2019 panjunfeng. All rights reserved.
//

#import "PanProgressView.h"

@implementation PanProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.progressView = [[UIView alloc]initWithFrame:self.bounds];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:self.progressView];
    self.progressImageView = [[UIImageView alloc]initWithFrame:self.progressView.bounds];
    self.progressImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.progressView addSubview:self.progressImageView];
    self.maxValue = 1.0f;
    self.minValue = 1.0f;
    
    if (self.progressColor) {
        self.progressView.backgroundColor = self.progressColor;
    }
    
    if (self.trackColor) {
        self.backgroundColor = self.trackColor;
    }
}
- (void)setRoundedCorner:(BOOL)roundedCorner {
    _roundedCorner = roundedCorner;
    [self updateCorner];
}

- (void)updateCorner {
    if (_roundedCorner) {
        self.progressView.layer.cornerRadius = self.frame.size.height / 2;
        self.progressView.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.masksToBounds = YES;
    }
    else {
        self.progressView.layer.cornerRadius = 0;
        self.progressView.layer.masksToBounds = NO;
        self.layer.cornerRadius = 0;
        self.layer.masksToBounds = NO;
    }
}

- (void)setMaxValue:(CGFloat)maxValue{
    _maxValue = maxValue;
    [self setNeedsLayout];
}

- (void)setMinValue:(CGFloat)minValue{
    _minValue = minValue;
    [self setNeedsLayout];
}

- (void)setCurrentValue:(CGFloat)currentValue {
    _currentValue = currentValue;
    [self setNeedsLayout];
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressView.backgroundColor = progressColor;
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    self.backgroundColor = trackColor;
}

- (void)setProgressImage:(UIImage *)progressImage {
    _progressImage = progressImage;
    self.progressImageView.image = progressImage;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateCorner];
    CGRect frame = self.progressView.frame;
    frame.origin.x = 0;
    frame.size.width = self.frame.size.width * (self.currentValue - self.minValue) / (self.maxValue - self.minValue);
    if (isnan(frame.size.width)) {
        frame.size.width = 0;
    }
    self.progressView.frame = frame;}

@end
