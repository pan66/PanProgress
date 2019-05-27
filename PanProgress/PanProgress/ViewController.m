//
//  ViewController.m
//  PanProgress
//
//  Created by panjunfeng on 2019/5/27.
//  Copyright © 2019 panjunfeng. All rights reserved.
//

#import "ViewController.h"
#import "PanSliderView.h"
@interface ViewController ()<PanSliderViewDelegate>
{
    CGFloat time;
}
@property (nonatomic, strong)PanSliderView *progress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progress = [[PanSliderView alloc]initWithFrame:CGRectMake(20, 100, 100, 5)];
    self.progress.trackColor = [UIColor greenColor];
    self.progress.progressColor = [UIColor redColor];
    self.progress.trackBarSize = CGSizeMake(20, 38);
    self.progress.trackBarImage = [UIImage imageNamed:@"dian"];
    self.progress.progressImage = [UIImage imageNamed:@"xian"];
    self.progress.trackWidth = 5;
    self.progress.currentValue = 0;
    self.progress.delegate = self;
    self.progress.roundedCorner = YES;
    [self.view addSubview:self.progress];
    time = 0.0f;
    self.progress.currentValue = time ;
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updatePlayProgress) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
}

- (void)updatePlayProgress{
    time = time + 0.2;
    self.progress.currentValue = time ;
}
@end
