//
//  PanSliderView.m
//  ipadDemo
//
//  Created by panjunfeng on 2019/5/27.
//  Copyright © 2019 panjunfeng. All rights reserved.
//

#import "PanSliderView.h"
#import "PanProgressView.h"

@interface PanSliderView (){
    CGFloat _startX;
    CGSize _trackBarSize;
    CGFloat _trackWidth;
}

@property (nonatomic, strong) PanProgressView *progressView;
@property (nonatomic, strong) UIImageView *progressBar;
@property (nonatomic) BOOL panning;

@end

@implementation PanSliderView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.progressView = [[PanProgressView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.trackWidth)];
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.progressView];
    self.progressBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.trackBarSize.width, self.trackBarSize.height)];
    self.progressBar.userInteractionEnabled = YES;
    self.progressBar.contentMode = UIViewContentModeCenter;
    [self addSubview:self.progressBar];
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self.progressBar addGestureRecognizer:recognizer];
    self.maxValue = 1;
    self.minValue = 0;
    
    if (self.progressColor) {
        self.progressView.progressColor = self.progressColor;
    }
    
    if (self.trackColor) {
        self.progressView.trackColor = self.trackColor;
    }
    
    if (self.trackBarImage) {
        self.progressBar.image = self.trackBarImage;
    }
    
    if (self.progressImage) {
        self.progressView.progressImage = self.progressImage;
    }
}

- (CGSize)trackBarSize {
    if (CGSizeEqualToSize(_trackBarSize, CGSizeZero)) {
        _trackBarSize = CGSizeMake(10, 10);
    }
    return _trackBarSize;
}

- (CGFloat)trackWidth {
    if (_trackWidth == 0) {
        _trackWidth = 4;
    }
    return _trackWidth;
}

- (void)setTrackWidth:(CGFloat)trackWidth {
    _trackWidth = trackWidth;
    [self setNeedsLayout];
}

- (void)setTrackBarSize:(CGSize)trackBarSize {
    _trackBarSize = trackBarSize;
    [self setNeedsLayout];
}

- (void)setTrackBarImage:(UIImage *)trackBarImage {
    _trackBarImage = trackBarImage;
    self.progressBar.image = trackBarImage;
}

- (void)setTrackBarContentMode:(UIViewContentMode)trackBarContentMode {
    _trackBarContentMode = trackBarContentMode;
    self.progressBar.contentMode = trackBarContentMode;
}

- (void)panned:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //记录初始位置
        self.panning = YES;
        _startX = [gestureRecognizer locationInView:self].x;
        if ([self.delegate respondsToSelector:@selector(sliderViewValueChangeBegin:)]) {
            [self.delegate sliderViewValueChangeBegin:self];
        }
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat x = [gestureRecognizer locationInView:self].x;
        [self resetValueWithX:x];
        if ([self.delegate respondsToSelector:@selector(sliderViewValueChanging:)]) {
            [self.delegate sliderViewValueChanging:self];
        }
    }
    else {
        //结束
        self.panning = NO;
        CGFloat x = [gestureRecognizer locationInView:self].x;
        [self resetValueWithX:x];
        if ([self.delegate respondsToSelector:@selector(sliderViewValueChanged:)]) {
            [self.delegate sliderViewValueChanged:self];
        }
    }
}

- (void)resetValueWithX:(CGFloat)x {
    if (x < 0) {
        x = 0;
    }
    else if (x > self.frame.size.width) {
        x = self.frame.size.width;
    }
    CGFloat p = x / self.frame.size.width;
    CGFloat value = p * (self.maxValue - self.minValue) + self.minValue;
    _currentValue = value;
    CGPoint center = self.progressBar.center;
    center.x = x;
    self.progressBar.center = center;
    self.progressView.currentValue = value;
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    self.progressView.trackColor = trackColor;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressView.progressColor = progressColor;
}

- (void)setProgressImage:(UIImage *)progressImage {
    _progressImage = progressImage;
    self.progressView.progressImage = progressImage;
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
    self.progressView.maxValue = maxValue;
    [self setNeedsLayout];
}

- (void)setMinValue:(CGFloat)minValue {
    _minValue = minValue;
    self.progressView.minValue = minValue;
    [self setNeedsLayout];
}

- (void)setCurrentValue:(CGFloat)currentValue {
    if (self.panning) {
        return;
    }
    if (currentValue < self.minValue) {
        currentValue = self.minValue;
    }
    else if (currentValue > self.maxValue) {
        currentValue = self.maxValue;
    }
    _currentValue = currentValue;
    self.progressView.currentValue = currentValue;
    [self setNeedsLayout];
}

- (void)setRoundedCorner:(BOOL)roundedCorner {
    self.progressView.roundedCorner = roundedCorner;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.progressView.frame;
    
    frame.size.height = self.trackWidth;
    frame.origin.y = (self.frame.size.height - self.trackWidth) / 2;
    frame.size.width = self.frame.size.width;
    frame.origin.x = 0;
    self.progressView.frame = frame;
    frame = self.progressBar.frame;
    frame.size = self.trackBarSize;
    frame.origin.y = (self.frame.size.height - self.trackBarSize.height) / 2;
    CGPoint center = self.progressBar.center;
    if (isnan(self.maxValue)) {
        self.maxValue = 0;
    }
    
    CGFloat scale = self.maxValue - self.minValue;
    if (scale <= 0) {
        scale = 1;
    }
    center.x = self.frame.size.width * (self.currentValue - self.minValue) / scale;
    frame.origin.x = center.x - self.trackBarSize.width / 2;
    if (self.frame.size.width == [UIScreen mainScreen].bounds.size.width) {
        if (frame.origin.x < 0) {
            frame.origin.x = -5;
        }
    }
    
    self.progressBar.frame = frame;
}

@end
