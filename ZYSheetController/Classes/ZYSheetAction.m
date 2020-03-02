//
//  ZYSheetAction.m
//  SignalWallet
//
//  Created by Zhao Yan on 2019/7/25.
//  Copyright © 2019 lotus. All rights reserved.
//

#import "ZYSheetAction.h"

@interface ZYSheetAction ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation ZYSheetAction
{
    UIFont *font;
    UIColor *textColor;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        font = [UIFont systemFontOfSize: 14];
        textColor = [UIColor systemGrayColor];
        _actionStyle = ZYSheetActionStyleDefault;
        _label = [UILabel new];
        _label.font = font;
        _label.textColor = textColor;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview: _label];
        _label.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
    }
    return self;
}

-(instancetype)init
{
    return [self initWithFrame: CGRectZero];
}

+(instancetype)new
{
    @throw @"请使用+actionWithTitle方法初始化实例对象";
}

+(instancetype)actionWithTitle:(NSString *)title actionStyle:(ZYSheetActionStyle)actionStyle completionHandler:(nonnull completionHandler)handler{
    
    ZYSheetAction *action = [[ZYSheetAction alloc] init];
    action.title = title;
    action.label.text = title;
    action.actionStyle = actionStyle;
    action.handler = handler;
    return action;
}

@end
