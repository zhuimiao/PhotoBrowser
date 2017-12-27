//
//  ViewController.m
//  XScale
//
//  Created by boitx on 27/12/2017.
//  Copyright © 2017 boitx. All rights reserved.
//

#import "ViewController.h"
#import "HZPhotoBrowser.h"


@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) HZPhotoBrowser *browserView;
@property (nonatomic,strong) NSArray *imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.browserView];
}

- (HZPhotoBrowser *)browserView
{
    if (!_browserView) {
        _browserView = [[HZPhotoBrowser alloc] init];
        _browserView.currentImageIndex = 0;
    }
    return _browserView;
}







@end
