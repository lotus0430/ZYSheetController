//
//  ZYViewController.m
//  ZYSheetController
//
//  Created by lotus0430 on 03/02/2020.
//  Copyright (c) 2020 lotus0430. All rights reserved.
//

#import "ZYViewController.h"
#import <ZYSheetView.h>
@interface ZYViewController ()

@end

@implementation ZYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ZYSheetView *sheetView = [ZYSheetView sheetWithTitle: @"测试"];
    [sheetView addAction: [ZYSheetAction actionWithTitle: @"打印" actionStyle: ZYSheetActionStyleDefault completionHandler:^{
        NSLog(@"打印些什么");
    }]];
    [sheetView addAction: [ZYSheetAction actionWithTitle: @"取消" actionStyle: ZYSheetActionStyleCancel completionHandler: nil]];
    [sheetView show];
}

@end
